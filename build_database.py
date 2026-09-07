import sqlite3
from pathlib import Path


DB_PATH = Path("job_portal.db")
SCHEMA_PATH = Path("job_portal_ddl.sql")
DATA_PATH = Path("job_portal_data.sql")
EXTRA_DATA_PATH = Path("extra_data.sql")


def execute_script(connection, path):
    script = path.read_text(encoding="utf-8")
    connection.executescript(script)


def main():
    # Rebuild the database from scratch
    if DB_PATH.exists():
        DB_PATH.unlink()

    with sqlite3.connect(DB_PATH) as connection:
        connection.execute("PRAGMA foreign_keys = ON;")

        execute_script(connection, SCHEMA_PATH)
        execute_script(connection, DATA_PATH)

        if EXTRA_DATA_PATH.exists():
            execute_script(connection, EXTRA_DATA_PATH)

        connection.commit()

    print(f"Database created successfully: {DB_PATH}")


if __name__ == "__main__":
    main()