FROM astrocrpublic.azurecr.io/runtime:3.1-11

RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
  pip install --no-cache-dir dbt-snowflake==1.11.2 && \
  cd /usr/local/airflow/dbt/dbt_triplens && dbt deps && deactivate