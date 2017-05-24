drop table if exists links;
create table links (
  id int(11) not null auto_increment,
  url varchar(255) not null,
  title varchar(255) default null,
  description varchar(255) default null,
  category varchar(255) default 'article',
  PRIMARY KEY (id)
);
