CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   name TEXT,
   email TEXT NOT NULL,
   password TEXT,
   CONSTRAINT users_email_ukey UNIQUE (email)
);

CREATE TABLE post (
   id SERIAL PRIMARY KEY,
   name TEXT
);

CREATE TABLE photo (
   id SERIAL PRIMARY KEY,
   name TEXT,
   photo bytea
);

CREATE TABLE city (
   id SERIAL PRIMARY KEY,
   name TEXT,
   created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE candidate (
   id SERIAL PRIMARY KEY,
   name TEXT,
   city_id INTEGER,
   photo_id INTEGER,
   FOREIGN KEY (photo_id, city_id)
      REFERENCES photo (id), city (id)
);