USE iths;

DROP TABLE IF EXISTS UNF;

CREATE TABLE UNF (
        Id DECIMAL(38, 0) NOT NULL,
        Name VARCHAR(26) NOT NULL,
        Grade VARCHAR(11) NOT NULL,
        Hobbies VARCHAR(25),
        City VARCHAR(10) NOT NULL,
        School VARCHAR(30) NOT NULL,
        HomePhone VARCHAR(15),
        JobPhone VARCHAR(15),
        MobilePhone1 VARCHAR(15),
        MobilePhone2 VARCHAR(15)
) ENGINE=INNODB;

LOAD DATA INFILE '/var/lib/mysql-files/denormalized-data.csv'
INTO TABLE UNF
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/* Normlisera Student */
DROP TABLE IF EXISTS Student;

CREATE Table Student (
        StudentId INT NOT NULL AUTO_INCREMENT,
        FirstName VARCHAR(255) NOT NULL,
        LastName VARCHAR(255) NOT NULL,
	GradeId INT,
        CONSTRAINT PRIMARY KEY (StudentId)
) ENGINE=INNODB;

INSERT INTO Student (StudentId, FirstName, LastName)
SELECT DISTINCT Id, SUBSTRING_INDEX(Name, ' ', 1), SUBSTRING_INDEX(Name, ' ', -1)
FROM UNF;


/* Normalisera School */
DROP TABLE IF EXISTS School;
CREATE TABLE School AS SELECT DISTINCT 0 As SchoolId, School As Name, City FROM UNF;

SET @id = 0;
UPDATE School SET SchoolId =  (SELECT @id := @id + 1);


