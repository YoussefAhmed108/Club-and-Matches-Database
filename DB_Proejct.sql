
CREATE PROC createAllTables
AS 
Create table SystemUser(
Username varchar(20) PRIMARY KEY,
SystemUserPassword varchar(20)
);
create table Stadium(
StadiumID int PRIMARY KEY Identity,
StadiumName Varchar(20),
Capacity int,
StadiumLocation Varchar(20),
StadiumStatus bit ,
);
create table StadiumManager(
StadiumManagerID int PRIMARY KEY Identity,
StadiumManagerName Varchar(20),
Username varchar(20) foreign key references SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
StadiumID int foreign key references Stadium(StadiumID) ON DELETE CASCADE ON UPDATE CASCADE
);
create table Club(
ClubId int primary key Identity,
ClubName varchar(20),
ClubLocation varchar(20)
);
create table ClubRepresentative(
ClubRepresentativeID int primary key Identity,
ClubRepresentativeName varchar(20) ,
Username varchar(20) foreign key references SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
ClubId int foreign key references Club (ClubId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL 
);
create table Match (
MatchID int primary key Identity,
StartTime DATETIME,                                                              
EndTime DATETIME,
HostID int foreign key references Club (ClubId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
VisitorID int foreign key references Club (ClubId) NOT NULL,
StadiumID int foreign key references Stadium (StadiumID) ON DELETE CASCADE ON UPDATE CASCADE
);

create Table Fan(
NationalID varchar(20) primary key,
FanPhoneNumber varchar(20),
FanName varchar(20),
FanAddress varchar(100),
FanStatus bit,
FanBirthdate date,
Username varchar(20) foreign key references SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
create Table Ticket(
TicketID int primary key Identity,
TicketStatus bit,
MatchID int foreign key references Match (MatchID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
NationalID varchar(20) foreign key references Fan (NationalID) ON DELETE CASCADE ON UPDATE CASCADE
);
create table SportsAssociationManager(
SportsAssociationManagerID int primary key Identity,
SportsAssociationManagerName varchar(20),
Username varchar(20) foreign key references SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
create table SystemAdmin(
SystemAdminID int primary key Identity,
SystemAdminName varchar(20),
Username varchar(20) foreign key references SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE HostRequest(
HostRequestID int primary key identity,
HostRequestStatus VARCHAR(20),
MatchID int foreign key references Match (MatchID) ON DELETE CASCADE NOT NULL,
ClubRepresentativeID int foreign key references ClubRepresentative (ClubRepresentativeID)  NOT NULL,
StadiumManagerID int foreign key references StadiumManager (StadiumManagerID) 
);

go;
create procedure dropAllTables
AS
Drop Table HostRequest
Drop Table SystemUser
Drop Table SystemAdmin
Drop Table SportsAssociationManager
Drop Table Ticket
Drop Table Fan
Drop Table Match
Drop Table ClubRepresentative
Drop Table Club
Drop Table StadiumManager
Drop Table Stadium
GO;
Create procedure clearAllTables
AS
Truncate Table HostRequest
Truncate Table SystemUser
Truncate Table SystemAdmin
Truncate Table SportsAssociationManager
Truncate Table Ticket
Truncate Table Fan
DELETE from Fan
DELETE from Match
DELETE from ClubRepresentative
DELETE from Club
DELETE from StadiumManager
DELETE from Stadium
GO;
CREATE procedure dropAllProceduresFunctionsViews
as
drop procedure createAllTables
drop procedure dropAllTables
drop procedure clearAllTables
drop view allAssocManagers
drop view allClubRepresentatives
drop view allStadiumManagers
drop view allFans
drop view allMatches
drop view allTickets
drop view allCLubs
drop view allStadiums
drop view allRequests
drop procedure addAssociationManager
drop procedure addNewMatch
drop procedure clubsWithNoMatches
drop procedure deleteMatch
drop procedure deleteMatchesOnStadium
drop procedure addClub
drop procedure addTicket
drop procedure deleteClub
drop procedure addStadium
drop procedure deleteStadium
drop procedure blockFan
drop procedure unblockFan
drop procedure addRepresentative
drop function viewAvailableStadiumsOn
drop procedure addHostRequest
drop function allUnassignedMatches
drop procedure addStadiumManager
drop function allPendingRequests
drop procedure acceptRequest
drop procedure rejectRequest
drop procedure addFan
drop function upcomingMatchesOfClub
drop function availableMatchesToAttend
drop procedure purchaseTicket
drop procedure updateMatchHost
drop view matchesPerTeam
drop view clubsNeverMatched
drop function clubsNeverPlayed
drop function matchWithHighestAttendance
drop function matchesRankedByAttendance
drop function requestsFromClub
go;
create view allAssocManagers
AS SELECT SAM.username,S.SystemUserPassword,SAM.SportsAssociationManagerName 
FROM SportsAssociationManager SAM INNER JOIN SystemUser S ON S.Username = SAM.Username;
GO;

create view allClubRepresentatives
AS SELECT CR.username,S.SystemUserPassword, CR.ClubRepresentativeName , C.ClubName
FROM ClubRepresentative CR 
INNER JOIN Club C ON C.ClubId = CR.ClubId
INNER JOIN SystemUser S ON S.Username = CR.Username
GO;

create view allStadiumManagers
AS SELECT SM.username,SU.SystemUserPassword,SM.StadiumManagerName, S.StadiumName
FROM StadiumManager SM
INNER JOIN Stadium S ON SM.StadiumID=S.StadiumID
INNER JOIN SystemUser SU ON SU.Username = SM.Username
GO;

create view allFans
AS SELECT F.Username,S.SystemUserPassword,F.FanName, F.NationalID, F.FanBirthDate, F.FanStatus
FROM Fan F INNER JOIN SystemUser S ON S.Username = F.Username;
Go;

create view allMatch
AS SELECT C1.ClubName as Host , C2.ClubName as Visitor, M.StartTime       
FROM Match M
INNER JOIN Club C1 ON M.HostID=C1.ClubId
INNER JOIN Club C2 ON M.VisitorID=C2.ClubId
Go;

create view allTickets
AS SELECT C1.ClubName as Host, C2.ClubName as Visitor,S.StadiumName,M.StartTime
FROM Ticket T 
INNER JOIN Match M ON T.MatchID=M.MatchID
INNER JOIN Club C1 ON M.HostID=C1.ClubId
INNER JOIN Club C2 ON M.VisitorID=C2.ClubId	
INNER JOIN Stadium S ON M.StadiumID = S.StadiumID
go;


create view allCLubs
AS SELECT ClubName, ClubLocation
FROM Club
GO;

create view allStadiums
AS SELECT StadiumName, StadiumLocation, Capacity, StadiumStatus
FROM Stadium
GO;

create view allRequests
AS SELECT C.Username AS Club_Representative_Username , S.Username AS Stadium_Manager_Username , H.HostRequestStatus
FROM ClubRepresentative C
INNER JOIN HostRequest H ON C.ClubRepresentativeID= H.ClubRepresentativeID
INNER JOIN StadiumManager S ON H.StadiumManagerID=S.StadiumManagerID
GO;

CREATE PROC addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20) ,
@done BIT OUTPUT
AS
IF  not exists(SELECT username from SystemUser where username = @username)
begin
INSERT INTO SystemUser VALUES(@username,@password)
INSERT INTO SportsAssociationManager VALUES(@name,@username)
SET @done =1
end;
ELSE
BEGIN
SET @done = 0
END
return @done
go;

CREATE PROC addNewMatch
@host_name varchar(20),
@guest_club varchar(20),
@start_time DATETIME,
@end_time DATETIME
AS

Declare @guest_id int
Select @guest_id=Club.ClubID FROM Club Where Club.ClubName=@guest_club

Declare @host_id int
Select @host_id=Club.ClubID FROM Club Where Club.ClubName=@host_name


INSERT INTO Match(StartTime,EndTime,HostID,VisitorID) Values(@start_time,@end_time,@host_id,@guest_id)

	
GO;


CREATE VIEW clubsWithNoMatch
AS 
Select C.ClubName from Club C 
left outer join Match M ON M.HostID = C.ClubId
left outer join Match M2 on M2.VisitorID=C.ClubId
where M.MatchID is NULL and M2.MatchID IS NULL
go;

CREATE PROC deleteMatch
@host_name varchar(20),
@guest_club varchar(20),
@start_time Datetime,
@End_time datetime
AS

Declare @guest_id int
Select @guest_id=Club.ClubID FROM Club Where Club.ClubName=@guest_club

Declare @host_id int
Select @host_id=Club.ClubID FROM Club Where Club.ClubName=@host_name

Delete from Match 
where Match.HostID = @host_id 
	AND Match.VisitorID = @guest_id 
	and Match.StartTime = @start_time
	AND Match.EndTime = @End_time
GO;

CREATE PROC deleteMatchOnStadium
@Stadium_name varchar(20)
AS
Declare @stadium_id int
Select @stadium_id=Stadium.StadiumID FROM Stadium Where Stadium.StadiumName = @Stadium_name

DELETE FROM Match where Match.StadiumID = @stadium_id AND CURRENT_TIMESTAMP > Match.StartTime
go;

CREATE PROC addClub
@club_name varchar(20),
@location varchar(20)
AS
INSERT INTO Club VALUES(@club_name,@location);
GO

CREATE PROCEDURE addTicket 
@host_name VARCHAR(20),
@comp_name VARCHAR(20),
@start_time VARCHAR(20)
as

Declare @host_id int
Select  @host_id=Club.ClubId  FROM Club Where Club.ClubName=@host_name

Declare @comp_id int
Select @comp_id=Club.ClubID FROM Club Where Club.ClubName=@comp_name

DECLARE @Match_id int

Select @Match_id = Match.MatchID from Match where Match.HostID = @host_id and Match.VisitorID = @comp_id

INSERT INTO Ticket(TicketStatus,MatchID) VALUES (0,@Match_id)
go;

CREATE PROCEDURE deleteClub
@club_name VARCHAR(20)
as

Declare @club_id int
Select  @club_id=Club.ClubId  FROM Club Where Club.ClubName=@club_name

DELETE FROM Match where Match.VisitorID = @club_id

delete from Club where Club.ClubName = @club_name

GO;

CREATE PROC addStadium
@stadium_name varchar(20),
@location varchar(20),
@capacity int
as
INSERT INTO Stadium(StadiumName,Capacity,StadiumLocation) values(@stadium_name,@capacity,@location)
go;

CREATE PROC deleteStadium
@stadium_name varchar(20)
as
DELETE FROM Stadium WHERE Stadium.StadiumName = @stadium_name
GO;

CREATE PROC blockFan
@nat_id VARCHAR(20)
as
update Fan set FanStatus = '0' where Fan.NationalID = CONVERT(INT,@nat_id)
go;

CREATE PROC unblockFan
@nat_id varchar(20)
as
update Fan set FanStatus = '1' where Fan.NationalID = @nat_id
go;

CREATE PROC addRepresentative
@name varchar(20),
@club_name varchar(20),
@username varchar(20),
@Password varchar(20),
@done BIT output
AS 

Declare @club_id int
Select  @club_id=Club.ClubId  FROM Club Where Club.ClubName=@club_name

IF  not exists(SELECT username from SystemUser where username = @username)
begin
INSERT INTO SystemUser VALUES (@username, @Password)
insert into ClubRepresentative VALUES (@name, @username, @club_id)

SET @done = 1
end
ELSE
BEGIN
SET @done = 0
END
RETURN @done
GO;

CREATE FUNCTION viewAvailableStadiumsOn
(@date datetime)
returns table
AS
return
(Select S.StadiumName, S.StadiumLocation,S.Capacity 
from Stadium S
where S.StadiumStatus = '1' and not exists(select M.StadiumID from Match M where (@date>= M.StartTime AND @date<=M.EndTime) and S.StadiumID = M.StadiumID)
)	
go;

CREATE PROC addHostRequest
@club_name varchar(20),
@stadium_name varchar(20),
@start_time datetime
as

Declare @club_id int
Select  @club_id=Club.ClubId  FROM Club Where Club.ClubName=@club_name

DECLARE @CR_ID int 
Select @CR_ID = ClubRepresentative.ClubRepresentativeID from ClubRepresentative where ClubRepresentative.ClubId = @club_id

Declare @stadium_id int
Select  @stadium_id=Stadium.StadiumID  FROM Stadium Where Stadium.StadiumName=@stadium_name

DECLARE @SM_ID int 
Select @SM_ID = StadiumManager.StadiumManagerID from StadiumManager where StadiumManager.StadiumID = @stadium_id

DECLARE @match_id int
select @match_id = Match.MatchID from Match INNER JOIN Club C ON C.ClubId = Match.HostID where Match.StartTime = @start_time and C.ClubName = @club_name

INSERT INTO HostRequest(MatchID,StadiumManagerID,ClubRepresentativeID) VALUES (@match_id,@SM_ID,@CR_ID)

GO;



CREATE FUNCTION allUnassignedMatch
(@club_name varchar(20))
returns table
AS

return(

SELECT C2.ClubName,Match.StartTime FROM Match INNER JOIN Club C ON Match.HostID = C.ClubId INNER JOIN Club C2 ON C2.ClubId = Match.VisitorID
WHERE C.ClubName = @club_name and Match.StadiumID IS NULL
)

go;

CREATE PROC addStadiumManager
@name varchar(20),
@StadiumName varchar(20),
@username varchar(20),
@password varchar(20),
@done bit output
AS

Declare @stadium_id int
Select  @stadium_id=Stadium.StadiumID  FROM Stadium Where Stadium.StadiumName=@StadiumName
IF  not exists(SELECT username from SystemUser where username = @username)
BEGIN
INSERT INTO SystemUser VALUES (@username, @password)
INSERT INTO StadiumManager VALUES (@name, @username, @stadium_id)
Set @done = 1
END
else
begin
set @done = 0
end
go;

CREATE FUNCTION allPendingRequests
(@SM_username varchar(20))
returns table
AS
RETURN(
SELECT CR.ClubRepresentativeName,c2.ClubName as Host,C.ClubName AS Visitor,M.StartTime,M.EndTime FROM HostRequest H 
INNER JOIN ClubRepresentative CR ON H.ClubRepresentativeID = CR.ClubRepresentativeID
INNER JOIN StadiumManager SM ON SM.StadiumManagerID = H.StadiumManagerID
INNER JOIN Match M ON M.MatchID = H.MatchID
INNER JOIN Club C ON C.ClubId = M.VisitorID
INNER JOIN Club C2 on c2.ClubId = m.HostID
WHERE H.HostRequestStatus = 'Unhandled' and SM.Username = @SM_username
)
go;

create proc acceptRequest
@ManagerUserName varchar(20),
@HostingName varchar(20),
@CompetingName varchar(20),
@StartTime datetime

AS

DECLARE @SM_ID int
SELECT @SM_ID = StadiumManager.StadiumManagerID FROM StadiumManager WHERE StadiumManager.Username=@ManagerUserName
print(@SM_ID)
DECLARE @HostID int
SELECT @HostID = Club.ClubId FROM Club WHERE Club.ClubName = @HostingName
 print(@HostID)
DECLARE @CR_ID int
SELECT @CR_ID = ClubRepresentative.ClubRepresentativeID FROM ClubRepresentative WHERE ClubRepresentative.ClubId= @HostID
 print(@CR_ID)
DECLARE @CC_ID int
SELECT @CC_ID = Club.ClubId FROM Club WHERE Club.ClubName = @CompetingName
print(@CC_ID)
DECLARE @MATCH_ID int
SELECT @MATCH_ID = Match.MatchID from Match 
where Match.HostID = @HostID and Match.VisitorID = @CC_ID and Match.StartTime = @StartTime
print(@MATCH_ID)
update HostRequest set HostRequestStatus = 'Accepted' 
where HostRequest.ClubRepresentativeID = @CR_ID and HostRequest.StadiumManagerID = @SM_ID and HostRequest.MatchID = @MATCH_ID

DECLARE @S_ID int
SELECT @S_ID = StadiumManager.StadiumID FROM StadiumManager WHERE StadiumManager.StadiumManagerID = @SM_ID

UPDATE Match SET StadiumID = @S_ID WHERE MatchID = @MATCH_ID

DECLARE @i int 
	set @i=0

declare @cap int
	select @cap = S.Capacity from Stadium S where S.StadiumID = @S_ID

while(@i<@cap)
	begin
		INSERT INTO Ticket(TicketStatus,MatchID) values(1,@MATCH_ID);
		set @i = @i + 1
	end

go;

drop proc acceptRequest
create proc rejectRequest
@ManagerUserName varchar(20),
@HostingName varchar(20),
@CompetingName varchar(20),
@StartTime datetime

AS

DECLARE @SM_ID int
SELECT @SM_ID = StadiumManager.StadiumManagerID FROM StadiumManager WHERE StadiumManager.StadiumManagerName=@ManagerUserName

DECLARE @HostID int
SELECT @HostID = Club.ClubId FROM Club WHERE Club.ClubName = @HostingName
 
DECLARE @CR_ID int
SELECT @CR_ID = ClubRepresentative.ClubRepresentativeID FROM ClubRepresentative WHERE ClubRepresentative.ClubId= @HostID

DECLARE @CC_ID int
SELECT @CC_ID = Club.ClubId FROM Club WHERE Club.ClubName = @CompetingName

DECLARE @MATCH_ID int
SELECT @MATCH_ID = Match.MatchID from Match 
where Match.HostID = @HostID and Match.VisitorID = @CC_ID and Match.StartTime = @StartTime

update HostRequest set HostRequestStatus = 'Rejected' 
where HostRequest.ClubRepresentativeID = @CR_ID and HostRequest.StadiumManagerID = @SM_ID and HostRequest.MatchID = @MATCH_ID

go;

CREATE PROC addFan
@name varchar(20),
@username varchar(20),
@password varchar(20),
@NationalID varchar(20),
@birthDate varchar(20),
@address varchar(20),
@PhoneNumber int

AS
IF  not exists(SELECT username from SystemUser where username = @username)
BEGIN
INSERT INTO SystemUser VALUES (@username, @password)
INSERT INTO Fan VALUES(@NationalID, @PhoneNumber, @name, @address, 1, @birthDate, @username)
END
GO;

create function upcomingMatchOfClub
(@club_name varchar(20))
returns table
as 
RETURN( select C1.ClubName AS Host , c2.ClubName as Visitor ,M.StartTime,M.EndTime  
from Match M INNER JOIN Club C1 ON M.HostID = C1.ClubId 
INNER JOIN Club C2 ON M.VisitorID = C2.ClubId 
WHERE (C1.ClubName = @club_name OR C2.ClubName = @club_name) and M.StartTime > CURRENT_TIMESTAMP)
go;

create function availableMatchToAttend
(@date DATETIME)
returns table
as
return(
SELECT distinct C.ClubName AS Host , C2.ClubName as Visitor , M.StartTime , S.StadiumName 
from Match M 
INNER JOIN Club C ON C.ClubId = M.HostID 
INNER JOIN Club C2 ON C2.ClubId = M.VisitorID 
INNER JOIN Stadium S ON S.StadiumID = M.StadiumID
INNER JOIN Ticket T ON T.MatchID = M.MatchID
WHERE M.StartTime>=@date AND T.TicketStatus = '1'
)
go;

CREATE PROC purchaseTicket
@nat_id varchar(20),
@host_name varchar(20),
@comp_name varchar(20),
@start_time datetime
AS

declare @match_id int
select @match_id = M.MatchID from Match M 
INNER JOIN Club C1 ON C1.ClubId = M.HostID 
INNER JOIN CLUB C2 ON C2.ClubId = M.VisitorID
WHERE C1.ClubName = @host_name AND C2.ClubName = @comp_name AND M.StartTime = @start_time

UPDATE TOP(1) Ticket SET TicketStatus = '0',NationalID = @nat_id WHERE Ticket.MatchID = @match_id;
GO;

CREATE PROC updateMatchHost
@host_name varchar(20),
@comp_name varchar(20),
@start_time datetime
AS

Declare @host_id int
Select  @host_id=Club.ClubId  FROM Club Where Club.ClubName=@host_name

Declare @comp_id int
Select @comp_id=Club.ClubID FROM Club Where Club.ClubName=@comp_name

update Match set HostID = @comp_id , VisitorID = @host_id,StadiumID = null where HostID = @host_id and VisitorID = @comp_id

GO;

CREATE VIEW MatchPerTeam
as
SELECT C.ClubName AS Club,COUNT(M.MatchID) as Number_of_matches_played FROM Match M 
right outer JOIN Club C ON C.ClubId = M.HostID OR C.ClubId = M.VisitorID
GROUP BY C.ClubName;
go;

CREATE VIEW clubsNeverMatched
AS
SELECT  C1.ClubName AS Host,C2.ClubName AS Visitor FROM Club C1 
INNER JOIN Club C2 ON C1.ClubId<>C2.ClubId 
WHERE NOT EXISTS (SELECT M.HostID,M.VisitorID 
					FROM Match M 
					WHERE (M.HostID = C1.ClubId AND M.VisitorID = C2.ClubId) 
							or (M.HostID = C2.ClubId and M.VisitorID = C1.ClubId))  
				and C1.ClubId > C2.ClubId
GO;

CREATE FUNCTION clubsNeverPlayed
()
returns table
as
return(
SELECT C.ClubName as Host ,C2.ClubName as Visitor FROM Club C inner join Club C2 ON C.ClubId <> C2.ClubId
WHERE NOT EXISTS(SELECT C3.ClubName ,C4.ClubName
					FROM Match M 
					INNER JOIN Club C3 ON C3.ClubId = M.VisitorID
					INNER JOIN Club C4 ON C4.ClubId = M.HostID
					WHERE C3.ClubName = C.ClubName AND C4.ClubName=C2.ClubName)
	  AND
	  NOT EXISTS(SELECT C5.ClubName,C6.ClubName
					FROM Match M 
					INNER JOIN Club C5 ON C5.ClubId = M.HostID
					INNER JOIN Club C6 ON C6.ClubId = M.VisitorID
					WHERE  C5.ClubName = C.ClubName AND C6.ClubName=C2.ClubName)
	AND
	C.ClubId > C2.ClubId
)
go;


CREATE FUNCTION matchWithHighestAttendance
()
returns table
as
return(
	SELECT C1.ClubName AS Host,C2.ClubName AS Visitor,COUNT(T.TicketID) AS Number_Of_Tickets_Sold 
	FROM Ticket T 
	INNER JOIN Match M ON M.MatchID = T.MatchID 
	INNER JOIN Club C1 ON C1.ClubId = M.HostID 
	INNER JOIN CLUB C2 ON C2.ClubId = M.VisitorID
	WHERE T.TicketStatus = '0' and M.StartTime < CURRENT_TIMESTAMP
	GROUP BY M.MatchID,C1.ClubName,C2.ClubName
	HAVING COUNT(T.TicketID) = (SELECT MAX(X) 
								FROM(
									SELECT COUNT(TicketID) as X 
									from Ticket T2 INNER JOIN Match M2 ON M2.MatchID = T2.MatchID 
									WHERE T2.TicketStatus = '0' and M2.StartTime < CURRENT_TIMESTAMP
									GROUP BY T2.MatchID
									)
								AS T)
)
go;

CREATE FUNCTION MatchRankedByAttendance
()
returns @RESULT table(
	Host_Club varchar(20),
	Visitor_Club varchar(20),
	Number_Of_Tickets_Sold int
)
as
begin
INSERT INTO @RESULT
	SELECT C1.ClubName,C2.ClubName,COUNT(T.TicketID) FROM Ticket T 
	INNER JOIN Match M ON M.MatchID = T.MatchID INNER JOIN Club C1 ON C1.ClubId = M.HostID 
	INNER JOIN CLUB C2 ON C2.ClubId = M.VisitorID
	WHERE T.TicketStatus = '0' and M.StartTime < CURRENT_TIMESTAMP
	GROUP BY M.MatchID,C1.ClubName,C2.ClubName
	ORDER BY COUNT(T.TicketID) DESC 
return
end
go;

CREATE FUNCTION requestsFromClub
(@stadium_name varchar(20),@club_name varchar(20))
returns table
as
return(
SELECT C1.ClubName AS Host,C2.ClubName AS Visitor FROM Stadium S 
INNER JOIN StadiumManager SM ON S.StadiumID = SM.StadiumID 
INNER JOIN HostRequest H ON H.StadiumManagerID = SM.StadiumManagerID 
INNER JOIN ClubRepresentative CR ON CR.ClubRepresentativeID = H.ClubRepresentativeID 
INNER JOIN Club C ON C.ClubId = CR.ClubId
INNER JOIN Match M ON H.MatchID = M.MatchID
INNER JOIN Club C1 ON M.HostID = C1.ClubId
INNER JOIN Club C2 ON M.VisitorID = C2.ClubId
WHERE S.StadiumName = @stadium_name AND C.ClubName = @club_name
)
go;

GO
CREATE PROC CredinitialVerficaftion
@username VARCHAR(20),
@password VARCHAR(20),
@Result BIT OUTPUT,
@type varchar(4) output
 
AS
IF(EXISTS(SELECT S.Username,S.SystemUserPassword 
    FROM SystemUser S 
    WHERE S.Username = @username and S.SystemUserPassword = @password))
BEGIN
	SET @Result=1
END
ELSE
BEGIN
	SET @Result=0
END

IF(EXISTS(SELECT F.Username
          FROM SystemUser S INNER JOIN Fan F ON F.Username=S.Username
		  WHERE S.Username = @username and S.SystemUserPassword = @password))
          BEGIN
              SET @type='F'
          END

IF(EXISTS(SELECT SM.Username 
          FROM SystemUser S INNER JOIN StadiumManager SM ON SM.Username=S.Username
          WHERE S.Username = @username and S.SystemUserPassword = @password))
          BEGIN
				SET @type='SM'
          END

IF(EXISTS(SELECT CR.Username 
           FROM SystemUser S INNER JOIN ClubRepresentative CR ON CR.Username=S.Username
           WHERE S.Username = @username and S.SystemUserPassword = @password))
           BEGIN
				 SET @type='CR'
           END

 IF(EXISTS(SELECT SAM.Username 
            FROM SystemUser S INNER JOIN SportsAssociationManager SAM ON SAM.Username=S.Username
            WHERE S.Username = @username and S.SystemUserPassword = @password))
            BEGIN
                SET @type='SAM'
            END

IF(EXISTS(SELECT SA.Username 
		  FROM SystemUser S INNER JOIN SystemAdmin SA ON SA.Username=S.Username
          WHERE S.Username = @username and S.SystemUserPassword = @password))
          BEGIN
                SET @type='SA'
          END
GO

drop proc CredinitialVerficaftion

CREATE PROC ValidateClub
@club_name varchar(20),
@found BIT OUTPUT
AS
IF(NOT EXISTS(SELECT Club.ClubName FROM Club LEFT OUTER JOIN ClubRepresentative CR ON CR.ClubId = CLUB.ClubId WHERE Club.ClubName = @club_name AND CR.ClubRepresentativeID IS NULL))
BEGIN
	SET @found = 0
END
ELSE
BEGIN 
	SET @found = 1
END
GO;

CREATE PROC ValidateStadium
@stadium_name varchar(20),
@found BIT OUTPUT
AS
IF(NOT EXISTS(SELECT S.StadiumName FROM Stadium S LEFT OUTER JOIN StadiumManager SM ON SM.StadiumID = S.StadiumID WHERE S.StadiumName = @stadium_name AND SM.StadiumManagerID IS NULL))
BEGIN
	SET @found = 0
END
ELSE
BEGIN 
	SET @found = 1
END
GO;

CREATE PROC getStadium
@stadium_manager varchar(20),
@stadium_ID int output,
@stadium_name varchar(20) output,
@capacity varchar(20) output,
@location varchar(20) output,
@status bit output
as


select @stadium_ID=S.StadiumID,@stadium_name=S.StadiumName,@capacity=S.Capacity,@location=S.StadiumLocation,@status=S.StadiumStatus 
from StadiumManager SM inner join Stadium S on S.StadiumID=SM.StadiumID 
WHERE SM.Username = @stadium_manager
GO;

CREATE PROC getClub
@ClubR varchar(20),
@Club_ID int output,
@Club_name varchar(20) output,
@location varchar(20) output
as


select @Club_ID=C.ClubId,@Club_name=C.ClubName,@location=C.ClubLocation
from ClubRepresentative CR inner join Club C on CR.ClubId=C.ClubId 
WHERE CR.Username = @ClubR
GO;

create function allupcomingMatches
()
returns table
as 
RETURN( select C1.ClubName AS Host , c2.ClubName as Visitor ,M.StartTime,M.EndTime  
from Match M INNER JOIN Club C1 ON M.HostID = C1.ClubId 
INNER JOIN Club C2 ON M.VisitorID = C2.ClubId
WHERE (M.StartTime > CURRENT_TIMESTAMP)
)
go;


create function allPlayedMatches
()
returns table
as 
RETURN( select C1.ClubName AS Host , c2.ClubName as Visitor ,M.StartTime,M.EndTime  
from Match M INNER JOIN Club C1 ON M.HostID = C1.ClubId 
INNER JOIN Club C2 ON M.VisitorID = C2.ClubId 
WHERE (M.StartTime < CURRENT_TIMESTAMP)
)
go;


CREATE PROC Matchexists
@host_name varchar(20),
@visitor_name varchar(20),
@start_time DATETIME,
@end_time DATETIME,
@Exist BIT output
AS
IF(EXISTS(SELECT * FROM Match M INNER JOIN Club C ON C.ClubId = M.HostID INNER JOIN Club C2 ON C2.ClubId = M.VisitorID WHERE C.ClubName = @host_name AND C2.ClubName = @visitor_name AND M.StartTime = @start_time AND M.EndTime = @end_time))
BEGIN
SET @Exist = '1'
END
ELSE
BEGIN 
SET @Exist = '0'
END
GO;

CREATE PROC Clubexists
@club varchar(20),
@Exist BIT output
AS
IF(EXISTS(SELECT * FROM Club WHERE Club.ClubName = @club))
BEGIN
SET @Exist = '1'
END

ELSE
BEGIN
SET @Exist = '0'
END
go;

CREATE PROC Stadiumexists
@stadium varchar(20),
@Exist BIT output
AS
IF(EXISTS(SELECT * FROM Stadium WHERE Stadium.StadiumName=@stadium))
BEGIN
SET @Exist = '1'
END

ELSE
BEGIN
SET @Exist = '0'
END
go;

CREATE PROC FanExists
@nat_id varchar(20),
@exist bit output
as
if(exists(SELECT * FROM Fan WHERE Fan.NationalID = @nat_id))
BEGIN 
SET @exist = '1'
END 
ELSE
BEGIN 
SET @exist = '0'
END
GO;

CREATE PROC getID
@username varchar(20),
@ID varchar(20) output
as
select @ID=Fan.NationalID from Fan where fan.Username = @username
go;

----------------------------------------------------------------------------------------------------------------------------



