drop table if exists quotes;
create table quotes (
  id int(11) not null auto_increment,
  content varchar(255) not null,
  PRIMARY KEY (id)
);

drop table if exists links;
create table links (
  id int(11) not null auto_increment,
  url varchar(255) not null,
  title varchar(255) default null,
  description varchar(255) default null,
  category varchar(255) default 'article',
  PRIMARY KEY (id)
);

-- add index on title and url
