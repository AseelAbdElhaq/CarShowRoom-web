
CREATE DATABASE car_showroom;
USE car_showroom;

CREATE TABLE Employee (
    SSN VARCHAR(32),
    Phone VARCHAR(32),
    Name VARCHAR(32),
    Address VARCHAR(32),
    Profession VARCHAR(32),
    DOB DATE,
    BranchNumber VARCHAR(32),
    PRIMARY KEY (SSN),
    FOREIGN KEY (BranchNumber) REFERENCES Branch(BranchNumber)
);

CREATE TABLE WorksByContract (
    SSN VARCHAR(32),
    MonthSalary DOUBLE,
    EndDate DATE,
    StartDate DATE,
    PRIMARY KEY (SSN),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ByWorkingTime (
    SSN VARCHAR(32),
    HourSalary DOUBLE,
    HourWork VARCHAR(255),
    PRIMARY KEY (SSN),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
    ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE Branch (
    BranchNumber VARCHAR(32),
    Address VARCHAR(255),
    PRIMARY KEY (BranchNumber)
);

CREATE TABLE Car (
    Color VARCHAR(32),
    Price DOUBLE,
    ReleaseYear INT,
    Model VARCHAR(32),
    MotorSize FLOAT,
    FuelType VARCHAR(32),
    TransmissionType VARCHAR(32),
    ChassisNumber VARCHAR(32),
    ManufacturingCompany VARCHAR(32),
    BranchNumber VARCHAR(32),
    SSN VARCHAR(32),
    PRIMARY KEY (ChassisNumber),
    FOREIGN KEY (BranchNumber) REFERENCES Branch(BranchNumber),
    FOREIGN KEY (SSN) REFERENCES Customer(SSN)
);

CREATE TABLE Customer (
    Address VARCHAR(32),
    Phone VARCHAR(32),
    SSN VARCHAR(32),
    Name VARCHAR(32),
    PRIMARY KEY (SSN)
);

-- Insert data into Branch table
INSERT INTO Branch (BranchNumber, Address) VALUES
('B001', '123 Main Street'),
('B002', '456 Elm Street');

-- Insert data into Customer table
INSERT INTO Customer (SSN, Name, Address, Phone) VALUES
('123456789', 'John Doe', '789 Oak Avenue', '555-1234'),
('987654321', 'Jane Smith', '321 Pine Street', '555-5678');

-- Insert data into Employee table
INSERT INTO Employee (SSN, Name, Address, Phone, DOB, Profession, BranchNumber) VALUES
('111111111', 'Moaid', '123 Oak Street', '555-1111', '1990-01-01', 'Manager', 'B001'),
('555555555', 'qusay', '123 Oak Street', '555-1111', '1990-01-01', 'Manager', 'B001'),
('666666666', 'Assel', '123 Oak Street', '555-1111', '1990-01-01', 'Manager', 'B001'),
('222222222', 'Dema', '456 Pine Street', '555-2222', '1995-05-05', 'Salesperson', 'B002');


-- Insert data into WorksByContract table
INSERT INTO WorksByContract (SSN, MonthSalary, StartDate, EndDate) VALUES
('111111111', 2000, '2022-01-01', '2022-12-31'),
('222222222', 1500, '2022-03-15', '2022-06-30');

-- Insert data into ByWorkingTime table
INSERT INTO ByWorkingTime (SSN, HourSalary, HourWork) VALUES
('555555555', 10, '40 hours per week'),
('666666666', 12, '35 hours per week');

-- Insert data into Car table
INSERT INTO Car (Color, Price, ReleaseYear, Model, MotorSize, FuelType, TransmissionType, ChassisNumber, ManufacturingCompany, BranchNumber, SSN) VALUES
('Red', 25000, 2020, 'Toyota Camry', 2.5, 'Gasoline', 'Automatic', '123ABC', 'Toyota', 'B001', '123456789'),
('Blue', 30000, 2021, 'Honda Civic', 1.8, 'Gasoline', 'Automatic', '456DEF', 'Honda', 'B002', '987654321');

select * from Employee;

UPDATE Employee e
SET e.SSN = '1211441'
WHERE e.SSN = '111111111';


