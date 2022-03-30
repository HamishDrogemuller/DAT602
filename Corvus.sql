
-- Drop Database to allow clean start
Drop Database if exists Corvus;
Create Database Corvus;
Use Corvus;

-- Drop Procedure
Drop Procedure if exists MakeCorvus;
DELIMITER //
Create Procedure MakeCorvus()
Begin
-- Dropping tables to reset database
	Drop Table if Exists tblAccount;
    Drop Table if Exists tblPlayerBoard;
    Drop Table if Exists tblInventory;
    Drop Table if Exists tblSession;
    Drop Table if Exists tblBoard;
    Drop Table if Exists tblItem;
    Drop Table if Exists tblGame;
    Drop Table if Exists tblChat;
    Drop Table if Exists tblGameBoard;
    Drop Table if Exists tblBoardTile;
    Drop Table if Exists tblTileType;
    
-- Table Creation and Population    

	Create Table tblBoard
    (
		boardID Int Primary Key Auto_Increment,
        boardType Varchar(10)
    );
    
    Insert Into tblBoard(boardID,boardType)
    Values
		(1,'Game'),
		(2,'Player');
        
         Create Table tblItem
   (
		itemID Int Primary Key,
        itemDescription Varchar(255)
   );
    
    Create Table tblBoardTile
    (
		tileID Int Primary Key Auto_Increment,
        boardID Int,
        tileRow Int,
        tileColumn Int,
        tileStatus Int,
        Foreign Key (boardID) References tblBoard(boardID)
    );
    
    Insert Into tblBoardTile(tileID,tileRow,tileColumn,tileStatus)
    Values
		(1,1,1,Null),
		(2,2,2,Null),
		(3,3,3,Null),
		(4,4,4,Null),
		(5,5,5,Null),
		(6,6,6,Null),
		(7,7,7,Null),
		(8,8,8,Null),
		(9,9,9,Null),
		(10,10,10,Null),
		(11,0,11,Null),
		(12,0,12,Null),
		(13,0,13,NUll),
		(14,0,14,NUll),
		(15,0,15,Null),
		(16,0,16,Null),
		(17,0,17,Null),
		(18,0,18,Null),
		(19,0,19,Null),
		(20,0,20,Null);

    Create Table tblTileType 
    (
		tileTypeID Int Primary Key Auto_Increment,
        tileID Int,
        itemID Int,
		tileTypeDescription Varchar(255),
        Foreign Key (tileID) References tblBoardTile(tileID),
        Foreign Key (itemID) References tblItem(itemID)
    );
    
    Insert Into tblTileType(tileTypeID, tileTypeDescription)
	Values 
		(1, 'Crow'),
		(2, 'Item'),
		(3, 'Player');
        
   Create Table tblAccount 
   (
		playerID Int Primary Key Auto_Increment,
        username Varchar(20),
        `password` Varchar(50),
        email Varchar(50),
        lockedUser Bool,
        `admin` Bool,
        loginAttempt Smallint,
        `online` Bool,
        wins Int,
        loses Int,
        scorePerMinute Int,
        activeTile Int
   );
	
    Insert Into tblAccount(playerID,username,`password`,email,`admin`)
    Values
		(1,'Strix','@3141519Corvidae','strixhc@gmail.com', True),
		(2,'Thanatos','HadesSucks','than@tos.com', False),
		(3,'Zagreus','HadesSucks2','zag@gmail.com', False),
		(4,'Hades','HadesRules321','hades@gmail.com', False),
		(5,'Nyx','worldsBestMum','nyx@styx.com', True),
		(6,'Cerberus','goodboy','goodboy@styx.com', False),
		(7,'Hera','ZeusSucks','queen@olympus.com', False),
		(8,'Zeus','lookingforfun123','king@olympus.com', False),
		(9,'Hypnos','likes2Sleep','hypnos@zzz.com', False),
		(10,'Achilles','Patroclus<3','achilles@protonmail.com',False);
    
   Create Table tblGame
   (
		gameID Int Primary key,
		gameName Varchar(50),
		gamestatus Bool
   );
   
   Create Table tblplayerBoard
   (
		playerID Int,
        boardID Int,
        playerNumber Int,
        Primary Key(playerID,BoardID),
        Foreign Key (playerID) References tblAccount(playerID),
        Foreign Key (boardID) References tblBoard(boardID)
   );
   
   Create Table tblgameBoard
   (
		boardID Int,
        gameID Int,
        boardNumber Int,
        Primary Key(boardID,gameID),
        Foreign Key (boardID) References tblBoard(boardID),
        Foreign Key (gameID) References tblGame(gameID)
   );
   
   
   Create Table tblInventory
   (
		itemPlaceID Int Primary Key,
        playerID Int,
        itemID Int,
        Foreign Key (playerID) References tblAccount(playerID),
        Foreign Key (itemID) References tblItem(itemID)
   );
   
   Create Table tblSession
   (
		gameID Int,
        playerID Int,
        score Int,
        birdCount Int,
        Primary Key (gameID,playerID),
        Foreign Key (gameID) References tblGame(gameID),
        Foreign Key (playerID) References tblAccount(playerID)
   );
   
   Create Table tblChat
   (
		playerID Int,
        gameID Int,
        message Varchar(255),
        Primary Key (gameID,playerID),
        Foreign Key (gameID) References tblGame(gameID),
        Foreign Key (playerID) References tblAccount(playerID)
   );
    
END//
Delimiter ;

-- Calling procedure to create database
Call MakeCorvus;


Drop Procedure if exists AddNewUser;
DELIMITER //
-- Adding a new user procedure
Create Procedure AddNewUser(pusername Varchar(20), ppassword Varchar(50), pemail Varchar(50))
Begin
  If Exists (Select * 
     From tblAccount
     Where username = pusername) 
     Then
		Begin
			Select 'User Exists' As Message;
		End;
	Else
		Insert Into tblAccount(username,`password`,email)
        Values
			(pusername,ppassword,pemail);
            Select 'Welcome to Corvus' As Message;
		End If;
        
        End //
DELIMITER ;

Call AddNewUser('Sisyphus','Boulderpusher#1','Sisyphus@rockroll.com');



