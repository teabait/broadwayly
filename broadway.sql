create table shows(
  id serial PRIMARY KEY NOT NULL,
  title varchar(50) NOT NULL,
  composer varchar(50) NOT NULL,
  img_url varchar(200)
);

create table songs(
  id serial PRIMARY KEY NOT NULL,
  title varchar(50) NOT NULL,
  embed_url varchar(200),
  show_id integer REFERENCES shows(id)
);

