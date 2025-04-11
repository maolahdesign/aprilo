
CREATE TABLE Students (
                sid CHAR(4) NOT NULL,
                name VARCHAR(12) NOT NULL,
                tel VARCHAR(15),
                birthday DATETIME,
                CONSTRAINT Students_pk PRIMARY KEY (sid)
)
CREATE  NONCLUSTERED INDEX Students_idx
 ON Students
 ( name )


CREATE TABLE Std_Address (
                address VARCHAR(50) NOT NULL,
                sid CHAR(4) NOT NULL,
                CONSTRAINT Std_Address_pk PRIMARY KEY (address, sid)
)

CREATE TABLE Parents (
                sid CHAR(4) NOT NULL,
                name VARCHAR(12) NOT NULL,
                relationship VARCHAR(20),
                CONSTRAINT Parents_pk PRIMARY KEY (sid, name)
)

CREATE TABLE Employees (
                SSN CHAR(10) NOT NULL,
                name VARCHAR(12),
                city CHAR(5),
                street VARCHAR(30),
                tel CHAR(12),
                salary DECIMAL(8),
                insurance DECIMAL(8),
                tax DECIMAL(8),
                CONSTRAINT Employees_pk PRIMARY KEY (SSN)
)

CREATE TABLE Instructors (
                eid CHAR(4) NOT NULL,
                rank VARCHAR(10),
                department VARCHAR(5),
                SSN CHAR(10) NOT NULL,
                CONSTRAINT Instructors_pk PRIMARY KEY (eid)
)

CREATE TABLE Courses (
                c_no CHAR(5) NOT NULL,
                title VARCHAR(30),
                credits INT,
                CONSTRAINT Courses_pk PRIMARY KEY (c_no)
)

CREATE TABLE Exams (
                e_no CHAR(4) NOT NULL,
                title VARCHAR(20),
                type CHAR(10),
                c_no CHAR(5) NOT NULL,
                CONSTRAINT Exams_pk PRIMARY KEY (e_no)
)

CREATE TABLE Results (
                sid CHAR(4) NOT NULL,
                e_no CHAR(4) NOT NULL,
                grade INT,
                date DATETIME,
                CONSTRAINT Results_pk PRIMARY KEY (sid, e_no)
)

CREATE TABLE Classes (
                eid CHAR(4) NOT NULL,
                c_no CHAR(5) NOT NULL,
                sid CHAR(4) NOT NULL,
                time DATETIME,
                room VARCHAR(8),
                CONSTRAINT Classes_pk PRIMARY KEY (eid, c_no, sid)
)

ALTER TABLE Classes ADD CONSTRAINT Attend
FOREIGN KEY (sid)
REFERENCES Students (sid)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Parents ADD CONSTRAINT Dependents_of
FOREIGN KEY (sid)
REFERENCES Students (sid)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Results ADD CONSTRAINT Views
FOREIGN KEY (sid)
REFERENCES Students (sid)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Std_Address ADD CONSTRAINT Address
FOREIGN KEY (sid)
REFERENCES Students (sid)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Instructors ADD CONSTRAINT IsAn
FOREIGN KEY (SSN)
REFERENCES Employees (SSN)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Classes ADD CONSTRAINT Teaches
FOREIGN KEY (eid)
REFERENCES Instructors (eid)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Classes ADD CONSTRAINT Assign
FOREIGN KEY (c_no)
REFERENCES Courses (c_no)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Exams ADD CONSTRAINT Have
FOREIGN KEY (c_no)
REFERENCES Courses (c_no)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Results ADD CONSTRAINT Get
FOREIGN KEY (e_no)
REFERENCES Exams (e_no)
ON DELETE NO ACTION
ON UPDATE NO ACTION
