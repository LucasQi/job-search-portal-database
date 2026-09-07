PRAGMA foreign_keys = ON;



INSERT OR IGNORE INTO Industry (IndustryName) VALUES
    ('Hospitality'),
    ('Real Estate'),
    ('Energy'),
    ('Government'),
    ('Nonprofit'),
    ('Agriculture'),
    ('Telecommunications'),
    ('Insurance'),
    ('Legal Services'),
    ('Aerospace'),
    ('Biotechnology'),
    ('Cybersecurity'),
    ('Marketing'),
    ('Human Resources'),
    ('Sports & Recreation'),
    ('Food Services'),
    ('Automotive'),
    ('Environmental Services'),
    ('Architecture'),
    ('Research & Development');




INSERT OR IGNORE INTO Skill (Name) VALUES
    ('Customer Service'),
    ('Sales'),
    ('Public Speaking'),
    ('Leadership'),
    ('Excel'),
    ('Accounting'),
    ('Research'),
    ('Technical Writing'),
    ('Cybersecurity'),
    ('Network Administration'),
    ('Digital Marketing'),
    ('Graphic Design'),
    ('Legal Research'),
    ('AutoCAD'),
    ('Environmental Analysis');




INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Hospitality'),
    'HotelVista Group',
    'https://hotelvista.com',
    'Rebecca Stone',
    '810 Resort Ave, Miami, FL'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'HotelVista Group'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Real Estate'),
    'UrbanNest Realty',
    'https://urbannest.com',
    'Daniel Brooks',
    '44 Housing Plaza, New York, NY'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'UrbanNest Realty'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Energy'),
    'GreenVolt Energy',
    'https://greenvolt.com',
    'Grace Lin',
    '900 Solar Way, Houston, TX'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'GreenVolt Energy'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Government'),
    'CivicWorks Agency',
    'https://civicworks.gov',
    'Thomas Reed',
    '120 Public Office Rd, Albany, NY'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'CivicWorks Agency'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Nonprofit'),
    'HopeBridge Foundation',
    'https://hopebridge.org',
    'Maria Lopez',
    '55 Charity Lane, Baltimore, MD'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'HopeBridge Foundation'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Agriculture'),
    'AgriFuture Farms',
    'https://agrifuture.com',
    'Henry Wilson',
    '700 Farm Road, Des Moines, IA'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'AgriFuture Farms'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Telecommunications'),
    'SignalNet Wireless',
    'https://signalnet.com',
    'Victor Chen',
    '300 Tower Blvd, Dallas, TX'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'SignalNet Wireless'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Insurance'),
    'SecureLife Insurance',
    'https://securelife.com',
    'Patricia Gomez',
    '210 Policy St, Hartford, CT'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'SecureLife Insurance'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Legal Services'),
    'JusticePoint Legal',
    'https://justicepoint.com',
    'Edward Miller',
    '88 Law Center, Washington, DC'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'JusticePoint Legal'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Aerospace'),
    'OrbitX Aerospace',
    'https://orbitx.com',
    'Laura Kim',
    '1 Launch Dr, Cape Canaveral, FL'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'OrbitX Aerospace'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Biotechnology'),
    'BioSphere Labs',
    'https://biospherelabs.com',
    'Steven Patel',
    '350 Genome Pkwy, Cambridge, MA'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'BioSphere Labs'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Cybersecurity'),
    'ShieldCore Security',
    'https://shieldcore.com',
    'Nora Davis',
    '77 Cyber Ave, Arlington, VA'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'ShieldCore Security'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Marketing'),
    'BrandWave Marketing',
    'https://brandwave.com',
    'Oliver Scott',
    '460 Creative St, Los Angeles, CA'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'BrandWave Marketing'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Human Resources'),
    'PeopleFirst HR',
    'https://peoplefirsthr.com',
    'Janet Young',
    '22 Talent Blvd, Nashville, TN'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'PeopleFirst HR'
);

INSERT INTO Company (IndustryID, CompanyName, Website, CEO, Address)
SELECT
    (SELECT IndustryID FROM Industry WHERE IndustryName = 'Environmental Services'),
    'EcoPath Solutions',
    'https://ecopath.com',
    'Samuel Green',
    '600 Sustainability Rd, Portland, OR'
WHERE NOT EXISTS (
    SELECT 1 FROM Company WHERE CompanyName = 'EcoPath Solutions'
);




INSERT OR IGNORE INTO Employer (CompanyID, FirstName, LastName, Email, Phone) VALUES
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'HotelVista Group'), 'Benjamin', 'Stone', 'benjamin.stone@hotelvista.com', '305-555-1601'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'UrbanNest Realty'), 'Emily', 'Brooks', 'emily.brooks@urbannest.com', '212-555-1701'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'GreenVolt Energy'), 'Nathan', 'Lin', 'nathan.lin@greenvolt.com', '713-555-1801'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'CivicWorks Agency'), 'Sarah', 'Reed', 'sarah.reed@civicworks.gov', '518-555-1901'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'HopeBridge Foundation'), 'Mateo', 'Lopez', 'mateo.lopez@hopebridge.org', '410-555-2001'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'AgriFuture Farms'), 'Claire', 'Wilson', 'claire.wilson@agrifuture.com', '515-555-2101'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'SignalNet Wireless'), 'Ryan', 'Chen', 'ryan.chen@signalnet.com', '214-555-2201'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'SecureLife Insurance'), 'Sofia', 'Gomez', 'sofia.gomez@securelife.com', '860-555-2301'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'JusticePoint Legal'), 'Andrew', 'Miller', 'andrew.miller@justicepoint.com', '202-555-2401'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'OrbitX Aerospace'), 'Chloe', 'Kim', 'chloe.kim@orbitx.com', '321-555-2501'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'BioSphere Labs'), 'Eli', 'Patel', 'eli.patel@biospherelabs.com', '617-555-2601'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'ShieldCore Security'), 'Maya', 'Davis', 'maya.davis@shieldcore.com', '703-555-2701'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'BrandWave Marketing'), 'Jack', 'Scott', 'jack.scott@brandwave.com', '323-555-2801'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'PeopleFirst HR'), 'Lily', 'Young', 'lily.young@peoplefirsthr.com', '615-555-2901'),
    ((SELECT CompanyID FROM Company WHERE CompanyName = 'EcoPath Solutions'), 'Adam', 'Green', 'adam.green@ecopath.com', '503-555-3001');




INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Admin', '2025-01-10', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Admin' AND JoinDate = '2025-01-10'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Admin', '2025-01-15', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Admin' AND JoinDate = '2025-01-15'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Admin', '2025-02-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Admin' AND JoinDate = '2025-02-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-02-12', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-02-12'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-03-05', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-03-05'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-03-20', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-03-20'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-04-02', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-04-02'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-04-18', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-04-18'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-05-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-05-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-05-15', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-05-15'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-06-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-06-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-06-10', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-06-10'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-07-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-07-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-07-15', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-07-15'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-08-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-08-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-08-12', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-08-12'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Moderator', '2025-09-03', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Moderator' AND JoinDate = '2025-09-03'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-09-18', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-09-18'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-10-01', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-10-01'
);

INSERT INTO EmployeeAdmin (Role, JoinDate, SupervisorID, ManagedCompanyID)
SELECT 'Support', '2025-10-15', NULL, NULL
WHERE NOT EXISTS (
    SELECT 1 FROM EmployeeAdmin WHERE Role = 'Support' AND JoinDate = '2025-10-15'
);
