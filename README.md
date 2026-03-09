# Music Release Database

A relational SQL database designed to manage music releases, contributors, genres, and metadata.  
The project demonstrates advanced SQL concepts including joins, subqueries, aggregate functions, and database triggers used for automated version tracking and metadata validation.

---

## Overview

The Music Release Database was created as part of a database systems course project.  
It models a music catalog system where users can upload music releases and track related information such as contributors, genres, labels, languages, and corrections.

The database also implements triggers to automatically maintain version history and metadata checks when records are inserted, updated, or deleted.

---

## Technologies Used

- SQL
- MySQL
- Relational Database Design
- Database Triggers
- Aggregate Queries
- Joins and Subqueries

---

## Project Structure

MusicDatabase/
│
├── schema.sql          # Database schema and table creation
├── queries.sql         # Example queries and triggers
├── README.md           # Project documentation

---

## Database Features

This system includes several key database features:

### Relational Schema
The database contains multiple related tables including:

- `Music_Release`
- `User`
- `Genre`
- `Contributor`
- `Collaboration`
- `Label`
- `Language`
- `Version_History`
- `Metadata_Check`
- `Correction`

These tables are connected using primary and foreign keys to maintain data integrity.

---

### Complex Queries

The project demonstrates advanced SQL queries such as:

- Aggregate functions (`COUNT`, `AVG`)
- Multi-table joins
- Subqueries
- Grouping and filtering
- Ordered query results

Example:

```sql
SELECT g.genre_name, COUNT(mr.music_release_id) AS total_songs
FROM Genre g
LEFT JOIN Music_Release mr ON g.genre_id = mr.genre_id
GROUP BY g.genre_name
ORDER BY total_songs DESC;
```

```markdown
## Authors

Group 11 – CS 3743
Ryan Tays
Jordan Yang
Giancarlo Flores
Robert Rittimann