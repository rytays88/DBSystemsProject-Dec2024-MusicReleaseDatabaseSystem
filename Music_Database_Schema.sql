CREATE DATABASE IF NOT EXISTS MusicDatabase;

USE MusicDatabase;

-- Schema Definition for Music Database

-- User Table
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_role VARCHAR(20) NOT NULL
);

-- Genre Table
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL
);

-- Release_Year Table
CREATE TABLE Release_Year (
    release_year_id INT PRIMARY KEY AUTO_INCREMENT,
    release_year_name VARCHAR(50) NOT NULL
);

-- Region Table
CREATE TABLE Region (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(50) NOT NULL
);

-- Label Table
CREATE TABLE Label (
    label_id INT PRIMARY KEY AUTO_INCREMENT,
    label_name VARCHAR(50) NOT NULL
);

-- Language Table
CREATE TABLE Language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50) NOT NULL
);

-- Music_Release Table
CREATE TABLE Music_Release (
    music_release_id INT PRIMARY KEY AUTO_INCREMENT,
    music_release_title VARCHAR(255) NOT NULL,
    genre_id INT NOT NULL, 
    release_year_id INT NOT NULL,
    region_id INT NOT NULL,
    label_id INT NOT NULL,
    language_id INT NOT NULL,
    music_release_runtime VARCHAR(6) NOT NULL,   -- potentially not null
    music_release_upload_date DATE NOT NULL, 
    user_id INT NOT NULL, 

    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
    FOREIGN KEY (release_year_id) REFERENCES Release_Year(release_year_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id),
    FOREIGN KEY (label_id) REFERENCES Label(label_id),
    FOREIGN KEY (language_id) REFERENCES Language(language_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Contributor Table
CREATE TABLE Contributor (
    contributor_id INT PRIMARY KEY AUTO_INCREMENT, 
    contributor_name VARCHAR(50) NOT NULL,
    contributor_role VARCHAR(20) NOT NULL,
    contributor_verified_status ENUM('verified', 'unverified') NOT NULL
); 

-- Collaboration Table 
CREATE TABLE Collaboration (
    collab_id INT PRIMARY KEY AUTO_INCREMENT,
    music_release_id INT NOT NULL,
    contributor_id INT NOT NULL,

    UNIQUE (music_release_id, contributor_id),
    FOREIGN KEY (music_release_id) REFERENCES Music_Release(music_release_id),
    FOREIGN KEY (contributor_id) REFERENCES Contributor(contributor_id)
);

-- Correction Table
CREATE TABLE Correction (
    correction_id INT PRIMARY KEY AUTO_INCREMENT,
    correction_date DATE NOT NULL,
    correction_details TEXT NOT NULL,     -- potentially add not null to details and status
    correction_approved_status BOOLEAN NOT NULL,
    music_release_id INT NOT NULL, -- FK to music_release
    user_id INT NOT NULL, -- FK to user
    FOREIGN KEY (music_release_id) REFERENCES Music_Release(music_release_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Metadata Check Table
CREATE TABLE Metadata_Check (
  check_id INT PRIMARY KEY AUTO_INCREMENT,
  check_date DATE NOT NULL,
  check_status BOOLEAN NOT NULL,
  check_error_desc TEXT,
  music_release_id INT NOT NULL, -- FK to music_release
  FOREIGN KEY (music_release_id) REFERENCES Music_Release(music_release_id)
);

-- Version History Table
CREATE TABLE Version_History (
  version_id INT PRIMARY KEY AUTO_INCREMENT,
  version_date DATE NOT NULL,
  version_notes TEXT NOT NULL,   -- potentially add not null 
  music_release_id INT NOT NULL, -- FK to music_release
  FOREIGN KEY (music_release_id) REFERENCES Music_Release(music_release_id)
);


-- POPULATE DATABASE

-- GENRE Rows
INSERT INTO Genre (genre_name) VALUES
('Pop/R&B'),
('Rock'),
('Rap'),
('Metal'),
('Jazz'),
('Alternative'),
('Soundtrack'),
('Country'),
('Electronic'),
('Classical');

-- RELEASE_YEAR Rows
INSERT INTO Release_Year (release_year_name) VALUES 
('1970'),
('1971'),
('1972'),
('1973'),
('1974'),
('1975'),
('1976'),
('1977'),
('1978'),
('1979'),
('1980'),
('1981'),
('1982'),
('1983'),
('1984'),
('1985'),
('1986'),
('1987'),
('1988'),
('1989'),
('1990'),
('1991'),
('1992'),
('1993'),
('1994'),
('1995'),
('1996'),
('1997'),
('1998'),
('1999'),
('2000'),
('2001'),
('2002'),
('2003'),
('2004'),
('2005'),
('2006'),
('2007'),
('2008'),
('2009'),
('2010'),
('2011'),
('2012'),
('2013'),
('2014'),
('2015'),
('2016'),
('2017'),
('2018'),
('2019'),
('2020'),
('2021'),
('2022'),
('2023'),
('2024');

-- REGION Rows
INSERT INTO Region (region_name) VALUES 
('USA'),
('Europe'),
('Asia'),
('Mexico'),
('Canada');

-- LABEL Rows
INSERT INTO Label (label_name) VALUES 
('Universal Music Group'),
('Sony Music'),
('Warner Music Group'),
('Tamla Records'),
('Epic Records'),
('Factory Records'),
('Interscope Records'),
('SST Records'),
('La Luna Records'),
('Mangrove Records'),
('Unique Leader Records'),
('New Standard Elite'),
('MCA Records'),
('Arista Records'),
('Columbia Records'),
('Virgin Records'),
('Wild Rags Records');

-- LANGUAGE Rows
INSERT INTO Language (language_name) VALUES 
('English'),
('Spanish'),
('Japanese');

-- USER Rows
INSERT INTO User (user_name, user_password, user_email, user_role) VALUES 
('admin_user', 'password_hash1', 'admin@test.com', 'admin'),
('John_Smith', 'password_hash2', 'johnsmith@test.com', 'uploader'),
('Jane_Smith', 'password_hash3', 'janesmith@test.com', 'uploader'),
('Ryan_Tays', 'password_hash4', 'ryantays@test.com', 'admin');

-- MUSIC_RELEASE Rows
INSERT INTO Music_Release (music_release_title, genre_id, release_year_id, region_id, label_id, 
           language_id, music_release_runtime, music_release_upload_date, user_id)
VALUES
('Release Title #1', 1, 1, 1, 1, 1, '46:30', '2024-11-01', 2), 
('Release Title #2', 2, 2, 2, 2, 2, '27:45', '2024-11-05', 3), 
('Release Title #3', 3, 3, 3, 3, 1, '30:56', '2024-11-10', 2),
('Stevie Wonder - Innervisions', 1, 4, 1, 4, 1, '43:52', '2024-11-15', 4),
('Michael Jackson - Thriller', 1, 13, 1, 5, 1, '42:16', '2024-11-15', 4),
('Van Halen - Fair Warning', 2, 12, 1, 3, 1, '31:11', '2024-11-15', 4),
('Joy Division - Unknown Pleasures', 6, 10, 2, 6, 1, '39:28', '2024-11-16', 4),
('New Order - Power, Corruption, Lies', 6, 14, 2, 3, 1, '42:34', '2024-11-16', 4),
('Dr Dre - The Chronic ', 3, 23, 1, 7, 1, '62:52', '2024-11-16', 4),
('Snoop Dogg - Doggystyle', 3, 24, 1, 7, 1, '54:44', '2024-11-16', 4),
('Black Flag - My War', 2, 15, 1, 8, 1, '40:22', '2024-11-16', 4),
('Descendents - Milo Goes to College', 2, 13, 1, 8, 1, '22:10', '2024-11-16', 4),
('Mariya Takeuchi - Variety', 1, 15, 3, 9, 3, '42:14', '2024-11-17', 4),
('Boris - Amplifier Worship', 4, 29, 3, 10, 3, '63:52', '2024-11-17', 4),
('Disgorge - Cranial Impalement', 4, 29, 1, 11, 1, '24:07', '2024-11-18', 4),
('Cephalotripsy - Epigenetic Neurogenesis', 4, 55, 1, 12, 1, '32:17', '2024-11-18', 4),
('George Strait - Ocean Front Property', 8, 6, 1, 13, 1, '29:55', '2024-11-19', 4),
('Taxi Driver: Original Soundtrack Recording - Bernard Herrmann', 7, 6, 1, 14, 1, '61:33', '2024-11-19', 4),
('Head Hunters - Herbie Hancock', 5, 4, 1, 15, 1, '41:52', '2024-11-19', 4),
('Daft Punk - Discovery', 9, 32, 1, 16, 1, '60:50', '2024-11-19', 4),
('Blasphemy - Fallen Angel of Doom ', 4, 21, 5, 17, 1, '30:12', '2024-11-20', 4),
('Conqueror - War Cult Supremacy ', 4, 30, 5, 17, 1, '46:17', '2024-11-20', 4);


-- CONTRIBUTOR Rows
INSERT INTO Contributor (contributor_name, contributor_role, contributor_verified_status) VALUES
('Producer 1', 'producer', 'verified'),
('Mixer 1', 'mixer', 'verified'),
('Singer 1', 'vocalist', 'unverified'),
('Guitarist 1', 'instrumentalist', 'verified'),
('Eddie Van Halen', 'instrumentalist', 'verified'),
('Peter Hook', 'instrumentalist', 'verified'),
('Snoop Dogg', 'vocalist', 'verified'),
('Bill Stevenson', 'instrumentalist', 'verified'),
('Diego Sanchez', 'instrumentalist', 'verified'),
('Ryan Forster', 'instrumentalist', 'verified');

-- COLLABORATION Rows
INSERT INTO Collaboration (music_release_id, contributor_id) VALUES
(1, 1), -- Producer 1 worked on Release 1
(1, 2), -- Mixer 1 worked on Release 1 
(2, 3), -- Singer 1 worked on Release 2
(3, 4), -- Guitarist 1 worked on Release 3 
(5, 5),
(6, 5),
(7, 6),
(8, 6),
(9, 7),
(10, 7),
(11, 8),
(12, 8),
(15, 9),
(16, 9),
(21, 10),
(22, 10);

-- CORRECTION Rows 
INSERT INTO Correction (correction_date, correction_details, correction_approved_status, music_release_id, user_id) VALUES 
('2024-11-15', 'Corrected track duration for track 3.', FALSE, 1, 2), -- pending correction on John's release 
('2024-11-18', 'Added contributor details.', TRUE, 2, 3), -- approved correction on Jane's release 
('2024-11-18', 'Added contributor details.', TRUE, 5, 4), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', TRUE, 6, 4), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', TRUE, 7, 4), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', TRUE, 8, 4), -- approved correction on Ryan's release
('2024-11-18', 'Added contributor details.', TRUE, 9, 4), -- approved correction on Ryan's release  
('2024-11-18', 'Added contributor details.', TRUE, 10, 4), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', TRUE, 11, 4), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', TRUE, 12, 4), -- approved correction on Ryan's release 
('2024-11-20', 'Added contributor details.', TRUE, 15, 4), -- approved correction on Ryan's release 
('2024-11-20', 'Added contributor details.', TRUE, 16, 4), -- approved correction on Ryan's release 
('2024-11-21', 'Added contributor details.', TRUE, 21, 4), -- approved correction on Ryan's release 
('2024-11-21', 'Added contributor details.', TRUE, 22, 4); -- approved correction on Ryan's release 

-- METADATA_CHECK Rows
INSERT INTO Metadata_Check (check_date, check_status, check_error_desc, music_release_id) VALUES
('2024-11-10', TRUE, NULL, 1), -- successful Metadata check for Release 1
('2024-11-11', FALSE, 'Missing contributor verification', 2), -- failed Metadata check for Release 2
('2024-11-10', TRUE, NULL, 3), -- successful Metadata check for Release 3
('2024-11-15', TRUE, NULL, 4), -- successful Metadata check for Release 4
('2024-11-15', TRUE, NULL, 5), -- successful Metadata check for Release 5
('2024-11-15', TRUE, NULL, 6), -- successful Metadata check for Release 6
('2024-11-16', TRUE, NULL, 7), -- successful Metadata check for Release 7
('2024-11-16', TRUE, NULL, 8), -- successful Metadata check for Release 8
('2024-11-16', TRUE, NULL, 9), -- successful Metadata check for Release 9
('2024-11-16', TRUE, NULL, 10), -- successful Metadata check for Release 10
('2024-11-16', TRUE, NULL, 11), -- successful Metadata check for Release 11
('2024-11-16', TRUE, NULL, 12), -- successful Metadata check for Release 12
('2024-11-17', TRUE, NULL, 13), -- successful Metadata check for Release 13
('2024-11-17', TRUE, NULL, 14), -- successful Metadata check for Release 14
('2024-11-18', TRUE, NULL, 15), -- successful Metadata check for Release 15
('2024-11-18', TRUE, NULL, 16), -- successful Metadata check for Release 16
('2024-11-19', TRUE, NULL, 17), -- successful Metadata check for Release 17
('2024-11-19', TRUE, NULL, 18), -- successful Metadata check for Release 18
('2024-11-19', TRUE, NULL, 19), -- successful Metadata check for Release 19
('2024-11-19', TRUE, NULL, 20), -- successful Metadata check for Release 20
('2024-11-20', TRUE, NULL, 21), -- successful Metadata check for Release 21
('2024-11-20', TRUE, NULL, 22); -- successful Metadata check for Release 22

-- VERSION_HISTORY Rows
INSERT INTO Version_History (version_date, version_notes, music_release_id) VALUES
('2024-11-01', 'Initial upload', 1),
('2024-11-05', 'Initial upload', 2), 
('2024-11-10', 'Initial upload', 3), 
('2024-11-15', 'Updated runtime details', 1),
('2024-11-15', 'Initial upload', 4), 
('2024-11-15', 'Initial upload', 5), 
('2024-11-15', 'Initial upload', 6), 
('2024-11-16', 'Added collaborator Charlie Singer', 2),
('2024-11-16', 'Initial upload', 7), 
('2024-11-16', 'Initial upload', 8), 
('2024-11-16', 'Initial upload', 9), 
('2024-11-16', 'Initial upload', 10), 
('2024-11-16', 'Initial upload', 11), 
('2024-11-16', 'Initial upload', 12), 
('2024-11-17', 'Initial upload', 13), 
('2024-11-17', 'Initial upload', 14), 
('2024-11-18', 'Initial upload', 15), 
('2024-11-18', 'Initial upload', 16),
('2024-11-18', 'Added contributor details.', 5), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', 6), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', 7), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', 8), -- approved correction on Ryan's release
('2024-11-18', 'Added contributor details.', 9), -- approved correction on Ryan's release  
('2024-11-18', 'Added contributor details.', 10), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', 11), -- approved correction on Ryan's release 
('2024-11-18', 'Added contributor details.', 12), -- approved correction on Ryan's release  
('2024-11-19', 'Initial upload', 17), 
('2024-11-19', 'Initial upload', 18), 
('2024-11-19', 'Initial upload', 19), 
('2024-11-19', 'Initial upload', 20), 
('2024-11-20', 'Initial upload', 21), 
('2024-11-20', 'Initial upload', 22),
('2024-11-20', 'Added contributor details.', 15), -- approved correction on Ryan's release 
('2024-11-20', 'Added contributor details.', 16), -- approved correction on Ryan's release 
('2024-11-21', 'Added contributor details.', 21), -- approved correction on Ryan's release 
('2024-11-21', 'Added contributor details.', 22); -- approved correction on Ryan's release 