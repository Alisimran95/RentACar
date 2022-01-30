Create database DbRental
use DbRental

create table Office(
	Id int primary key identity,
	OfficeName nvarchar(50) not null,
	OfficeAdress nvarchar(50) not null
)

Insert into Office(OfficeName,OfficeAdress)
values('RentACarBaku','Baku'),
	  ('RentMiles','Baku')

create table CarCategory(
	Id int primary key identity,
	NumOfPersons nvarchar(10) not null,
	DailyCost decimal(10,2) not null
)

Insert into CarCategory(NumOfPersons,DailyCost)
Values('4',20),
	  ('6',30),
	  ('20',50)

create table Cars(
	Id int primary key identity,
	Brand nvarchar(50) not null,
	Model nvarchar(50) not null,
	License bit not null default 0,
	CarYear nvarchar(10) not null,
	CarCategoryId int references Cars(Id)
)

Insert into Cars(Brand,Model,License,CarYear,CarCategoryId)
values ('Bmw','M5',1,'2016',1),
		('Audi','Q3',1,'2012',1),
		('Audi','Q5',1,'2016',1),
		('Kia','Carens',1,'2010',2),
		('Toyota','Hilux',1,'2009',2),
		('Ford','Transit',1,'2014',3)

create table Clients(
	Id int primary key identity,
	Fullname nvarchar(100) not null,
	PassportNo nvarchar(50) not null,
	PhoneNumber nvarchar(100) not null
)

Insert into Clients(Fullname,PassportNo, Phonenumber)
values ('Idris Jafarzade','AZE*******','+99450*******'),
		('Parviz Asadov','AZE*******','+99455*******'),
		('Elnur Maharramli','AZE*******','+99450*******'),
		('Orkhan Abdullayev','AZE*******','+99450*******')

create table PaymentType(
	Id int primary key identity,
	PaymentTypeName nvarchar(20)
)

Insert into PaymentType(PaymentTypeName)
values ('online'),
		('cash')

create table Rentals(
	Id int primary key identity,
	OfficeId int references Office(Id),
	CarId int references Cars(Id),
	ClientId int references Clients(Id),
	RentalDays int not null,
	RentStatus bit not null default 0
)

Insert into Rentals(OfficeId,CarId,ClientId,RentalDays,RentStatus)
values(1,1,1,3,1),
	  (2,3,2,5,1),
	  (1,5,3,10,1),
	  (2,4,1,3,1),
	  (2,2,1,3,1)

create table Payments(
	Id int primary key identity,
	RentalId int references Rentals(Id),
	PaymentTypeId int references PaymentType(id),
	Amount decimal(10,2),
	PaymentDate datetime default GetDate()
)

Insert into Payments(RentalId,PaymentTypeId,Amount)
values(1,2,20),
	  (2,1,20),
	  (3,2,30),
	  (4,2,50),
	  (5,1,20)

--create view GetRentingDetails
--As

--Select OfficeName,Brand, Model,Fullname,PhoneNumber,Amount, PaymentDate,PaymentTypeName from Rentals R

--Join Office O
--On R.OfficeId = O.Id

--Join Cars C
--On R.CarId = C.Id

--Join CarCategory CC
--On C.CarCategoryId = Cc.Id

--Join Clients CL
--On R.ClientId = CL.Id

--Join Payments P
--On R.Id = P.Id

--Join PaymentType PT
--On P.PaymentTypeId = PT.Id


--create Procedure GetRentAmount @Amount decimal
--AS
--Select * from GetRentingDetails
--where Amount > @Amount

--Execute GetRentAmount 10


--CREATE FUNCTION GetPaymentAmountID(@Id int)
--returns int
--As
--Begin
--	Declare @Sum int
--	Select @Sum = Sum(Amount) from Payments
--	Where Id > @Id
--	return @Sum
--end

--Select dbo.GetPaymentAmountId(1)