+++
title = "Quick note - Using DuckDB as CLI for SQLite and PostgreSQL"
taxonomies.tags = ["duckdb"]
+++

With the introduction of multi-database support in [DuckDB 0.10.0](https://duckdb.org/2024/02/13/announcing-duckdb-0100.html), it's possible to use it as a frontend for MySQL, Postgres and SQLite databases.
This comes in addition to the file based DuckDB storage format and native Parquet support.

After using DuckDB for analyzing GTFS data in CSV format, I got used to the nice CLI and decided to give it a try as frontend for my most often used Postgres and SQLite databases.

<!-- more -->

### Installation

Install the DuckDB Command line environment according to <https://duckdb.org/docs/installation/>

Install extensions:

```
duckdb
INSTALL sqlite;
INSTALL postgres;
# For geospatial operations using GEOS:
INSTALL spatial;
.quit
```

### SQLite

Open an SQLite database with DuckDB:

```
duckdb bookmarks.sqlite
```
```
D .tables
items      meta       structure  tags       urls     
D FROM structure;
┌──────────────┬──────────────┬──────────┐
│     guid     │  parentGuid  │ position │
│   varchar    │   varchar    │  int64   │
├──────────────┼──────────────┼──────────┤
│ rnoJgZro_RvM │ 1CP0XvUQxJAF │        0 │
│ MLq5UkC1G_xL │ 1CP0XvUQxJAF │        1 │
│ pD9TpwGO4xUL │ 1CP0XvUQxJAF │        2 │
│ GkFjM8yGSkBs │ 1CP0XvUQxJAF │        3 │
│ WvEVYDNob8jQ │ 1CP0XvUQxJAF │        4 │
│      ·       │      ·       │        · │
│      ·       │      ·       │        · │
│      ·       │      ·       │        · │
│ 57SzSLw8FPQF │ unfiled_____ │     1688 │
│ KljkRT7YdSNJ │ yM78JWU2H7vM │        0 │
│ 3YwIVDgZgyeY │ yM78JWU2H7vM │        1 │
│ -84AePl9n1ia │ yM78JWU2H7vM │        2 │
│ AwVmm6-TOiZ4 │ z9dJRp3vc7hq │        0 │
├──────────────┴──────────────┴──────────┤
│ 3695 rows (10 shown)         3 columns │
└────────────────────────────────────────┘
```

### PostgreSQL

For quickly connecting to a PostgreSQL database, I placed the following script in `~/bin/dpg` and made it executable with `chmod +x ~/bin/dpg`:

```
#!/bin/sh
duckdb -cmd "ATTACH 'dbname=$*' AS pg (TYPE postgres); SET search_path = 'pg.public';"
```

So connecting via Unix sockets is as short as:

```
dpg shortbread
```

```
D FROM geometry_columns;
┌─────────────────┬────────────────┬───┬───────┬──────────────┐
│ f_table_catalog │ f_table_schema │ … │ srid  │     type     │
│     varchar     │    varchar     │   │ int32 │   varchar    │
├─────────────────┼────────────────┼───┼───────┼──────────────┤
│ shortbread      │ osmeq          │ … │  8857 │ GEOMETRY     │
│ shortbread      │ osm            │ … │  3857 │ POLYGON      │
│ shortbread      │ osmeq          │ … │  8857 │ MULTIPOLYGON │
│ shortbread      │ osmeq          │ … │  8857 │ POLYGON      │
│ shortbread      │ osmeq          │ … │  8857 │ LINESTRING   │
│     ·           │   ·            │ · │    ·  │     ·        │
│     ·           │   ·            │ · │    ·  │     ·        │
│     ·           │   ·            │ · │    ·  │     ·        │
│ shortbread      │ osmeq          │ … │  8857 │ LINESTRING   │
│ shortbread      │ osmeq          │ … │  8857 │ LINESTRING   │
│ shortbread      │ osmeq          │ … │  8857 │ POINT        │
│ shortbread      │ osmeq          │ … │  8857 │ POLYGON      │
│ shortbread      │ osmeq          │ … │  8857 │ POLYGON      │
├─────────────────┴────────────────┴───┴───────┴──────────────┤
│ 56 rows (10 shown)                      7 columns (4 shown) │
└─────────────────────────────────────────────────────────────┘
```

Connecting via TCP usually requires a password:

```
PGPASSWORD=mvtbench dpg mvtbench host=localhost user=mvtbench
```

```
D FROM ne_10m_geographic_lines;
┌─────────┬───────────┬───┬────────────┬────────────┬──────────────────────┐
│ ogc_fid │ scalerank │ … │ wdid_score │   ne_id    │     wkb_geometry     │
│  int32  │   int64   │   │   int32    │   int64    │       varchar        │
├─────────┼───────────┼───┼────────────┼────────────┼──────────────────────┤
│       1 │         2 │ … │          5 │ 1159100207 │ 0105000020110F0000…  │
│       2 │         2 │ … │          5 │ 1159100209 │ 0105000020110F0000…  │
│       3 │         0 │ … │          5 │ 1159100211 │ 0105000020110F0000…  │
│       4 │         2 │ … │          5 │ 1159100213 │ 0105000020110F0000…  │
│       5 │         2 │ … │          5 │ 1159100215 │ 0105000020110F0000…  │
│       6 │         0 │ … │          5 │ 1159100219 │ 0105000020110F0000…  │
├─────────┴───────────┴───┴────────────┴────────────┴──────────────────────┤
│ 6 rows                                              33 columns (5 shown) │
└──────────────────────────────────────────────────────────────────────────┘
```

For more options see the [documentation](https://duckdb.org/docs/extensions/postgres).

Alternativley, you can also use a [PostgreSQL URI](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING-URIS) with the following script called `dpguri`:

```
#!/bin/sh
uri=$1
shift
duckdb -cmd "ATTACH '$uri' AS pg (TYPE postgres); SET search_path = 'pg.public';" $*
```

```
dpguri postgresql://mvtbench:mvtbench@127.0.0.1:5439/mvtbench
```

This all comes with autocompletion and support for additional queries like `PIVOT`. Let's give it a try!
