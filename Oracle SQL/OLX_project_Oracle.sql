-- tables
-- Table: Ads
CREATE TABLE Ads (
    ID integer  NOT NULL,
    name varchar2(100)  NOT NULL,
    description varchar2(100)  NOT NULL,
    price number(9,2)  NOT NULL,
    Category_ID integer  NOT NULL,
    Location_ID integer  NOT NULL,
    User_ID integer  NOT NULL,
    CONSTRAINT Ads_pk PRIMARY KEY (ID)
) ;

-- Table: Category
CREATE TABLE Category (
    ID integer  NOT NULL,
    name varchar2(100)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (ID)
) ;

-- Table: City
CREATE TABLE City (
    ID integer  NOT NULL,
    name varchar2(50)  NOT NULL,
    CONSTRAINT City_pk PRIMARY KEY (ID)
) ;

-- Table: Favourite
CREATE TABLE Favourite (
    Ads_ID integer  NOT NULL,
    User_ID integer  NOT NULL,
    CONSTRAINT Favourite_pk PRIMARY KEY (Ads_ID,User_ID)
) ;

-- Table: Location
CREATE TABLE Location (
    ID integer  NOT NULL,
    address varchar2(100)  NOT NULL,
    City_ID integer  NOT NULL,
    CONSTRAINT Location_pk PRIMARY KEY (ID)
) ;

-- Table: Message
CREATE TABLE Message (
    ID integer  NOT NULL,
    time timestamp  NOT NULL,
    context varchar2(1000)  NOT NULL,
    Ads_ID integer  NOT NULL,
    sender integer  NOT NULL,
    recipient integer  NOT NULL,
    CONSTRAINT Message_pk PRIMARY KEY (ID)
) ;

-- Table: Product
CREATE TABLE Product (
    Ads_ID integer  NOT NULL,
    CONSTRAINT Product_pk PRIMARY KEY (Ads_ID)
) ;

-- Table: Service
CREATE TABLE Service (
    availability smallint  NOT NULL,
    Ads_ID integer  NOT NULL,
    CONSTRAINT Service_pk PRIMARY KEY (Ads_ID)
) ;

-- Table: Transaction
CREATE TABLE Transaction (
    ID integer  NOT NULL,
    "date" date  NOT NULL,
    amount number(9,2)  NOT NULL,
    Ads_ID integer  NOT NULL,
    buyer integer  NOT NULL,
    seller integer  NOT NULL,
    CONSTRAINT Transaction_pk PRIMARY KEY (ID)
) ;

-- Table: User
CREATE TABLE UserE (
    ID integer  NOT NULL,
    username varchar2(50)  NOT NULL,
    contact varchar2(14)  NOT NULL,
    name varchar2(50)  NOT NULL,
    surname varchar2(50)  NOT NULL,
    Location_ID integer  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (ID)
) ;

-- Table: saved_ads
CREATE TABLE saved_ads (
    Ads_ID integer  NOT NULL,
    User_ID integer  NOT NULL,
    CONSTRAINT saved_ads_pk PRIMARY KEY (Ads_ID,User_ID)
) ;

-- foreign keys
-- Reference: Ads_Category (table: Ads)
ALTER TABLE Ads ADD CONSTRAINT Ads_Category
    FOREIGN KEY (Category_ID)
    REFERENCES Category (ID);

-- Reference: Ads_Location (table: Ads)
ALTER TABLE Ads ADD CONSTRAINT Ads_Location
    FOREIGN KEY (Location_ID)
    REFERENCES Location (ID);

-- Reference: Ads_User (table: Ads)
ALTER TABLE Ads ADD CONSTRAINT Ads_User
    FOREIGN KEY (User_ID)
    REFERENCES UserE (ID);

-- Reference: Favourite_Ads (table: Favourite)
ALTER TABLE Favourite ADD CONSTRAINT Favourite_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: Favourite_User (table: Favourite)
ALTER TABLE Favourite ADD CONSTRAINT Favourite_User
    FOREIGN KEY (User_ID)
    REFERENCES UserE (ID);

-- Reference: Location_City (table: Location)
ALTER TABLE Location ADD CONSTRAINT Location_City
    FOREIGN KEY (City_ID)
    REFERENCES City (ID);

