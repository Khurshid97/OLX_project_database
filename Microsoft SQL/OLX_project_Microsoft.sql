
DROP TABLE IF EXISTS saved_ads;
DROP TABLE IF EXISTS [Transaction];
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Favourite;
DROP TABLE IF EXISTS UserE;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Ads;


-- Table: Ads
CREATE TABLE Ads (
    ID INT  NOT NULL PRIMARY KEY,
    name VARCHAR(100)  NOT NULL,
    description VARCHAR(100)  NOT NULL,
    price DECIMAL(9,2)  NOT NULL,
    Category_ID INT  NOT NULL,
    Location_ID INT  NOT NULL,
    User_ID INT  NOT NULL
);

-- Table: Category
CREATE TABLE Category (
    ID INT  NOT NULL PRIMARY KEY,
    name VARCHAR(100)  NOT NULL
);

-- Table: City
CREATE TABLE City (
    ID INT  NOT NULL PRIMARY KEY,
    name VARCHAR(50)  NOT NULL
);

-- Table: Location
CREATE TABLE Location (
    ID INT  NOT NULL PRIMARY KEY,
    address VARCHAR(100)  NOT NULL,
    City_ID INT  NOT NULL,
    FOREIGN KEY (City_ID) REFERENCES City (ID)
);

-- Table: User
CREATE TABLE UserE (
    ID INT  NOT NULL PRIMARY KEY,
    username VARCHAR(50)  NOT NULL,
    contact VARCHAR(14)  NOT NULL,
    name VARCHAR(50)  NOT NULL,
    surname VARCHAR(50)  NOT NULL,
    Location_ID INT  NOT NULL,
    FOREIGN KEY (Location_ID) REFERENCES Location (ID)
);

-- Table: Favourite
CREATE TABLE Favourite (
    Ads_ID INT  NOT NULL,
    User_ID INT  NOT NULL,
    CONSTRAINT Favourite_pk PRIMARY KEY (Ads_ID, User_ID),
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID),
    FOREIGN KEY (User_ID) REFERENCES UserE (ID)
);


-- Table: Message
CREATE TABLE Message (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    time DATETIME  NOT NULL,
    context VARCHAR(1000)  NOT NULL,
    Ads_ID INT  NOT NULL,
    sender INT  NOT NULL,
    recipient INT  NOT NULL,
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID),
    FOREIGN KEY (sender) REFERENCES UserE (ID),
    FOREIGN KEY (recipient) REFERENCES UserE (ID)
);

-- Table: Product
CREATE TABLE Product (
    Ads_ID INT  NOT NULL PRIMARY KEY,
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID)
);

-- Table: Service
CREATE TABLE Service (
    availability SMALLINT  NOT NULL,
    Ads_ID INT  NOT NULL PRIMARY KEY,
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID)
);

-- Table: Transaction
CREATE TABLE [Transaction] (
    ID INT  NOT NULL PRIMARY KEY,
    date DATE  NOT NULL,
    amount DECIMAL(9,2)  NOT NULL,
    Ads_ID INT  NOT NULL,
    buyer INT  NOT NULL,
    seller INT  NOT NULL,
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID),
    FOREIGN KEY (buyer) REFERENCES UserE (ID),
    FOREIGN KEY (seller) REFERENCES UserE (ID)
);


-- Table: saved_ads
CREATE TABLE saved_ads (
    Ads_ID INT  NOT NULL,
    User_ID INT  NOT NULL,
    CONSTRAINT saved_ads_pk PRIMARY KEY (Ads_ID, User_ID),
    FOREIGN KEY (Ads_ID) REFERENCES Ads (ID),
    FOREIGN KEY (User_ID) REFERENCES UserE (ID)
);

-- INSERTING ELEMENTS TO CITY ENTITY
INSERT INTO City (ID, name) VALUES (1, 'Warsaw');
INSERT INTO City (ID, name) VALUES (2, 'Wroclaw'); 
INSERT INTO City (ID, name) VALUES (3, 'Gdansk'); 
INSERT INTO City (ID, name) VALUES (4, 'Lublin'); 

