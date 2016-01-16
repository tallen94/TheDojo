/* PERSON
STUDENT
FIGHTER
INSTRUCTOR
CERTIFICATION
CONTACT
*/


CREATE PROC usp_AddPerson 
@FirstName VARCHAR(50), 
@LastName VARCHAR(50),
@DateOfBirth DATE, 
@MembershipName VARCHAR(50),
@ContactPhone NUMERIC(11,0), 
@RankName VARCHAR(50) 

AS

BEGIN TRAN T1 

DECLARE @MembershipID INT
DECLARE @ContactID INT 
DECLARE @RankID INT 

SET @MembershipID = (SELECT MembershipID FROM MEMBERSHIP 
						WHERE MembershipName = @MembershipName)
SET @ContactID = (SELECT ContactID FROM CONTACT 
						WHERE Phone = @ContactPhone)

SET @RankID = (SELECT RankID FROM "RANK" 
				WHERE RankName = @RankName)

INSERT INTO PERSON (FirstName, LastName, DateOfBirth, MembershipID, ContactID, RankStyleID)
VALUES (@FirstName, @LastName, @DateOfBirth, @MembershipID, @ContactID, @RankID) 

IF (@@ERROR <> 0) 
	ROLLBACK TRAN T1 
ELSE 
	COMMIT TRAN T1

GO 

CREATE PROC usp_AddStudent 
@FirstName VARCHAR(50), 
@LastName VARCHAR(50), 
@StudentStartDate DATE, 
@StudentEndDate DATE
AS
BEGIN TRAN T1

DECLARE @PersonID INT 

SET @PersonID = (SELECT PersonID FROM PERSON
					 WHERE FirstName = @FirstName AND LastName = @LastName)


INSERT INTO STUDENT (PersonID, StudentStartDate, StudentEndDate)
VALUES(@PersonID, @StudentStartDate, @StudentEndDate)

IF (@@ERROR <> 0)
	ROLLBACK TRAN T1
ELSE 
	COMMIT TRAN T1

GO 

CREATE PROC usp_AddFighter 
@FirstName VARCHAR(50), 
@LastName VARCHAR(50), 
@TotalMatches NUMERIC(4,0), 
@TotalWins NUMERIC(4,0), 
@FighterStyle VARCHAR(100),
@FighterStartDate DATE, 
@FighterEndDate DATE
AS 
BEGIN TRAN T1

DECLARE @PersonID INT 

SET @PersonID = (SELECT PersonID FROM PERSON
					 WHERE FirstName = @FirstName AND LastName = @LastName)



INSERT INTO FIGTHER (PersonID, TotalMatches, TotalWins, FighterStyle, FighterStartDate, FighterEndDate)
VALUES (@PersonID, @TotalMatches, @TotalWins, @FighterStyle, @FighterStartDate, @FighterEndDate)

IF (@@ERROR <> 0)
	ROLLBACK TRAN T1
ELSE 
	COMMIT TRAN T1

GO 

CREATE PROC usp_AddInstructor 
@FirstName VARCHAR(50), 
@LastName VARCHAR(50), 
@InstructorStartDate DATE, 
@InsctructorEndDate DATE, 
@InstructorTitle VARCHAR(50), 
@CertificateName VARCHAR(50)
AS

BEGIN TRAN T1 

DECLARE @PersonID INT 
DECLARE @CertificationID INT

SET @PersonID = (SELECT PersonID FROM PERSON
					 WHERE FirstName = @FirstName AND LastName = @LastName)

SET @CertificationID = (SELECT CertificationID FROM CERTIFICATION 
							WHERE CertificationName = @CertificateName)

INSERT INTO INSTRUCTOR (PersonID, InstructorStartDate, InstructorEndDate, InstructorTitle, CertificationID)
VALUES (@PersonID, @InstructorStartDate, @InsctructorEndDate, @InstructorTitle, @CertificationID)

IF (@@ERROR <> 0) 
	ROLLBACK TRAN T1
ELSE 
	COMMIT TRAN T1

GO 

CREATE PROC usp_AddCertification 
@CertificationName VARCHAR(50), 
@CertificationDescr VARCHAR(500) 
AS

BEGIN TRAN T1

INSERT INTO CERTIFICATION (CertificationName, CertificationDescr)
VALUES (@CertificationName, @CertificationDescr)

IF (@@ERROR <> 0)
	ROLLBACK TRAN T1
ELSE 
	COMMIT TRAN T1

GO 

CREATE PROC usp_AddContact 
@Phone Numeric (11,0),
@Street VARCHAR(50), 
@City VARCHAR(50), 
@State VARCHAR(50), 
@ZipCode VARCHAR(50), 
@Email VARCHAR(50)
AS 

BEGIN TRAN T1

INSERT INTO CONTACT (Phone, Street, City, "State", ZipCode, Email)
VALUES (@Phone, @Street, @City, @State, @ZipCode, @Email)