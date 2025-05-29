CREATE TABLE Person (
    name VARCHAR(30) NOT NULL CHECK (LENGTH(name) <= 30 AND name LIKE '%_'),
    age INT CHECK (age > 0),
    PRIMARY KEY (name)
);

CREATE TABLE User (
    person_name VARCHAR(30),
    PRIMARY KEY (person_name),
    FOREIGN KEY (person_name) REFERENCES Person(name)
);

CREATE TABLE Admin (
    person_name VARCHAR(30),
    PRIMARY KEY (person_name),
    FOREIGN KEY (person_name) REFERENCES User(person_name)
);

CREATE TABLE Moderator (
    person_name VARCHAR(30),
    PRIMARY KEY (person_name),
    FOREIGN KEY (person_name) REFERENCES User(person_name)
);

CREATE TABLE Content (
    type VARCHAR(50) CHECK (
        LENGTH(type) < 50 AND (
            type LIKE 'текст%' OR type LIKE 'зображення%' OR type LIKE 'відео%'
        )
    ),
    status VARCHAR(10) CHECK (status IN ('активний', 'видалений')),
    PRIMARY KEY (type)
);

CREATE TABLE File (
    content_type VARCHAR(50),
    size INT CHECK (size > 0),
    format VARCHAR(10) CHECK (
        LENGTH(format) < 10 AND (
            format = 'jpg' OR format = 'png' OR format = 'mp4' OR format = 'pdf'
        )
    ),
    PRIMARY KEY (content_type, format),
    FOREIGN KEY (content_type) REFERENCES Content(type)
);

CREATE TABLE Deletion_history (
    content_type VARCHAR(50),
    date DATE,
    reason VARCHAR(200) CHECK (LENGTH(reason) < 200),
    PRIMARY KEY (content_type, date),
    FOREIGN KEY (content_type) REFERENCES Content(type)
);

CREATE TABLE Rule_violation (
    content_type VARCHAR(50),
    type_violation VARCHAR(50) CHECK (LENGTH(type_violation) < 50),
    PRIMARY KEY (content_type, type_violation),
    FOREIGN KEY (content_type) REFERENCES Content(type)
);

CREATE TABLE Notification (
    notice VARCHAR(500) CHECK (
        LENGTH(notice) < 500 AND notice LIKE '%_'
    ),
    PRIMARY KEY (notice)
);
