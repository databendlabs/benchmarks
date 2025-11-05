# Basic CRUD Benchmark Queries

These queries test basic Create, Read, Update, and Delete operations.

## Setup

First, create the test tables:

```sql
-- Run setup.sql to create test tables
```

## Test Categories

1. **INSERT operations**: Single and bulk inserts
2. **SELECT operations**: Simple queries with various conditions
3. **UPDATE operations**: Single and bulk updates
4. **DELETE operations**: Single and bulk deletes

## Usage

Run each SQL file to test specific CRUD operations:

```bash
databend-query < insert_single.sql
databend-query < insert_bulk.sql
databend-query < select_simple.sql
databend-query < update_single.sql
databend-query < delete_single.sql
```

## Metrics to Track

- Execution time
- Rows affected
- Memory usage
- I/O operations
