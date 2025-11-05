# Time-Series Benchmark Queries

These queries test time-series data operations commonly used in monitoring, IoT, and analytics applications.

## Setup

First, create the test tables:

```sql
-- Run setup.sql to create time-series tables with sample data
```

## Test Categories

1. **Time Windowing**: Rolling windows and time buckets
2. **Time Aggregations**: Aggregations over time periods
3. **Time-based Filtering**: Queries with date/time ranges
4. **Time Series Analysis**: Trend analysis and comparisons
5. **Window Functions**: LAG, LEAD, and moving averages

## Usage

Run each SQL file to test specific operations:

```bash
databend-query < time_window_aggregation.sql
databend-query < moving_average.sql
databend-query < time_range_query.sql
```

## Use Cases

- IoT sensor data analysis
- Application performance monitoring
- Financial time-series data
- Log aggregation and analysis
