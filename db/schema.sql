CREATE TABLE post (
   id SERIAL PRIMARY KEY,
   name TEXT
);
CREATE TABLE candidate (
   id SERIAL PRIMARY KEY,
   name TEXT,
   photo_id INTEGER,
   FOREIGN KEY (photo_id)
      REFERENCES photo (photo_id)
);

CREATE TABLE photo (
   photo_id SERIAL PRIMARY KEY,
   name TEXT,
   photo bytea
);