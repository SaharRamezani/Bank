DELETE FROM Customer
DELETE FROM Branch
DELETE FROM Deposit
DELETE FROM Trn_Src_Des
DELETE FROM Deposit_Type

DROP TABLE Customer
DROP TABLE Branch
DROP TABLE Deposit_Type
DROP TABLE Deposit_Status
DROP TABLE Deposit
DROP TABLE Trn_Src_Des

CREATE TABLE Customer
(
    CID INT PRIMARY KEY,
    [Name] VARCHAR(100),
    NatCod VARCHAR(10) UNIQUE, -- 1273635167
    BirthDate DATE,
	[Add] VARCHAR(500),
    Tel VARCHAR(11) -- 09900441258
);

CREATE TABLE Branch
(
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(50),
	Branch_Add VARCHAR(500),
	Branch_Tel VARCHAR(11) -- 03137773599

	CONSTRAINT UN_Branch UNIQUE(Branch_Name, Branch_Add)
);

CREATE TABLE Deposit_Type
(
    Dep_Type INT PRIMARY KEY,
    Dep_Typ_Desc VARCHAR(500)
);

CREATE TABLE Deposit_Status
(
    [Status] INT PRIMARY KEY,
    Status_Desc VARCHAR(500)
);

CREATE TABLE Deposit
(
    Dep_ID INT PRIMARY KEY,
    Dep_Type INT FOREIGN KEY REFERENCES Deposit_Type(Dep_Type),
    CID INT FOREIGN KEY REFERENCES Customer(CID),
    OpenDate DATE,
	[Status] INT FOREIGN KEY REFERENCES Deposit_Status([Status])
);

CREATE TABLE Trn_Src_Des
(
    VoucherId VARCHAR(10) PRIMARY KEY,
    TrnDate DATE,
    TrnTime VARCHAR(8), -- 00:00:00
    Amount BIGINT,
	SourceDep INT FOREIGN KEY REFERENCES Deposit(Dep_ID),
	DesDep  INT FOREIGN KEY REFERENCES Deposit(Dep_ID),
	Branch_ID INT FOREIGN KEY REFERENCES Branch(Branch_ID),
    Trn_Desc VARCHAR(500)
);