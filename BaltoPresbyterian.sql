
USE master
GO


DROP DATABASE IF EXISTS BaltoPresbyterianAnimalHospital;
GO


CREATE DATABASE BaltoPresbyterianAnimalHospital;
GO 


USE BaltoPresbyterianAnimalHospital
GO

CREATE TABLE Family (
	owner_id INT IDENTITY(1,1),
	owner_name NVARCHAR(300),
	owner_address NVARCHAR (300) NOT NULL,
	owner_phone NVARCHAR (20) NOT NULL


	CONSTRAINT [PK_owner_id] PRIMARY KEY (owner_id),
);
GO


CREATE TABLE Pet (
	pet_id INT IDENTITY(1,1),
	owner_id INT,
	pet_name NVARCHAR (300) NOT NULL,
	pet_type NVARCHAR (100) NOT NULL,
	pet_age INT,

	CONSTRAINT [PK_pet_id] PRIMARY KEY (pet_id),
	CONSTRAINT [FK_pet_family] FOREIGN KEY (owner_id) REFERENCES  Family(owner_id)
);
GO


CREATE TABLE Medical_Procedure(
	procedure_id INT IDENTITY(1,1),
	procedure_cost DECIMAL (9,2) NOT NULL,
	procedure_name NVARCHAR(300) NOT NULL, 
	CONSTRAINT [PK_procedure_id] PRIMARY KEY (procedure_id),

	

);
GO

CREATE TABLE Pet_Procedure(
	pet_id INT, 
	procedure_id INT,

	CONSTRAINT [PK_pet_procedure] PRIMARY KEY (pet_id, procedure_id),
	CONSTRAINT [FK_pet_procedure_pet] FOREIGN KEY (pet_id) REFERENCES  Pet(pet_id),
	CONSTRAINT [FK_pet__procedure_procedure] FOREIGN KEY (procedure_id) REFERENCES  Medical_procedure(procedure_id),

);
GO

CREATE TABLE Invoice(
	invoice_id INT IDENTITY (1,1), 
	invoice_date DATETIME NOT NULL CONSTRAINT [DF_invoice_date] DEFAULT GETDATE(),
	invoice_total DECIMAL,
	owner_id INT,

	CONSTRAINT [PK_invoice_id] PRIMARY KEY (invoice_id),
	CONSTRAINT [FK_invoice_family] FOREIGN KEY (owner_id) REFERENCES  Family(owner_id)
   
);
GO

INSERT INTO FAMILY (owner_name, owner_address, owner_phone)
VALUES ('Broomstool Realperson', '420 Reallife Ln', '8675309')

INSERT INTO FAMILY (owner_name, owner_address, owner_phone)
VALUES ('Toddathon', '796 Hellofagooddip Ave', '5555555555')

INSERT INTO FAMILY (owner_name, owner_address, owner_phone)
VALUES ('Jimothy', '666 Notthepolice Ln', '1800406739')

INSERT INTO PET (pet_name, pet_type, pet_age)
VALUES ('Jabremen The Third', 'turtle', 40)

INSERT INTO PET (pet_name, pet_type, pet_age)
VALUES ('Roy Sanderson Eckelstien', 'platypus', 32)

INSERT INTO PET (pet_name, pet_type, pet_age)
VALUES ('Catus', 'griffin', 1000)

INSERT INTO Medical_Procedure (procedure_name, procedure_cost)
VALUES ('Magic Essence Extraction', 20)

INSERT INTO Medical_Procedure (procedure_name, procedure_cost)
VALUES ('Excorcism', 3)

INSERT INTO Medical_Procedure (procedure_name, procedure_cost)
VALUES ('Platypus Posion Extraction', 0.25)

INSERT INTO INVOICE (owner_id)
VALUES ((select owner_id from Family where owner_name = 'Broomstool Realperson'))

INSERT INTO INVOICE (owner_id)
VALUES ((select owner_id from Family where owner_name = 'Toddathon'))

INSERT INTO INVOICE (owner_id)
VALUES ((select owner_id from Family where owner_name = 'Jimothy'))

select
*
From
Pet