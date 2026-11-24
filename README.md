# SQL Database Testing Portfolio

Oracle SQL / SQL*Plus practice project for an e-commerce database. Demonstrates DDL, DML, DQL, joins, subqueries, aggregates and data validation.

## Files
- 01_schema.sql: tables and constraints
- 02_sample_data.sql: synthetic test fixtures
- 03_practice_queries.sql: 40 queries with expected results
- 04_validation_test_cases.csv: database test designs
- 05_test_plan.md: scope and approach
- 06_execution_template.csv: unexecuted test log

## Optional execution
In a fresh disposable Oracle schema, run `@01_schema.sql`, `@02_sample_data.sql`, then `@03_practice_queries.sql` in SQL*Plus. Never run against production. Queries 36–40 include reversible DML or metadata checks. Expected results are derived from the sample fixtures, not observed execution results. No live database was tested. All data is fictional.
