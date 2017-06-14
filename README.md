# Sagan

A landing page for your browser.


## Adding Links

Just add links to a `data/links.csv` file. Delimiter is `semicolon space` `; `.

### Example

See `data/links.example.csv`.


## Database

Developed on MySQL.

Create a `~/.my.cnf` file to avoid specifying credentials with each command.

```
[client]
user=root
password=
host=localhost
```


### Drop Database, Create Database

```
$ mysql
mysql> drop database if exists sagan_development;
mysql> drop database if exists sagan_test;
mysql> create database sagan_development;
mysql> create database sagan_test;
mysql> \q
```

### Load database schema and data

Copy and modify `sql/seed.example.sql`.

```
$ mysql sagan_development < sql/schema.sql
$ mysql --local-infile sagan_development < sql/seed.sql
```

### Rebuild Development database

```
echo "drop database if exists sagan_development;" | mysql
echo "create database sagan_development;" | mysql
mysql sagan_development < sql/schema.sql
mysql --local-infile sagan_development < sql/seed.sql
```

### Query the database in MySQL

```
$ mysql sagan_development
mysql> select id, substring(url, 1, 64), description, category from links limit 20;
```

## Run app locally

via pow:

```
$ curl get.pow.cx | sh
$ cd ~/.pow
$ ln -s /path/to/cloned/repo/sagan
$ open sagan.dev
```

##

## TODO

* [x] Extract links and link collections into classes
* [x] Move links and quotes to `/data` folder
* [x] Add sample link.csv files
* [x] Migrate to a database-backed storage system
* [x] Upgrade to Ruby 2.4.1, Sinatra 2.0.0
* [x] Use CDN-hosted Foundation assets
* [x] Delete links
* [x] Flash notifications
* [x] Default tab changes based on day and time
* [x] Model specs
* [x] Feature specs
