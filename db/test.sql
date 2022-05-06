CREATE TABLE admins (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT);

INSERT INTO admins VALUES(1, "admin@admin.com", "admin", "admin");

CREATE TABLE mentees (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT, suspended INTEGER);

INSERT INTO mentees VALUES(1, "m1@sheffield.ac.uk", "mentee1", "mentee1", 0);
INSERT INTO mentees VALUES(2, "m2@sheffield.ac.uk", "mentee2", "mentee2", 0);
INSERT INTO mentees VALUES(3, "susmentee@sheffield.ac.uk", "susmentee", "susmentee", 1);

CREATE TABLE mentors (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT, firstname TEXT, lastname TEXT, domain TEXT, suspended INTEGER, availability INTEGER);

INSERT INTO mentors VALUES(1, "mentor1@test.com", "mentor1", "mentor1", "Testman", "Secondname", "COMP", 0,0);
INSERT INTO mentors VALUES(2, "mentor2@test.com", "mentor2", "mentor2", "Testlady", "Lastname", "ENG", 0,0);
INSERT INTO mentors VALUES(3, "mentor3@test.com", "mentor3", "mentor3", "Testperson", "Othername", "COMP", 0,0);
INSERT INTO mentors VALUES(4, "susmentor@test.com", "susmentor", "susmentor", "suspended", "mentor", "COMP", 1,0);

/* uses compound of mentor and mentee IDs for primary key so MUST avoid duplicate requests */
CREATE TABLE requests (mentor_id INTEGER,
                       mentee_id INTEGER,
                       time_stamp TIMESTAMP,
                       paired INTEGER,
                       PRIMARY KEY(mentor_id, mentee_id),
                       FOREIGN KEY(mentor_id) REFERENCES mentors(id) ON DELETE CASCADE
                       FOREIGN KEY(mentee_id) REFERENCES mentees(id) ON DELETE CASCADE);
INSERT INTO requests VALUES(1,1,"2021-04-25T14:46:41+00:00",0);
INSERT INTO requests VALUES(1,2,"2021-04-25T14:46:41+00:00",0);

/* mentee has made more than one request. this should be illegal but i need for test */
/*INSERT INTO requests VALUES(3,2,"2021-04-25T14:46:41+00:00",0);