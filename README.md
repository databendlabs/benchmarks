# Databend Benchmarks

A comprehensive collection of SQL benchmark scripts for testing and evaluating Databend performance across various workloads.

## Overview

This repository contains benchmark SQL scripts organized by category:

- **TPC-H**: Industry-standard decision support benchmark
- **ClickBench**: Analytical queries based on web analytics data
- **Basic CRUD**: Fundamental database operations (Create, Read, Update, Delete)
- **Aggregation & JOINs**: Complex analytical queries with aggregations and multi-table joins
- **Time-Series**: Time-based data analysis and windowing operations

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/databendlabs/benchmarks.git
cd benchmarks
```

### 2. Set up your Databend connection

Make sure you have Databend installed and running. You can connect using:

```bash
# Using databend-query CLI
databend-query --host=<host> --port=<port> --user=<user>

# Or using bendsql
bendsql --host=<host> --port=<port> --user=<user>
```

### 3. Run a benchmark

Each benchmark category has a setup script and multiple query scripts:

```bash
# Setup the benchmark
databend-query < benchmarks/tpch/setup.sql

# Run individual queries
databend-query < benchmarks/tpch/q1.sql
```

## Benchmark Categories

### TPC-H Benchmark

Location: `benchmarks/tpch/`

The TPC-H benchmark consists of 22 business-oriented queries that test:
- Complex aggregations
- Multi-table joins
- Subqueries and nested queries
- Sorting and grouping operations

**Setup:**
```bash
databend-query < benchmarks/tpch/setup.sql
databend-query < benchmarks/tpch/q1.sql
```

See [benchmarks/tpch/README.md](benchmarks/tpch/README.md) for details.

### ClickBench Benchmark

Location: `benchmarks/clickbench/`

ClickBench is designed for analytical databases and includes queries for:
- Simple and complex aggregations
- String operations
- Time-based analysis
- Multi-dimensional grouping

**Setup:**
```bash
databend-query < benchmarks/clickbench/setup.sql
databend-query < benchmarks/clickbench/q1.sql
```

See [benchmarks/clickbench/README.md](benchmarks/clickbench/README.md) for details.

### Basic CRUD Operations

Location: `benchmarks/basic/`

Tests fundamental database operations:
- Single and bulk INSERT operations
- SELECT queries with various conditions
- UPDATE operations
- DELETE operations

**Setup:**
```bash
databend-query < benchmarks/basic/setup.sql
databend-query < benchmarks/basic/insert_single.sql
```

See [benchmarks/basic/README.md](benchmarks/basic/README.md) for details.

### Aggregation & JOIN Queries

Location: `benchmarks/aggregation/`

Tests analytical query performance:
- Simple aggregations (SUM, AVG, MIN, MAX, COUNT)
- GROUP BY with single and multiple columns
- INNER JOIN and LEFT JOIN operations
- Complex queries with joins and aggregations

**Setup:**
```bash
databend-query < benchmarks/aggregation/setup.sql
databend-query < benchmarks/aggregation/simple_aggregation.sql
```

See [benchmarks/aggregation/README.md](benchmarks/aggregation/README.md) for details.

### Time-Series Queries

Location: `benchmarks/timeseries/`

Tests time-series data operations:
- Time windowing and bucketing
- Time-based aggregations
- Moving averages
- Window functions (LAG, LEAD)
- Trend analysis

**Setup:**
```bash
databend-query < benchmarks/timeseries/setup.sql
databend-query < benchmarks/timeseries/time_window_aggregation.sql
```

See [benchmarks/timeseries/README.md](benchmarks/timeseries/README.md) for details.

## Running All Benchmarks

You can create a simple script to run all benchmarks:

```bash
#!/bin/bash

# Setup all benchmarks
for dir in benchmarks/*/; do
    if [ -f "${dir}setup.sql" ]; then
        echo "Setting up ${dir}"
        databend-query < "${dir}setup.sql"
    fi
done

# Run all queries and measure time
for sql_file in benchmarks/*/*.sql; do
    if [[ ! "$sql_file" =~ setup.sql$ ]]; then
        echo "Running ${sql_file}"
        time databend-query < "$sql_file"
    fi
done
```

## Performance Metrics

When running benchmarks, consider measuring:

- **Query execution time**: Wall clock time for query completion
- **Memory usage**: Peak memory consumption during query execution
- **CPU utilization**: CPU usage during query execution
- **I/O operations**: Disk reads/writes
- **Network throughput**: Data transfer for distributed queries

## Best Practices

1. **Warm-up runs**: Run queries multiple times and discard first results
2. **Clear cache**: Clear system caches between runs for consistent results
3. **Consistent environment**: Use the same hardware and configuration
4. **Multiple iterations**: Run each query multiple times and calculate average
5. **Monitor resources**: Track CPU, memory, and I/O during execution
6. **Data size**: Test with different data scales (SF1, SF10, SF100 for TPC-H)

## Contributing

Contributions are welcome! To add new benchmarks:

1. Create a new directory under `benchmarks/`
2. Add a `README.md` describing the benchmark
3. Add a `setup.sql` for schema and data generation
4. Add query files (e.g., `q1.sql`, `q2.sql`, etc.)
5. Document expected results and performance characteristics

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Resources

- [Databend Documentation](https://databend.rs/)
- [TPC-H Benchmark Specification](http://www.tpc.org/tpch/)
- [ClickBench](https://benchmark.clickhouse.com/)

## Support

For issues and questions:
- GitHub Issues: https://github.com/databendlabs/benchmarks/issues
- Databend Community: https://github.com/datafuselabs/databend