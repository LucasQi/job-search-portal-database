# Job Search Portal Database

A relational database application for modeling a job-search and recruitment platform, built with **SQLite, SQL, Python, pandas, and Streamlit**.

This repository is a portfolio version of a collaborative academic database project completed at Stony Brook University. The system models interactions among candidates, employers, companies, jobs, skills, and job applications while providing a Streamlit interface for exploring the underlying data.

## Project Overview

The Job Search Portal Database was designed as a relational foundation for a recruitment platform. The project combines database design, integrity constraints, SQL analytics, and an interactive Python interface.

The application allows users to:

* View an overview of the database
* Search and filter available jobs
* Review job applications by status
* Explore analytical SQL queries
* Execute selected SQL queries and inspect their results through Streamlit

## Technology Stack

| Technology   | Purpose                                                                                |
| ------------ | -------------------------------------------------------------------------------------- |
| SQL          | Schema definition, constraints, joins, aggregation, subqueries, and analytical queries |
| SQLite       | Relational database engine                                                             |
| Python       | Application logic and database integration                                             |
| pandas       | SQL result retrieval and tabular data handling                                         |
| Streamlit    | Interactive web application interface                                                  |
| dbdiagram.io | ER modeling during the original project                                                |

## Database Design

The database contains nine primary tables:

| Table             | Purpose                                                              |
| ----------------- | -------------------------------------------------------------------- |
| `Industry`        | Stores industry categories                                           |
| `Company`         | Stores company information and industry relationships                |
| `EmployeeAdmin`   | Represents administrative users and supervisory relationships        |
| `Employer`        | Stores employer/recruiter information                                |
| `Job`             | Stores job postings                                                  |
| `Candidate`       | Stores job-seeker information                                        |
| `Skill`           | Defines available skills                                             |
| `CandidateSkills` | Resolves the many-to-many relationship between candidates and skills |
| `Applications`    | Resolves candidate-to-job applications and tracks application status |

The schema demonstrates relational database concepts including:

* Primary and foreign keys
* Composite primary keys
* One-to-many relationships
* Many-to-many relationships
* Self-referencing relationships
* `NOT NULL` constraints
* `UNIQUE` constraints
* `CHECK` constraints
* Default values
* Cascading update/delete behavior
* Referential integrity

## Application Features

### Database Overview

The Home page verifies the SQLite connection and displays record counts across the core database tables.

![Database Overview](docs/images/Home.png)

### Job Search and Filtering

The Browse Jobs interface allows users to filter job postings using:

* Job title, company, or location keyword
* Minimum salary
* Job type

Results combine information across the `Job`, `Employer`, `Company`, and `Industry` tables.

![Browse Jobs](docs/images/Browse-job.png)

### Applications Dashboard

The Applications Dashboard displays candidate, job, company, salary, application-status, and cover-letter information.

Users can filter results by application status.

![Applications Dashboard](docs/images/Applications-dashboard.png)

### SQL Query Demo

The application also provides an interactive interface for reviewing and executing analytical SQL queries.

![SQL Query Demo](docs/images/Query-demo.png)

The project includes ten analytical queries covering topics such as:

* Salary statistics by industry
* Candidates who have not applied to any jobs
* Candidate acceptance rates
* Jobs with zero applications
* Application acceptance rates by company
* Candidate skill distribution
* Company recruiting scorecards
* Cover-letter completion rates
* Applications to above-average-salary jobs
* Full application-pipeline reporting

## Repository Structure

```text
job-search-portal-database/
│
├── README.md
├── app.py
├── build_database.py
├── requirements.txt
├── .gitignore
│
├── job_portal_ddl.sql
├── job_portal_data.sql
├── extra_data.sql
├── job_portal_queries.sql
│
└── docs/
    └── images/
        ├── home.png
        ├── browse-jobs.png
        ├── applications-dashboard.png
        └── query-demo.png
```

## Running the Project

### 1. Clone the repository

```bash
git clone https://github.com/LucasQi/job-search-portal-database.git
cd job-search-portal-database
```

### 2. Create a virtual environment

```bash
python -m venv .venv
```

On Windows:

```bash
.venv\Scripts\activate
```

On macOS/Linux:

```bash
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Build the SQLite database

```bash
python build_database.py
```

This creates the local `job_portal.db` database using the SQL schema and sample-data files.

### 5. Run the Streamlit application

```bash
streamlit run app.py
```

Streamlit will provide a local URL that can be opened in a web browser.

## Sample Data

The repository uses synthetic sample data created for demonstration and database-testing purposes. It is intended to demonstrate relational database design, SQL querying, and application functionality rather than represent real candidates, employers, or companies.

## Collaboration and Contributions

This project was originally completed collaboratively by **Fei Qi and Ryan Allison**.

### Fei Qi

My primary contributions included:

* Preparing and testing sample database data
* Implementing and validating database constraints
* Testing database scripts and application behavior
* Building the Streamlit application interface
* Connecting the Streamlit interface to SQLite using Python and pandas
* Integrating the SQL query demonstration into the application

### Ryan Allison

Ryan's primary contributions included:

* Developing the analytical SQL queries
* Designing the ER model and relational schema
* Preparing query-result screenshots and presentation materials

The repository preserves the collaborative nature of the original project while presenting my implementation and application-development contributions as part of my technical portfolio.

## Skills Demonstrated

This project demonstrates practical experience with:

**SQL · SQLite · Relational Database Design · Data Integrity · Python · pandas · Streamlit · Data Retrieval · Data Filtering · Database Applications**

## Future Improvements

Potential extensions include:

* Moving the application to a client/server database such as PostgreSQL
* Adding candidate and employer authentication
* Supporting create, update, and delete operations through the interface
* Adding additional analytical dashboards and visualizations
* Deploying the Streamlit interface publicly
* Adding automated database and application tests

