-- Sample query used in Vantage Express
-- https://quickstarts.teradata.com/vantage.express.gcp.html#_run_sample_queries
CREATE DATABASE HR
AS PERMANENT = 60e6, -- 60MB
    SPOOL = 120e6; -- 120MB

CREATE SET TABLE HR.Employees (
   GlobalID INTEGER,
   FirstName VARCHAR(30),
   LastName VARCHAR(30),
   DateOfBirth DATE FORMAT 'YYYY-MM-DD',
   JoinedDate DATE FORMAT 'YYYY-MM-DD',
   DepartmentCode BYTEINT
)
UNIQUE PRIMARY INDEX ( GlobalID );


INSERT INTO HR.Employees (
   GlobalID,
   FirstName,
   LastName,
   DateOfBirth,
   JoinedDate,
   DepartmentCode
)
VALUES (
   101,
   'Adam',
   'Tworkowski',
   '1980-01-05',
   '2004-08-01',
   01
);

SELECT * FROM HR.Employees;
