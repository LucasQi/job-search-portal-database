import sqlite3
from pathlib import Path

import pandas as pd
import streamlit as st


DB_PATH = Path("job_portal.db")
QUERY_FILE = Path("job_portal_queries.sql")

def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn


def run_query(sql, params=()):
    with get_connection() as conn:
        return pd.read_sql_query(sql, conn, params=params)


def load_project_queries():
    if not QUERY_FILE.exists():
        return {}

    text = QUERY_FILE.read_text(encoding="utf-8")

    # Split the SQL file into separate queries by semicolon
    raw_queries = [q.strip() for q in text.split(";") if q.strip()]

    queries = {}

    for index, raw_query in enumerate(raw_queries, start=1):
        lines = raw_query.splitlines()

        # Use the first comment line as the query title if available
        title = f"Query {index}"
        if lines and lines[0].strip().startswith("--"):
            title = lines[0].replace("--", "").strip()

        # Remove comment lines from the actual SQL code
        sql_body = "\n".join(
            line for line in lines if not line.strip().startswith("--")
        ).strip()

        if sql_body:
            queries[title] = sql_body

    return queries





st.set_page_config(page_title="Job Search Portal", layout="wide")

st.title("Job Search Portal Database Interface")

if not DB_PATH.exists():
    st.error("Database file not found. Make sure job_portal.db is in the same folder as app.py.")
    st.stop()


menu = st.sidebar.radio(
    "Navigation",
    [
        "Home",
        "Browse Jobs",
        "Applications Dashboard",
        "Project Query Demo",
    ],
)


if menu == "Home":
    st.header("Database Overview")

    counts_query = """
    SELECT 'Industry' AS TableName, COUNT(*) AS RowCount FROM Industry
    UNION ALL
    SELECT 'Company', COUNT(*) FROM Company
    UNION ALL
    SELECT 'EmployeeAdmin', COUNT(*) FROM EmployeeAdmin
    UNION ALL
    SELECT 'Employer', COUNT(*) FROM Employer
    UNION ALL
    SELECT 'Job', COUNT(*) FROM Job
    UNION ALL
    SELECT 'Candidate', COUNT(*) FROM Candidate
    UNION ALL
    SELECT 'Skill', COUNT(*) FROM Skill
    UNION ALL
    SELECT 'CandidateSkills', COUNT(*) FROM CandidateSkills
    UNION ALL
    SELECT 'Applications', COUNT(*) FROM Applications;
    """

    st.dataframe(run_query(counts_query), use_container_width=True)
    st.success("Database connected successfully.")


elif menu == "Browse Jobs":
    st.header("Browse and Search Jobs")

    keyword = st.text_input("Search by job title, company, or location")

    min_salary = st.number_input(
        "Minimum salary",
        min_value=0,
        value=0,
        step=5000,
    )

    job_types_df = run_query("""
        SELECT DISTINCT JobType
        FROM Job
        ORDER BY JobType;
    """)

    job_types = ["All"] + job_types_df["JobType"].tolist()

    selected_type = st.selectbox("Job type", job_types)

    sql = """
    SELECT
        j.JobID,
        j.Title,
        co.CompanyName,
        i.IndustryName,
        j.JobType,
        j.Location,
        j.Salary,
        j.PostedDate,
        e.FirstName || ' ' || e.LastName AS EmployerContact
    FROM Job j
    INNER JOIN Employer e
        ON j.EmployerID = e.EmployerID
    INNER JOIN Company co
        ON e.CompanyID = co.CompanyID
    INNER JOIN Industry i
        ON co.IndustryID = i.IndustryID
    WHERE j.Salary >= ?
    """

    params = [min_salary]

    if keyword:
        sql += """
        AND (
            j.Title LIKE ?
            OR co.CompanyName LIKE ?
            OR j.Location LIKE ?
        )
        """
        search_value = f"%{keyword}%"
        params.extend([search_value, search_value, search_value])

    if selected_type != "All":
        sql += " AND j.JobType = ?"
        params.append(selected_type)

    sql += " ORDER BY j.Salary DESC;"

    jobs_df = run_query(sql, params)

    st.write(f"Showing {len(jobs_df)} job result(s).")
    st.dataframe(jobs_df, use_container_width=True)

elif menu == "Applications Dashboard":
    st.header("Applications Dashboard")

    status_options_df = run_query("""
        SELECT DISTINCT Status
        FROM Applications
        ORDER BY Status;
    """)

    status_options = ["All"] + status_options_df["Status"].tolist()

    selected_status = st.selectbox("Filter by application status", status_options)

    sql = """
    SELECT
        a.ApplicationID,
        c.FirstName || ' ' || c.LastName AS CandidateName,
        c.Qualification,
        j.Title AS JobTitle,
        co.CompanyName,
        j.Salary,
        a.Status,
        a.AppliedAt,
        CASE
            WHEN a.CoverLetter IS NULL THEN 'No'
            ELSE 'Yes'
        END AS HasCoverLetter
    FROM Applications a
    INNER JOIN Candidate c
        ON a.CandidateID = c.CandidateID
    INNER JOIN Job j
        ON a.JobID = j.JobID
    INNER JOIN Employer e
        ON j.EmployerID = e.EmployerID
    INNER JOIN Company co
        ON e.CompanyID = co.CompanyID
    """

    params = []

    if selected_status != "All":
        sql += " WHERE a.Status = ?"
        params.append(selected_status)

    sql += " ORDER BY a.AppliedAt DESC;"

    applications_df = run_query(sql, params)

    st.write(f"Showing {len(applications_df)} application result(s).")
    st.dataframe(applications_df, use_container_width=True)



elif menu == "Project Query Demo":
    st.header("Project Query Demo")

    st.write(
        "This page runs the 10 meaningful SQL queries used in the project presentation."
    )

    project_queries = load_project_queries()

    if not project_queries:
        st.warning("Could not find or load job_portal_queries.sql.")
    else:
        query_name = st.selectbox(
            "Choose a project query",
            list(project_queries.keys())
        )

        sql = project_queries[query_name]

        st.subheader("SQL Code")
        st.code(sql, language="sql")

        if st.button("Run Query"):
            try:
                result = run_query(sql)
                st.subheader("Query Result")
                st.dataframe(result, use_container_width=True)
                st.success("Query ran successfully.")
            except Exception as error:
                st.error(f"Query failed: {error}")