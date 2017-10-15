DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE movies;


CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE movies (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  movie_id INT4 REFERENCES movies(id) ON DELETE CASCADE,
  screening_time TIME
);
-- TIME()	A time. Format: HH:MI:SS
-- Note: The supported range is from '-838:59:59' to '838:59:59'

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  movie_id INT4 REFERENCES movies(id) ON DELETE CASCADE
);
