CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   name TEXT,
   email TEXT,
   password TEXT
);

CREATE TABLE post (
   id SERIAL PRIMARY KEY,
   name TEXT
);
CREATE TABLE candidate (
   id SERIAL PRIMARY KEY,
   name TEXT,
   photo_id INTEGER,
   city_id INTEGER,
   FOREIGN KEY (photo_id)
      REFERENCES photo (photo_id)
);

CREATE TABLE photo (
   photo_id SERIAL PRIMARY KEY,
   name TEXT,
   photo bytea
);