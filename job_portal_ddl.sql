PRAGMA foreign_keys = ON;

CREATE TABLE Industry (
    IndustryID   INTEGER      PRIMARY KEY AUTOINCREMENT,
    IndustryName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Company (
    CompanyID   INTEGER      PRIMARY KEY AUTOINCREMENT,
    IndustryID  INTEGER      NOT NULL,
    CompanyName VARCHAR(150) NOT NULL,
    Website     VARCHAR(255),
    CEO         VARCHAR(100),
    Address     VARCHAR(255),
    FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE EmployeeAdmin (
    AdminID          INTEGER     PRIMARY KEY AUTOINCREMENT,
    Role             VARCHAR(50) NOT NULL
                         CHECK (Role IN ('Super Admin', 'Admin', 'Moderator', 'Support')),
    JoinDate         DATE        NOT NULL DEFAULT (DATE('now')),
    SupervisorID     INTEGER,
    ManagedCompanyID INTEGER,
    FOREIGN KEY (SupervisorID)     REFERENCES EmployeeAdmin(AdminID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ManagedCompanyID) REFERENCES Company(CompanyID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Employer (
    EmployerID INTEGER      PRIMARY KEY AUTOINCREMENT,
    CompanyID  INTEGER      NOT NULL,
    FirstName  VARCHAR(100) NOT NULL,
    LastName   VARCHAR(100) NOT NULL,
    Email      VARCHAR(255) NOT NULL UNIQUE,
    Phone      VARCHAR(20),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Job (
    JobID        INTEGER        PRIMARY KEY AUTOINCREMENT,
    EmployerID   INTEGER        NOT NULL,
    Title        VARCHAR(200)   NOT NULL,
    Description  TEXT,
    Salary       DECIMAL(10, 2) CHECK (Salary >= 0),
    PostedDate   TIMESTAMP      NOT NULL DEFAULT (DATETIME('now')),
    JobType      VARCHAR(20)    NOT NULL
                     CHECK (JobType IN ('Full-Time', 'Part-Time', 'Contract', 'Internship')),
    Location     VARCHAR(255)   NOT NULL,
    FOREIGN KEY (EmployerID) REFERENCES Employer(EmployerID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Candidate (
    CandidateID   INTEGER      PRIMARY KEY AUTOINCREMENT,
    FirstName     VARCHAR(100) NOT NULL,
    LastName      VARCHAR(100) NOT NULL,
    Qualification VARCHAR(50)  NOT NULL
                      CHECK (Qualification IN ('GED', 'Associates', 'Bachelors', 'Masters', 'PhD')),
    Email         VARCHAR(255) NOT NULL UNIQUE,
    Phone         VARCHAR(20)
);

CREATE TABLE Skill (
    SkillID INTEGER      PRIMARY KEY AUTOINCREMENT,
    Name    VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE CandidateSkills (
    CandidateID     INTEGER NOT NULL,
    SkillID         INTEGER NOT NULL,
    ExperienceYears INTEGER NOT NULL DEFAULT 0
                        CHECK (ExperienceYears >= 0 AND ExperienceYears <= 50),
    PRIMARY KEY (CandidateID, SkillID),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SkillID)     REFERENCES Skill(SkillID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Applications (
    ApplicationID INTEGER     PRIMARY KEY AUTOINCREMENT,
    CandidateID   INTEGER     NOT NULL,
    JobID         INTEGER     NOT NULL,
    Status        VARCHAR(20) NOT NULL DEFAULT 'Not Submitted'
                      CHECK (Status IN ('Not Submitted', 'In Progress', 'Submitted',
                                        'Under Review', 'Rejected', 'Accepted')),
    AppliedAt     TIMESTAMP   NOT NULL DEFAULT (DATETIME('now')),
    CoverLetter   TEXT,
    UNIQUE (CandidateID, JobID),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (JobID)       REFERENCES Job(JobID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