-- INSERTING ELEMENTS TO Location ENTITY
INSERT INTO Location (ID, address, City_ID) VALUES  (1, '121 Kozykowa St', 1);
INSERT INTO Location (ID, address, City_ID) VALUES  (2, '95 Somewher St', 2);
INSERT INTO Location (ID, address, City_ID) VALUES  (3, '25 Nowhere St', 3);
INSERT INTO Location (ID, address, City_ID) VALUES  (4, '13 Unlucky St', 4);

-- INSERTING ELEMENTS TO User ENTITY
INSERT INTO UserE (ID, username, contact, name, surname, Location_ID) VALUES (
    1, 'KIKI', '663773518', 'Khurshidjon', 'Sharopov', 1
);
INSERT INTO UserE (ID, username, contact, name, surname, Location_ID) VALUES (
    2, 'NIKE', '663773123', 'Daler', 'Berdiev', 2
);
INSERT INTO UserE (ID, username, contact, name, surname, Location_ID) VALUES (
    3, 'ADIDAS', '663773321', 'Jamshid', 'Salikhov', 3
);
INSERT INTO UserE (ID, username, contact, name, surname, Location_ID) VALUES (
    4, 'PUMA', '663773999', 'Murat', 'Keldiev', 4
);

-- INSERTING ELEMENTS TO CATEGORY ENTITY
INSERT INTO Category (ID, name) VALUES (1, 'Transport');
INSERT INTO Category (ID, name) VALUES (2, 'Job');
INSERT INTO Category (ID, name) VALUES (3, 'Electronics');
INSERT INTO Category (ID, name) VALUES (4, 'Animals');

-- INSERTING ELEMENTS TO Ads ENTITY AND CREATING A PRODUCT
INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    1, 'Volvo', '10K miles run, made in 2020', 10000, 1, 2, 2
);
INSERT INTO Product (Ads_ID) VALUES (1);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    2, 'Software developer', '10 year experience', 1000, 2, 1, 1
);
INSERT INTO Service (availability, Ads_ID) VALUES (1, 2);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    3, 'SMART WATCH', 'New', 100, 3, 3, 3
);
INSERT INTO Product (Ads_ID) VALUES (3);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    4, 'Dog', '2 years old', 10, 4, 4, 4
);
INSERT INTO Product (Ads_ID) VALUES (4);

-- INSERTING ELEMENTS TO TRANSACTION ENTITY
INSERT INTO [Transaction] (ID, date, amount, Ads_ID, buyer, seller) VALUES (
    1, '2024-02-02', 10000, 1, 1, 2
);
INSERT INTO [Transaction] (ID, date, amount, Ads_ID, buyer, seller) VALUES (
    2, '2023-05-02', 1000, 2, 4, 1
);
INSERT INTO [Transaction] (ID, date, amount, Ads_ID, buyer, seller) VALUES (
    3, '2021-08-02', 100, 3, 2, 3 
);
INSERT INTO [Transaction] (ID, date, amount, Ads_ID, buyer, seller) VALUES (
    4, '2022-12-02', 10, 4, 3, 4
);

SET IDENTITY_INSERT Message ON;
-- INSERTING ELEMENTS TO MESSAGE ENTITY
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    1, '2023-07-01 16:30:00', 'HELLO, WHEN CAN I VISIT TO SEE THE CAR?', 1, 1, 2
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    2, '2023-07-01 18:30:00', 'HI, YOU CAN COME NEXT MONDAY?', 1, 2, 1
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    3, '2020-05-01 05:30:00', 'HELLO, IS NOT IT BROKEN?', 3, 4, 3
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    8, '2020-06-01 10:30:00', '', 3, 3, 4
);
SET IDENTITY_INSERT Message OFF;


-- INSERTING ELEMENTS TO FAVOURITE ENTITY
INSERT INTO Favourite (Ads_ID, User_ID) VALUES (2, 1);
INSERT INTO Favourite (Ads_ID, User_ID) VALUES (4, 1);
INSERT INTO Favourite (Ads_ID, User_ID) VALUES (2, 2);
INSERT INTO Favourite (Ads_ID, User_ID) VALUES (3, 2);

