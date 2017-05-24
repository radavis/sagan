# Sagan

A landing page for your browser.


## Adding Links

Just add links to any of the `.csv` files in `links`, or create your own `.csv` file of links. Delimiter is `semicolon space` `; `.


### Example

See `sql/links.example.csv`.

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

```
$ mysql -h localhost -u root -p sagan_development < sql/schema.sql
$ mysql -h localhost -u root -p --local-infile sagan_development < sql/data.sql
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

* [ ] Extract links and link collections into classes
* [ ] Handle URL fragments that start with a number (e.g.- 3d-printing)
* [ ] Move links and quotes to `/data` folder
* [ ] Add sample link.csv files, .gitignore the rest
* [ ] Migrate to a database-backed link storage system
* [ ] Upgrade Ruby/Sinatra
* [ ] Use CDN-hosted Foundation assets
