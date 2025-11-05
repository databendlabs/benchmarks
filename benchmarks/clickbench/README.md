# ClickBench Benchmark Queries

ClickBench is a benchmark for analytical databases that uses real web analytics data.

## Setup

First, load the ClickBench schema and data:

```sql
-- Run setup.sql to create the hits table
-- Load the hits dataset from https://datasets.clickhouse.com/
```

## Dataset

The benchmark uses the web analytics dataset with ~100M rows containing:
- User interactions (clicks, page views)
- User agent data
- Geographic information
- Timestamps

## Queries

The benchmark includes 43 queries that test:
- Simple aggregations
- Complex filtering
- String operations
- Time-based analysis
- Multi-dimensional grouping

## Running the Benchmark

Execute queries in order:
```bash
databend-query < q1.sql
databend-query < q2.sql
...
```

## Performance Metrics

Record:
- Query execution time
- Memory usage
- CPU utilization