-- Reference: Message_Ads (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: Message_recipient (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_recipient
    FOREIGN KEY (sender)
    REFERENCES UserE (ID);

-- Reference: Message_sender (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_sender
    FOREIGN KEY (recipient)
    REFERENCES UserE (ID);

-- Reference: Product_Ads (table: Product)
ALTER TABLE Product ADD CONSTRAINT Product_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: Service_Ads (table: Service)
ALTER TABLE Service ADD CONSTRAINT Service_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: Transaction_Ads (table: Transaction)
ALTER TABLE Transaction ADD CONSTRAINT Transaction_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: Transaction_buyer (table: Transaction)
ALTER TABLE Transaction ADD CONSTRAINT Transaction_buyer
    FOREIGN KEY (buyer)
    REFERENCES UserE (ID);

-- Reference: Transaction_seller (table: Transaction)
ALTER TABLE Transaction ADD CONSTRAINT Transaction_seller
    FOREIGN KEY (seller)
    REFERENCES UserE (ID);

-- Reference: User_Location (table: User)
ALTER TABLE UserE ADD CONSTRAINT User_Location
    FOREIGN KEY (Location_ID)
    REFERENCES Location (ID);

-- Reference: saved_ads_Ads (table: saved_ads)
ALTER TABLE saved_ads ADD CONSTRAINT saved_ads_Ads
    FOREIGN KEY (Ads_ID)
    REFERENCES Ads (ID);

-- Reference: saved_ads_User (table: saved_ads)
ALTER TABLE saved_ads ADD CONSTRAINT saved_ads_User
    FOREIGN KEY (User_ID)
    REFERENCES UserE (ID);

-- End of file.

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

-- INSERTING ELEMENTS TO Ads ENTITY AND CRAETING A PRODUCT
INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    1, 'Volvo', '10K miles run, made in 2020', '10000', 1, 2, 2
);
INSERT INTO Product (Ads_ID) VALUES (1);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    2, 'Software developer', '10 year experience', '1000', 2, 1, 1
);
INSERT INTO Service (availability, Ads_ID) VALUES (1, 2);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    3, 'SMART WATCH', 'New', '100', 3, 3, 3
);
INSERT INTO Product (Ads_ID) VALUES (3);

INSERT INTO Ads (ID, name, description, price, Category_ID, Location_ID, User_ID) VALUES (
    4, 'Dog', '2 years old', '10', 4, 4, 4
);
INSERT INTO Product (Ads_ID) VALUES (4);

-- INSERTING ELEMENTS TO TRANSACTION ENTITY
INSERT INTO Transaction (ID, "date", amount, Ads_ID, buyer, seller) VALUES (
    1, TO_DATE('2024-02-02', 'YYYY-MM-DD'), '10000', 1, 1, 2
);
INSERT INTO Transaction (ID, "date", amount, Ads_ID, buyer, seller) VALUES (
    2, TO_DATE('2023-05-02', 'YYYY-MM-DD'), '1000', 2, 4, 1
);
INSERT INTO Transaction (ID, "date", amount, Ads_ID, buyer, seller) VALUES (
    3, TO_DATE('2021-08-02', 'YYYY-MM-DD'), '100', 3, 2, 3 
);
INSERT INTO Transaction (ID, "date", amount, Ads_ID, buyer, seller) VALUES (
    4, TO_DATE('2022-12-02', 'YYYY-MM-DD'), '10', 4, 3, 4
);

