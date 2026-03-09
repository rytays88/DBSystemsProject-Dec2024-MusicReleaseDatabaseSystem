-- Music Database Project - Group 11 CS 3743

-- Query 1
-- A select statement with that includes at least two aggregate functions
-- Count total number of music releases, and find the average length of all music releases

SELECT COUNT(*) AS Total_Releases,
    AVG(LENGTH(music_release_runtime)) AS Average_Runtime_Length
FROM Music_Release;

-- Query 2
-- A select statement that uses at least one join, concatenation, and distinct clause
-- Join user and genre tables to the music release table, 
-- concatenate user_name and user_email to one string,
-- and find distinct/unique combinations of uploaders and genres 

SELECT DISTINCT CONCAT(User.user_name, ' (', User.user_email, ')') AS Uploader_Info,
    Genre.genre_name AS genre
FROM Music_Release
JOIN User ON Music_Release.user_id = User.user_id
JOIN Genre ON Music_Release.genre_id = Genre.genre_id;

-- Query 3
-- A select statement that includes at least one subquery
-- Filter releases based on the genre, using a subquery to match one specific genre

SELECT music_release_title, genre_id, music_release_runtime
FROM Music_Release
WHERE genre_id = (
    SELECT genre_id
    FROM Genre
    WHERE genre_name = 'Rock'
);

-- Query 4
-- A select statement that uses an order by clause
-- Selects title, upload date, and runtime for a release, and orders by newest uploads first

SELECT music_release_title, music_release_upload_date, music_release_runtime
FROM Music_Release
ORDER BY music_release_upload_date DESC;

-- Query 5
-- An insert statement that runs a trigger in which the trigger adds data or updates data in a table
-- Trigger that will add a music release to the table 

-- Trigger
DELIMITER $$

CREATE TRIGGER AfterInsertMusicRelease
AFTER INSERT ON Music_Release
FOR EACH ROW
BEGIN
    INSERT INTO Version_History (version_date, version_notes, music_release_id)
    VALUES (NEW.music_release_upload_date, 'Initial version created', NEW.music_release_id);

    INSERT INTO Metadata_Check (check_date, check_status, check_error_desc, music_release_id) 
    VALUES (NEW.music_release_upload_date, TRUE, NULL, NEW.music_release_id);
END$$

DELIMITER ;

-- Insert Statement
INSERT INTO Music_Release (music_release_title, genre_id, release_year_id, region_id, label_id, 
           language_id, music_release_runtime, music_release_upload_date, user_id)
VALUES ('New Test Album Title', 1, 55, 1, 2, 1, '42:15', '2024-11-30', 3);

-- Query 6
-- A delete statement that runs a trigger in which the trigger deletes data in one table.
-- Trigger that will delete a music release to the table 

-- Trigger
DELIMITER $$

CREATE TRIGGER BeforeDeleteMusicRelease
BEFORE DELETE ON Music_Release
FOR EACH ROW
BEGIN
    -- delete related Collaborations to the deleted music release, and related Version History stuff
    DELETE FROM Collaboration WHERE music_release_id = OLD.music_release_id;
    
    -- Delete Statement
    DELETE FROM Metadata_Check WHERE music_release_id = OLD.music_release_id;
    DELETE FROM Version_History WHERE music_release_id = OLD.music_release_id;
END$$

DELIMITER ;

-- Delete Statement
DELETE FROM Music_Release Where music_release_id = 23;



-- TEAM CREATED QUERIES BELOW

-- Ryan(dfp041)'s created queries:
-- Query 1 (Ryan)
-- A query to show how all artists who have collaborated on 2 or more releases

SELECT Contributor.contributor_name, COUNT(Collaboration.music_release_id) AS Total_Collaborations
FROM Contributor
JOIN Collaboration on Contributor.contributor_id = Collaboration.contributor_id
GROUP BY Contributor.contributor_name
HAVING Total_Collaborations >= 2
ORDER BY Total_Collaborations DESC;

-- Query 2 (Ryan)
-- Query to update a current entry in the Music_Release table with new information
-- Requires Query 5 to run again (release 23 was deleted in query 6) prior to creation 

