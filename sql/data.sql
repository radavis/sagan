load data local infile '/Users/rd/code/sagan/sql/links.csv' into table links
  fields terminated by '; '
  lines terminated by '\n'
  ignore 1 lines
  (url, title, description, category);
