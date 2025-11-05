# TPC-H Benchmark Queries

TPC-H is a decision support benchmark that consists of a suite of business-oriented ad-hoc queries and concurrent data modifications.

## Setup

First, load the TPC-H schema and data:

```sql
-- Run setup.sql to create tables
-- Run load_data.sql to populate tables
```

## Queries

The benchmark includes 22 queries (Q1-Q22) that test various aspects of database performance:
- Complex aggregations
- Multi-table joins
- Subqueries
- Sorting and grouping

## Running the Benchmark

Execute queries in order:
```bash
databend-query < q1.sql
databend-query < q2.sql
...
```

Or use the provided benchmark runner script.
