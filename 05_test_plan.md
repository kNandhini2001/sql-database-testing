# Database test plan

Objective: verify data retrieval, relational integrity, constraints and calculation accuracy against synthetic fixtures.

Scope: customers, products, orders and order items; positive and negative tests, joins, aggregate totals and transaction rollback. Excludes production data, performance and security penetration testing.

Environment: disposable Oracle schema and SQL*Plus. Entry criteria: schema and fixture scripts succeed. Execute each test independently, record actual results and evidence, and roll back mutation tests. Exit criteria: all planned tests executed, discrepancies documented and retested. Current status: design only; not executed.
