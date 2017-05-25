load data local infile '/Users/rd/code/sagan/sql/quotes' into table quotes
  lines terminated by '\n'
  (content);

load data local infile '/Users/rd/code/sagan/sql/links.csv' into table links
  fields
    terminated by '; '
    enclosed by '"'
  lines terminated by '\n'
  ignore 1 lines
  (url, title, description, category);
