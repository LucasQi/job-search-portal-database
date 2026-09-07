-- QUERY 1

SELECT
    i.IndustryName,
    COUNT(j.JobID)              AS ActiveJobCount,
    ROUND(AVG(j.Salary), 2)    AS AvgSalary,
    ROUND(MIN(j.Salary), 2)    AS MinSalary,
    ROUND(MAX(j.Salary), 2)    AS MaxSalary
FROM Industry i
INNER JOIN Company  co ON i.IndustryID  = co.IndustryID
INNER JOIN Employer e  ON co.CompanyID  = e.CompanyID
INNER JOIN Job      j  ON e.EmployerID  = j.EmployerID
GROUP BY i.IndustryName
HAVING COUNT(j.JobID) >= 2
ORDER BY AvgSalary DESC;


-- QUERY 2

SELECT
    c.CandidateID,
    c.FirstName || ' ' || c.LastName AS CandidateName,
    c.Qualification,
    c.Email
FROM Candidate c
LEFT JOIN Applications a ON c.CandidateID = a.CandidateID
WHERE a.ApplicationID IS NULL
ORDER BY c.LastName;

-- Query 3

SELECT
    c.FirstName || ' ' || c.LastName AS CandidateName,
    c.Qualification,
    COUNT(a.ApplicationID)           AS TotalApplications,
    SUM(CASE WHEN a.Status = 'Accepted'     THEN 1 ELSE 0 END) AS Accepted,
    SUM(CASE WHEN a.Status = 'Rejected'     THEN 1 ELSE 0 END) AS Rejected,
    SUM(CASE WHEN a.Status = 'Under Review' THEN 1 ELSE 0 END) AS UnderReview,
    ROUND(
        CAST(SUM(CASE WHEN a.Status = 'Accepted' THEN 1 ELSE 0 END) AS REAL)
        / NULLIF(COUNT(a.ApplicationID), 0) * 100
    , 2) AS PersonalAcceptanceRatePct
FROM Candidate c
INNER JOIN Applications a ON c.CandidateID = a.CandidateID
GROUP BY c.CandidateID
HAVING COUNT(a.ApplicationID) > 1
ORDER BY PersonalAcceptanceRatePct DESC, TotalApplications DESC;

-- Query 4

SELECT
    j.JobID,
    j.Title,
    j.JobType,
    j.Salary,
    j.Location,
    j.PostedDate,
    co.CompanyName,
    e.FirstName || ' ' || e.LastName AS RecruiterName
FROM Job       j
INNER JOIN Employer  e  ON j.EmployerID = e.EmployerID
INNER JOIN Company   co ON e.CompanyID  = co.CompanyID
LEFT  JOIN Applications a ON j.JobID    = a.JobID
WHERE a.ApplicationID IS NULL
ORDER BY j.PostedDate;

-- Query 5

SELECT 
    CompanyName,
    TotalApplications,
    Accepted,
    Rejected,
    ROUND(CAST(Accepted AS REAL) / NULLIF(TotalApplications, 0) * 100, 2) AS AcceptanceRatePct
FROM (
    SELECT
        c.CompanyName,
        COUNT(a.ApplicationID) AS TotalApplications,
        SUM(CASE WHEN a.Status = 'Accepted' THEN 1 ELSE 0 END) AS Accepted,
        SUM(CASE WHEN a.Status = 'Rejected' THEN 1 ELSE 0 END) AS Rejected  
    FROM Applications a
    INNER JOIN Job j      ON a.JobID = j.JobID
    INNER JOIN Employer e ON j.EmployerID = e.EmployerID
    INNER JOIN Company c  ON e.CompanyID = c.CompanyID 
    GROUP BY c.CompanyName
) AS AppStats
ORDER BY AcceptanceRatePct DESC;

-- Query 6

SELECT 
    s.Name AS SkillName,
    COUNT(DISTINCT cs.CandidateID) AS CandidateCount,
    ROUND(AVG(cs.ExperienceYears), 1) AS AvgExperienceYears
FROM Skill s                                      
INNER JOIN CandidateSkills cs ON s.SkillID = cs.SkillID
GROUP BY s.SkillID, s.Name                         
ORDER BY CandidateCount DESC;

-- Query 7

SELECT
    co.CompanyName,
    i.IndustryName,
    COUNT(DISTINCT e.EmployerID)        AS NumRecruiters,
    COUNT(DISTINCT j.JobID)             AS NumJobsPosted,
    COUNT(DISTINCT a.ApplicationID)     AS NumApplicationsReceived,
    ROUND(CAST(COUNT(DISTINCT a.ApplicationID) AS REAL) / NULLIF(COUNT(DISTINCT j.JobID), 0), 1) AS AvgAppsPerJob
FROM Company co
INNER JOIN Industry     i  ON co.IndustryID = i.IndustryID
INNER JOIN Employer     e  ON co.CompanyID  = e.CompanyID
LEFT  JOIN Job          j  ON e.EmployerID  = j.EmployerID
LEFT  JOIN Applications a  ON j.JobID       = a.JobID
GROUP BY co.CompanyID
ORDER BY NumApplicationsReceived DESC;

-- Query 8

SELECT
    j.Title,
    j.Location,
    j.Salary,
    co.CompanyName,
    j.PostedDate,
    (
        SELECT COUNT(*)
        FROM Applications a
        WHERE a.JobID = j.JobID
    ) AS TotalApplicants,
    (
        SELECT COUNT(*)
        FROM Applications a
        WHERE a.JobID = j.JobID
          AND a.CoverLetter IS NOT NULL
    ) AS WithCoverLetter,
    (
        SELECT COUNT(*)
        FROM Applications a
        WHERE a.JobID = j.JobID
          AND a.CoverLetter IS NULL
    ) AS WithoutCoverLetter
FROM Job j
INNER JOIN Employer e  ON j.EmployerID = e.EmployerID
INNER JOIN Company  co ON e.CompanyID  = co.CompanyID
ORDER BY TotalApplicants DESC;

-- Query 9

SELECT
    c.FirstName || ' ' || c.LastName AS CandidateName,
    c.Qualification,
    j.Title                          AS JobTitle,
    j.Salary,
    a.Status
FROM Applications a
INNER JOIN Candidate c ON a.CandidateID = c.CandidateID
INNER JOIN Job       j ON a.JobID       = j.JobID
WHERE j.Salary > (
    SELECT AVG(Salary)
    FROM Job
)
ORDER BY j.Salary DESC;

-- QUERY 10

SELECT
    a.ApplicationID,
    a.Status,
    a.AppliedAt,
    c.FirstName  || ' ' || c.LastName   AS Candidate,
    c.Qualification,
    j.Title                              AS JobTitle,
    j.JobType,
    j.Salary,
    j.Location,
    e.FirstName  || ' ' || e.LastName   AS RecruiterName,
    co.CompanyName,
    i.IndustryName
FROM Applications a
INNER JOIN Candidate c  ON a.CandidateID = c.CandidateID
INNER JOIN Job       j  ON a.JobID       = j.JobID
INNER JOIN Employer  e  ON j.EmployerID  = e.EmployerID
INNER JOIN Company   co ON e.CompanyID   = co.CompanyID
INNER JOIN Industry  i  ON co.IndustryID = i.IndustryID
ORDER BY a.AppliedAt DESC, co.CompanyName;