-- INSERTING ELEMENTS TO MESSAGE ENTITY
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    1, TO_TIMESTAMP('2023-07-01 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HELLO, WHEN CAN I VISIT TO SEE THE CAR?', 1, 1, 2
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    2, TO_TIMESTAMP('2023-07-01 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HI, YOU CAN COME NEXT MONDAY?', 1, 2, 1
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    3, TO_TIMESTAMP('2020-05-01 05:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HELLO, IS NOT IT BROKEN?', 3, 4, 3
);
INSERT INTO Message (ID, time, context, Ads_ID, sender, recipient) VALUES (
    4, TO_TIMESTAMP('2020-06-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'HI, YES, THE HAND SIDE IS LITTLE?', 3, 3, 4
);

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

-- status column for Ads table added
ALTER TABLE Ads ADD (status VARCHAR2(50));
-- end of file


-- Procedure 1. If the ads is sold it is going to be marked as sold
CREATE OR REPLACE PROCEDURE MarkAdvertisementAsSold (
    p_TransactionID IN INTEGER
)
IS
    v_AdsID INTEGER;
BEGIN
    SELECT Ads_ID INTO v_AdsID
    FROM Transaction
    WHERE ID = p_TransactionID;

    IF v_AdsID IS NOT NULL THEN
        -- Update the status of the advertisement to 'Sold'
        UPDATE Ads
        SET status = 'Sold'
        WHERE ID = v_AdsID;
        
        DBMS_OUTPUT.PUT_LINE('Advertisement with ID ' || v_AdsID || ' marked as Sold.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Transaction with ID ' || p_TransactionID || ' does not have a valid Ads_ID.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Transaction with ID ' || p_TransactionID || ' not found.');
        ROLLBACK; -- it helps to go back in any exception case
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END MarkAdvertisementAsSold;
/

EXEC MarkAdvertisementAsSold(p_TransactionID => 2);
/


-- the LocationCursor cursor is used for this procedure
-- Procedure 2. Updating user location
CREATE OR REPLACE PROCEDURE UpdateUserLocation (
    p_UserID IN INTEGER,
    p_LocationID IN INTEGER DEFAULT NULL
)
IS
    v_LastLocationID INTEGER;
    v_NewLocationID INTEGER;
    v_LocationCount INTEGER;
BEGIN
    -- Find the last Location_ID in the Location table
    SELECT MAX(ID) 
    INTO v_LastLocationID 
    FROM Location;

    -- Determine the Location_ID to use
    IF p_LocationID IS NOT NULL THEN
        -- Use the provided Location_ID if available
        v_NewLocationID := p_LocationID;
    ELSE
        -- Increment the last Location_ID for the new location
        v_NewLocationID := v_LastLocationID + 1;
    END IF;

    -- Check if the location already exists
    SELECT COUNT(*) INTO v_LocationCount
    FROM Location
    WHERE ID = v_NewLocationID;

    -- Insert the new location if it doesn't exist
    IF v_LocationCount = 0 THEN
        INSERT INTO Location (ID, address, City_ID)
        VALUES (v_NewLocationID, 'New Location', 1);
    END IF;

    -- Update user's location
    UPDATE UserE
    SET Location_ID = v_NewLocationID
    WHERE ID = p_UserID;

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('User with ID ' || p_UserID || ' location updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('User with ID ' || p_UserID || ' not found.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END UpdateUserLocation;
/

-- Execute the procedure
EXEC UpdateUserLocation(1);
/

-- CREATE TRIGGER for checking sold ads before saving to saved ads
CREATE OR REPLACE TRIGGER CheckSoldBeforeSave
BEFORE INSERT ON saved_ads
FOR EACH ROW
DECLARE
    v_AdStatus VARCHAR2(50);
BEGIN
    -- Get the status of the corresponding ad
    SELECT status INTO v_AdStatus
    FROM Ads
    WHERE ID = :NEW.Ads_ID;

    -- Check if the ad is sold
    IF v_AdStatus = 'Sold' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot save a sold ad.');
    END IF;
END CheckSoldBeforeSave;
/

-- with this insert we can check the trigger is working, because ads with id 2 is marked as sold
-- INSERT INTO saved_ads (Ads_ID, User_ID) VALUES (2, 2);
--/


-- This trigger prevents the double or more transactions, for example below transaction is 
-- already done above, so it gives an error
CREATE OR REPLACE TRIGGER check_transaction 
BEFORE INSERT ON Transaction 
FOR EACH ROW 
DECLARE 
    user_has_transaction NUMBER;
BEGIN 
    SELECT 1 
    INTO user_has_transaction
    FROM Transaction 
    WHERE (buyer = :NEW.buyer OR seller = :NEW.seller) 
      AND "date" = :NEW."date" 
      AND ID <> :NEW.ID; -- Exclude the current record being inserted or updated

    IF user_has_transaction IS NOT NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'User has already made a transaction'); 
    END IF; 
END;
/

INSERT INTO Transaction (ID, "date", amount, Ads_ID, buyer, seller) VALUES (
5, TO_DATE('2022-12-02', 'YYYY-MM-DD'), '10', 4, 3, 4);
/
commit;    

    