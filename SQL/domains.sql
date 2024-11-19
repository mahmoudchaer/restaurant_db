-- domains

CREATE DOMAIN id_type AS VARCHAR(10);

CREATE DOMAIN address_type AS VARCHAR (255);

CREATE DOMAIN email_type AS VARCHAR(50);

CREATE DOMAIN money_type AS DECIMAL(10,2);

CREATE DOMAIN rating_type AS DECIMAL(3 ,1);

CREATE DOMAIN description_type AS text;

CREATE DOMAIN quantity_type AS INT;

CREATE DOMAIN time_type AS TIMESTAMP;

CREATE DOMAIN phone_type AS INTEGER;

CREATE DOMAIN name_type AS VARCHAR(30);

CREATE DOMAIN image_type AS BYTEA;
