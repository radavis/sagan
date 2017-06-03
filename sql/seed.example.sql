-- Copy file contents to `./sql/data.sql` and update file paths. Avoid using relative paths.

load data local infile '/path/to/sagan/data/quotes' into table quotes
  lines terminated by '\n'
  (content);

load data local infile '/path/to/sagan/data/links.csv' into table links
  fields
    terminated by '; '
    enclosed by '"'
  lines terminated by '\n'
  ignore 1 lines
  (url, title, description, category);
