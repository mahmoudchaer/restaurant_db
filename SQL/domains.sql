-- domains

CREATE DOMAIN id_type AS INTEGER CHECK (VALUE BETWEEN 0 AND 99999999);

CREATE DOMAIN address_type AS VARCHAR (255);

CREATE DOMAIN email_type AS VARCHAR(50) CHECK ( position('@' in VALUE) > 0 AND position('.' in VALUE) > 0);

CREATE DOMAIN money_type AS DECIMAL(10,2) CHECK (VALUE >= 0) ; 

CREATE DOMAIN rating_type AS DECIMAL(3 ,1) CHECK (VALUE >= 0);

CREATE DOMAIN description_type AS TEXT;

CREATE DOMAIN quantity_type AS INT CHECK (VALUE >= 0);

CREATE DOMAIN time_type AS TIMESTAMP;

CREATE DOMAIN phone_type AS INTEGER;

CREATE DOMAIN name_type AS VARCHAR(30);

CREATE DOMAIN image_type AS BYTEA;