-- INSERTING ELEMENTS TO SAVED_ADS ENTITY before being sold
INSERT INTO saved_ads (Ads_ID, User_ID) VALUES (2, 4);
INSERT INTO saved_ads (Ads_ID, User_ID) VALUES (2, 3);
INSERT INTO saved_ads (Ads_ID, User_ID) VALUES (1, 2);
INSERT INTO saved_ads (Ads_ID, User_ID) VALUES (4, 1);

ALTER TABLE Ads ADD status VARCHAR(50);



-- Procedure 1. Check the message before insert that it is empty or not, 
-- if it is empty do not save it to database, 
-- if it is already craeted and empty just delete it

IF OBJECT_ID('CheckInsertMessage', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE CheckInsertMessage;
END
GO
CREATE PROCEDURE CheckInsertMessage
    @SenderId INT,
    @RecipientId INT,
    @AdsId INT,
    @MessageText NVARCHAR(MAX)
AS
BEGIN
    -- Check if the message already exists for the given sender and recipient
    DECLARE @ExistingMessageId INT
    DECLARE @ExistingMessageText NVARCHAR(MAX)

    SELECT @ExistingMessageId = ID, @ExistingMessageText = context
    FROM Message
    WHERE sender = @SenderId
      AND recipient = @RecipientId
      AND Ads_ID = @AdsId

    IF @ExistingMessageId IS NULL
    BEGIN
        -- Message does not exist, insert if not empty
        IF LEN(@MessageText) > 0
        BEGIN
            INSERT INTO Message (time, context, Ads_ID, sender, recipient)
            VALUES (GETDATE(), @MessageText, @AdsId, @SenderId, @RecipientId)
        END
        ELSE
        BEGIN
            PRINT 'Message is empty. Not saving to the database.'
        END
    END
    ELSE
    BEGIN
        -- Message already exists, update if not empty, delete if empty
        IF LEN(@MessageText) > 0
        BEGIN
            -- If new message is not empty, update existing message
            UPDATE Message
            SET context = @MessageText,
                time = GETDATE()
            WHERE ID = @ExistingMessageId
        END
        ELSE
        BEGIN
            -- If new message is empty, check if existing message is also empty
            IF LEN(@ExistingMessageText) = 0
            BEGIN
                -- If existing message is empty, delete it
                DELETE FROM Message
                WHERE ID = @ExistingMessageId

                PRINT 'Existing message is empty. Deleted from the database.'
            END
            ELSE
            BEGIN
                -- If existing message is not empty, leave it unchanged
                PRINT 'New message is empty. Existing message remains unchanged.'
            END
        END
    END
END


EXEC CheckInsertMessage @SenderId = 4, @RecipientId = 1, @AdsId=2, @MessageText = 'I did not get what'
EXEC CheckInsertMessage @SenderId = 4, @RecipientId = 1, @AdsId=2, @MessageText = ''

--select * from Message;

-- procedure 2. that automatically sets the price of ads to 0 if the category is named "free."
-- it will update existing rows, if the user wants to give as free the item, 
-- the category will be changed to free
IF OBJECT_ID('InsertOrUpdateAd', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE InsertOrUpdateAd;
END
GO
CREATE PROCEDURE InsertOrUpdateAd
    @Ads_ID INT OUTPUT,
    @name VARCHAR(100),
    @description VARCHAR(100),
    @price DECIMAL(9, 2),
    @Category_ID INT,
    @Location_ID INT,
    @User_ID INT
AS
BEGIN
    -- Check if the ad already exists
	DECLARE @Exists BIT;
	SELECT @Exists = CASE WHEN EXISTS (SELECT 1 FROM Ads WHERE ID = @Ads_ID) THEN 1 ELSE 0 END;

	-- Check if the category is named "free"
    DECLARE @IsFreeCategory BIT;
    SELECT @IsFreeCategory = CASE WHEN EXISTS (SELECT 1 FROM Category WHERE ID = @Category_ID AND name = 'free') THEN 1 ELSE 0 END;
	-- Insert or update the ad
	IF @Exists = 1 and @IsFreeCategory = 1
	BEGIN
		-- Update existing ad
		UPDATE Ads
		SET name = @name, description = @description, price = 0, Category_ID = @Category_ID, Location_ID = @Location_ID, User_ID = @User_ID
		WHERE ID = @Ads_ID;
	END
	ELSE
	BEGIN
		-- Insert new ad
		INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID)
		VALUES (@Ads_ID, @name, @description, 0, @Category_ID, @Location_ID, @User_ID);

		SET @Ads_ID = SCOPE_IDENTITY(); -- Get the ID of the newly inserted ad
	END

END;

-- Create the 'free' category
IF NOT EXISTS (SELECT 1 FROM Category WHERE ID = 5)
BEGIN
    INSERT INTO Category (ID, name)
    VALUES (5, 'free');
END

-- in first, if the category name is free it will insert new ads with the price 0, although its price is 10.99 
EXEC InsertOrUpdateAd @Ads_ID = 7, @name = 'Ad1', @description = 'Description1', @price = 10.99, @Category_ID = 5, @Location_ID = 3, @User_ID = 1;
-- in second, we can check existing rows, and set the price 0, and change the catgeory id to free
EXEC InsertOrUpdateAd @Ads_ID = 6, @name = 'Ad1', @description = 'Description1', @price = 10.99, @Category_ID = 5, @Location_ID = 3, @User_ID = 1;


-- Trigger 1. 
-- Prevents the new insertion if the username, surname and location already exists

CREATE TRIGGER before_insert_user
ON UserE
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @username VARCHAR(50);
    DECLARE @surname VARCHAR(50);
    DECLARE @location_id INT;

    DECLARE UserCursor CURSOR FOR
    SELECT username, surname, Location_ID
    FROM UserE;

    OPEN UserCursor;

    FETCH NEXT FROM UserCursor INTO @username, @surname, @location_id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM INSERTED
            WHERE username = @username
              AND surname = @surname
              AND Location_ID = @location_id
        )
        BEGIN
            CLOSE UserCursor;
            DEALLOCATE UserCursor;
            RAISERROR('Cannot insert. User with the same username, surname, and location already exists.', 16, 1);
            RETURN;
        END

        FETCH NEXT FROM UserCursor INTO @username, @surname, @location_id;
    END

    CLOSE UserCursor;
    DEALLOCATE UserCursor;

    -- Perform the actual insert operation
    INSERT INTO UserE
    SELECT * FROM INSERTED;
