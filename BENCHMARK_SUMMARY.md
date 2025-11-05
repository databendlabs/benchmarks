# Databend Benchmark SQL Scripts - Summary

## What's Included

This repository now contains a comprehensive collection of SQL benchmark scripts for testing Databend performance across various workloads.

### File Count
- **48 total files**: 41 SQL query files, 6 README/documentation files, 1 benchmark runner script
- **5 benchmark categories**: TPC-H, ClickBench, Basic CRUD, Aggregation/JOIN, Time-Series

## Benchmark Categories

### 1. TPC-H Benchmark (`benchmarks/tpch/`)
- **Purpose**: Industry-standard decision support benchmark
- **Files**: 1 setup + 6 queries (Q1-Q6)
- **Tests**: Complex aggregations, multi-table joins, subqueries
- **Schema**: 8 tables (region, nation, supplier, customer, part, partsupp, orders, lineitem)

### 2. ClickBench (`benchmarks/clickbench/`)
- **Purpose**: Analytical database benchmark based on web analytics
- **Files**: 1 setup + 8 queries
- **Tests**: Simple/complex aggregations, string operations, time-based analysis
- **Schema**: hits table with ~100 columns simulating web analytics data

### 3. Basic CRUD Operations (`benchmarks/basic/`)
- **Purpose**: Test fundamental database operations
- **Files**: 1 setup + 10 query files
- **Tests**: INSERT (single/bulk), SELECT (simple/with-where/aggregation), UPDATE (single/bulk), DELETE (single/bulk)
- **Schema**: 4 tables (users, products, orders, logs)

### 4. Aggregation & JOINs (`benchmarks/aggregation/`)
- **Purpose**: Complex analytical queries
- **Files**: 1 setup + 9 query files
- **Tests**: Aggregations (SUM, AVG, MIN, MAX, COUNT), GROUP BY, INNER/LEFT JOIN, complex queries
- **Schema**: 4 tables (customers, products, sales, suppliers) with 100K+ rows
- **Sample Data**: Auto-generated using numbers() function

### 5. Time-Series Queries (`benchmarks/timeseries/`)
- **Purpose**: Time-based data analysis
- **Files**: 1 setup + 6 query files
- **Tests**: Time windowing, moving averages, window functions (LAG, LEAD), trend analysis
- **Schema**: 3 tables (metrics, stock_prices, app_logs) with 1M+ rows total
- **Use Cases**: IoT, monitoring, financial data, log analysis

## Key Features

### Automated Setup
- Each benchmark has a `setup.sql` that creates tables and generates sample data
- No external data files required - uses Databend's `numbers()` function for data generation

### Benchmark Runner Script
- `run_benchmark.sh`: Bash script to automate benchmark execution
- Features:
  - Run individual benchmarks or all at once
  - Setup-only mode
  - Run specific queries
  - Configurable connection parameters
  - Results saved to CSV
  - Color-coded output

### Documentation
- Main README with comprehensive overview
- Individual README in each benchmark category
- Usage examples for each benchmark
- Performance metrics guidance

## Quick Start Examples

```bash
# Run all benchmarks
./run_benchmark.sh --all

# Run specific benchmark
./run_benchmark.sh --benchmark tpch

# Setup only (no queries)
./run_benchmark.sh --benchmark basic --setup-only

# Run specific query
./run_benchmark.sh --query benchmarks/tpch/q1.sql

# With custom connection
./run_benchmark.sh --benchmark aggregation --host 127.0.0.1 --port 8000 --user root
```

## SQL Features Tested

### Query Complexity
- ✅ Simple SELECT queries
- ✅ Complex WHERE clauses
- ✅ Aggregation functions (SUM, AVG, MIN, MAX, COUNT, STDDEV)
- ✅ GROUP BY (single and multi-column)
- ✅ HAVING clauses
- ✅ ORDER BY and LIMIT
- ✅ Subqueries
- ✅ INNER JOIN and LEFT JOIN
- ✅ Multi-table joins (3-4 tables)
- ✅ Window functions (LAG, LEAD, moving averages)
- ✅ Time functions (DATE_TRUNC, DATE_ADD, INTERVAL)
- ✅ CASE expressions
- ✅ String functions (CONCAT)
- ✅ DISTINCT operations
- ✅ EXISTS clauses

### Data Operations
- ✅ Single row INSERT
- ✅ Bulk INSERT (using SELECT)
- ✅ Single row UPDATE
- ✅ Bulk UPDATE with conditions
- ✅ Single row DELETE
- ✅ Bulk DELETE with conditions

### Data Types Used
- ✅ INT, BIGINT, SMALLINT
- ✅ VARCHAR (various lengths)
- ✅ DECIMAL (with precision)
- ✅ DOUBLE
- ✅ DATE
- ✅ TIMESTAMP

## Performance Testing Guidelines

### Metrics to Track
1. **Query execution time**: Use `time` command or capture timestamps
2. **Memory usage**: Monitor peak memory consumption
3. **CPU utilization**: Track CPU usage during queries
4. **I/O operations**: Disk reads/writes
5. **Throughput**: Queries per second for repeated execution

### Best Practices
1. Run warm-up queries before benchmarking
2. Clear caches between runs for consistency
3. Run multiple iterations and calculate averages
4. Test with different data scales
5. Monitor system resources during execution

## Data Scales

### Current Implementation
- Basic CRUD: 1K-10K rows
- Aggregation: 100K rows
- Time-Series: 1M rows
- TPC-H: Schema only (load your own data)
- ClickBench: Schema only (load your own data)

### Scaling Up
To test with larger datasets, modify the `numbers()` function parameter in setup.sql files:
```sql
-- Change from 1000 to 1000000
FROM numbers(1000000);
```

## Integration with CI/CD

The benchmark scripts can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run Databend Benchmarks
  run: |
    ./run_benchmark.sh --all
    # Parse results from benchmark_results.csv
    # Fail if performance regresses beyond threshold
```

## Future Enhancements

Potential additions:
- [ ] Additional TPC-H queries (Q7-Q22)
- [ ] TPC-DS benchmark
- [ ] More ClickBench queries (Q9-Q43)
- [ ] Concurrent query testing
- [ ] Write-heavy workload benchmarks
- [ ] Mixed OLTP/OLAP workloads
- [ ] JSON/semi-structured data queries
- [ ] Array and nested data type queries

## Support

For questions or issues:
- Repository Issues: https://github.com/databendlabs/benchmarks/issues
- Databend Documentation: https://databend.rs/
- Databend Community: https://github.com/datafuselabs/databend
