/* production database for submission */
CREATE TABLE admins (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT);
INSERT INTO admins VALUES(1, "admin@admin.com", "admin", "admin");

CREATE TABLE mentees (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT, suspended INTEGER);
INSERT INTO mentees VALUES(1, "mentee1@sheffield.ac.uk", "mentee1", "mentee1", 0);
INSERT INTO mentees VALUES(2, "mentee2@sheffield.ac.uk", "mentee2", "mentee2", 0);

CREATE TABLE mentors (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT, firstname TEXT, lastname TEXT, domain TEXT, suspended INTEGER, availability INTEGER);
INSERT INTO mentors VALUES(1, "mentor1@test.com", "mentor1", "mentor1", "John", "Smith", "COMP", 0,0);
INSERT INTO mentors VALUES(2, "mentor2@test.com", "mentor2", "mentor2", "George", "Bloggs", "ENG", 0,0);
INSERT INTO mentors VALUES(3, "mentor3@test.com", "mentor3", "mentor3", "Alice", "Bird", "COMP", 0,0);

CREATE TABLE requests (mentor_id INTEGER,
                       mentee_id INTEGER,
                       time_stamp TIMESTAMP,
                       paired INTEGER,
                       PRIMARY KEY(mentor_id, mentee_id),
                       FOREIGN KEY(mentor_id) REFERENCES mentors(id) ON DELETE CASCADE
                       FOREIGN KEY(mentee_id) REFERENCES mentees(id) ON DELETE CASCADE);