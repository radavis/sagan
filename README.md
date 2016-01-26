# Sagan

A homepage for Launch Academy Staff.

## Run the server with pow

```
$ curl get.pow.cx | sh
$ cd ~/.pow
$ ln -s /path/to/cloned/repo
```

## Adding Links

Just add links to any of the `.csv` files in `links`, or create your own `.csv` file of links. Delimiter is `semicolon space` `; `.


### Example

#### links/filename.csv

```no-highlight
url; title; description
http://localhost:1080; Mailcatcher; Local Mailcatcher Server
http://localhost:3000; Rails Server; Local Rails Server
http://localhost:4567; Sinatra Server; Local Sinatra Server
```
