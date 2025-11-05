# Aggregation and JOIN Benchmark Queries

These queries test complex aggregations and JOIN operations commonly used in analytical workloads.

## Setup

First, create the test tables:

```sql
-- Run setup.sql to create test tables with sample data
```

## Test Categories

1. **Simple Aggregations**: SUM, AVG, MIN, MAX, COUNT
2. **GROUP BY Aggregations**: Single and multi-column grouping
3. **INNER JOIN**: Two and multi-table joins
4. **LEFT/RIGHT JOIN**: Outer join operations
5. **Complex Queries**: Joins with aggregations and subqueries

## Usage

Run each SQL file to test specific operations:

```bash
databend-query < simple_aggregation.sql
databend-query < group_by_single.sql
databend-query < inner_join_two_tables.sql
```

## Performance Considerations

- Test with various data sizes (10K, 100K, 1M rows)
- Monitor memory usage during large joins
- Track query planning time vs execution time