END;

INSERT INTO UserE (ID, username, surname, Location_ID) VALUES (5, 'KIKI', 'Sharopov', 1);


-- Trigger 2. 
-- The trigger doesn't let the user to save the ads to their favourite 
-- if it is created by himself.
CREATE TRIGGER prevent_self_favorite
ON Favourite
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Ads_ID INT;
    DECLARE @User_ID INT;

    DECLARE FavouriteCursor CURSOR FOR
        SELECT Ads_ID, User_ID
        FROM INSERTED;

    OPEN FavouriteCursor;

    FETCH NEXT FROM FavouriteCursor INTO @Ads_ID, @User_ID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM Ads a
            WHERE a.ID = @Ads_ID AND a.User_ID = @User_ID
        )
        BEGIN
            CLOSE FavouriteCursor;
            DEALLOCATE FavouriteCursor;

            RAISERROR('Cannot add your own ad to favorites.', 16, 1);
            RETURN;
        END

        FETCH NEXT FROM FavouriteCursor INTO @Ads_ID, @User_ID;
    END

    CLOSE FavouriteCursor;
    DEALLOCATE FavouriteCursor;

    -- Perform the actual insert operation
    INSERT INTO Favourite (Ads_ID, User_ID)
    SELECT Ads_ID, User_ID
    FROM INSERTED;
END;

-- The Ads 1 is created by user 2, so it will not be saved to the favourite table.
INSERT INTO Favourite (Ads_ID, User_ID) VALUES (1, 2); 
