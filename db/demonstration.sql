CREATE TABLE mentees (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT);

INSERT INTO mentees VALUES(1, "mentee1@test.com", "mentee1", "mentee1");
INSERT INTO mentees VALUES(2, "mentee2@test.com", "mentee2", "mentee2");

CREATE TABLE mentors (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT, firstname TEXT, lastname TEXT, domain TEXT);

INSERT INTO mentors VALUES(1, "mentor1@test.com", "mentor1", "mentor1", "John", "Smith", "COMP");
INSERT INTO mentors VALUES(2, "mentor2@test.com", "mentor2", "mentor2", "George", "Bloggs", "ENG");
INSERT INTO mentors VALUES(3, "mentor3@test.com", "mentor3", "mentor3", "Alice", "Bird", "COMP");
INSERT INTO mentors VALUES(4, "mentor4@test.com", "mentor4", "mentor4", "Jean", "Stephenson", "ENG");