-- Query 5 Logic
-- An insert statement that runs a trigger in which the trigger adds data or updates data in a table
-- Trigger that will add a music release to the table (Trigger already exists, so we just use Insert here)

-- Insert Statement
INSERT INTO Music_Release (music_release_title, genre_id, release_year_id, region_id, label_id, 
           language_id, music_release_runtime, music_release_upload_date, user_id)
VALUES ('New Test Album Title', 1, 55, 1, 2, 1, '42:15', '2024-11-30', 3);

-- Query 2 (Ryan): TRIGGER FOR UPDATE
DELIMITER $$

CREATE TRIGGER AfterUpdateMusicRelease
AFTER UPDATE ON Music_Release
FOR EACH ROW
BEGIN
    -- check if a relevant update occurred
    IF OLD.music_release_title <> NEW.music_release_title
       OR OLD.music_release_upload_date <> NEW.music_release_upload_date THEN

        INSERT INTO Version_History (version_date, version_notes, music_release_id)
        VALUES (NEW.music_release_upload_date, CONCAT('Updated title to "', NEW.music_release_title, '"'), NEW.music_release_id);

        INSERT INTO Correction (correction_date, correction_details, correction_approved_status, music_release_id, user_id) 
        VALUES (NEW.music_release_upload_date, CONCAT('Updated title to "', NEW.music_release_title, '"'), TRUE, NEW.music_release_id, 2);
    END IF;
END$$

DELIMITER ;

-- Query 2 (Ryan): UPDATE STATEMENT
UPDATE Music_Release
SET 
    music_release_title = 'Sade - Promise',
    genre_id = 5,
    release_year_id = 16,
    region_id = 2,
    label_id = 5,
    language_id = 1,
    music_release_runtime = '54:10',
    music_release_upload_date = '2024-12-2',
    user_id = 4
WHERE music_release_id = 24;



-- Jordan Yang (maj092) - Queries
-- Query 1 (Jordan):
-- Lists all corrections from '@User'
SELECT 
    c.correction_date,
    c.correction_details,
    mr.music_release_title,
    u.user_name
FROM 
    Correction c
JOIN Music_Release mr ON c.music_release_id = mr.music_release_id
JOIN User u ON c.user_id = u.user_id
WHERE 
    c.correction_approved_status = FALSE AND u.user_name = 'John_Smith';


-- Query 2 (Jordan):
-- Shows every genre in DB and # of Songs in each Genre
SELECT 
    g.genre_name,
    COUNT(mr.music_release_id) AS total_songs
FROM 
    Genre g
LEFT JOIN Music_Release mr ON g.genre_id = mr.genre_id
GROUP BY 
    g.genre_name
ORDER BY 
    total_songs DESC;



-- Giancarlo Flores, ida347
-- Queries

-- Query 1 (Giancarlo)
-- Lists all songs from the database which are longer than 45 mins

SELECT music_release_title, music_release_runtime
FROM Music_Release
WHERE TIME_TO_SEC(music_release_runtime) > 2700;

-- Query 2 (Giancarlo)
-- Counts the number of songs in different languages

SELECT 
    l.language_name AS Language,
    COUNT(mr.music_release_id) AS Song_Count
FROM 
    Music_Release mr
JOIN 
    Language l
ON 
    mr.language_id = l.language_id
GROUP BY 
    l.language_name
ORDER BY 
    Song_Count DESC;



-- Robert Rittimann (lut421) - Queries
-- Query 1 (Robert):
-- shows corrections that have been approved
SELECT 
    c.correction_date,
    c.correction_details,
    c.correction_approved_status,
    mr.music_release_title,
    u.user_name 
FROM Correction c
JOIN Music_Release mr ON c.music_release_id = mr.music_release_id
JOIN User u ON c.user_id = u.user_id
WHERE 
    c.correction_approved_status = TRUE;


-- Query 2 (Robert):
-- Lists all songs from specified label 'Warner Music Goup'
SELECT
    mr.music_release_title,
    l.label_name
FROM Music_Release mr
JOIN Label l ON mr.label_id = l.label_id
WHERE l.label_id = 3;