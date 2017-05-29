# Sagan

A landing page for your browser.


## Adding Links

Just add links to a `data/links.csv` file. Delimiter is `semicolon space` `; `.

### Example

See `data/links.example.csv`.

## Drop development database

```
$ mysql -h localhost -u root -p
mysql> drop database if exists sagan_development;
```

## Create development database

```
$ mysql -h localhost -u root -p
mysql> create database sagan_development;
mysql> \q
```

## Load database schema and data

Copy and modify `sql/data.example.sql`.

```
$ mysql -h localhost -u root -p sagan_development < sql/schema.sql
$ mysql -h localhost -u root -p --local-infile sagan_development < sql/data.sql
```

## Rebuild database

```
echo "drop database if exists sagan_development;" | mysql -h localhost -u root
echo "create database sagan_development;" | mysql -h localhost -u root
mysql -h localhost -u root sagan_development < sql/schema.sql
mysql -h localhost -u root --local-infile sagan_development < sql/data.sql
```

## Open the database in MySQL

```
$ mysql -h localhost -u root -p sagan_development
mysql> select id, substring(url, 1, 64), description, category from links limit 20;
```

## Run the server with pow

```
$ curl get.pow.cx | sh
$ cd ~/.pow
$ ln -s /path/to/cloned/repo
```

## TODO

* [x] Extract links and link collections into classes
* [ ] Handle URL fragments that start with a number (e.g.- 3d-printing)
* [x] Move links and quotes to `/data` folder
* [x] Add sample link.csv files, .gitignore the rest
* [x] Migrate to a database-backed link storage system
* [x] Upgrade Ruby/Sinatra
* [x] Use CDN-hosted Foundation assets
* [x] Delete links
* [ ] Flash notifications
* [x] Default tab changes based on day and time
