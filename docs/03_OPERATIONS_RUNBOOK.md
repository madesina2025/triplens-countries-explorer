# TripLens Countries Explorer

# Operations Runbook

**Version:** 1.0

---

# Daily Startup

### 1. Open Docker Desktop

Ensure Docker Desktop is running.

---

### 2. Open the Project

```bash
cd ~/triplens_countries_explorer
```

---

### 3. Activate the Virtual Environment

```bash
source venv/bin/activate
```

---

### 4. Load Environment Variables

```bash
source set_env.sh
```

---

### 5. Start Airflow

```bash
cd airflow

astro dev start
```

---

### 6. Verify Services

Confirm the following services are available.

| Service | Check |
|----------|-------|
| Airflow | http://localhost:8080 |
| MinIO Console | http://localhost:29101 |
| Snowflake | Connection successful |
| Docker Containers | `docker ps` |

---

### 7. Begin Development

Typical workflow:

1. Verify DAGs
2. Trigger pipeline
3. Monitor task execution
4. Validate MinIO
5. Validate Snowflake
6. Develop dbt models
7. Test changes

---

# Daily Shutdown

Stop Airflow.

```bash
astro dev stop
```

Deactivate the virtual environment.

```bash
deactivate
```

Close Docker Desktop if no longer required.

---

# Restart Services

Restart Airflow.

```bash
astro dev restart
```

---

# Switching to Another Project

Before starting another project:

- Stop Airflow.
- Stop project-specific Docker containers.
- Stop local PostgreSQL if required.
- Confirm required ports are available.

Verify:

```bash
docker ps
```

```bash
brew services list
```

---

# Daily Health Check

Confirm the following before beginning work.

- Docker Desktop running
- Virtual environment activated
- Environment variables loaded
- Airflow running
- DAGs available
- MinIO accessible
- Snowflake connected

---

# References

- `02_DEVELOPMENT_SETUP.md`
- `04_AIRFLOW_GUIDE.md`
- `05_MINIO_GUIDE.md`
- `06_SNOWFLAKE_GUIDE.md`
- `07_DBT_GUIDE.md`
- `08_TROUBLESHOOTING.md`
- `commands/command_cheatsheet.md`