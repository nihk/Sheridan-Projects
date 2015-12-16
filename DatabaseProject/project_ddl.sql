CREATE DATABASE toronto_hub;

USE toronto_hub;
GO

-------------------------
-- Tables without FKs: --
-------------------------

-- Movies
CREATE TABLE Movie_Directors (
	Movie_Director_ID INT IDENTITY(1,1),
    Director_First_Name VARCHAR(32) NOT NULL,
    Director_Last_Name VARCHAR(32) NOT NULL,
    CONSTRAINT movie_directors_pk PRIMARY KEY (Movie_Director_ID)
);

CREATE TABLE Movie_Actors (
	Movie_Actor_ID INT IDENTITY(1,1),
    Actor_First_Name VARCHAR(32) NOT NULL,
    Actor_Last_Name VARCHAR(32) NOT NULL,
    CONSTRAINT movie_actors_pk PRIMARY KEY (Movie_Actor_ID)
);

CREATE TABLE Movie_Genres (
	Movie_Genre_ID SMALLINT IDENTITY(1,1),
    Movie_Genre_Name VARCHAR(32) NOT NULL,
    CONSTRAINT movie_genres_pk PRIMARY KEY (Movie_Genre_ID)
);

CREATE TABLE Languages (
	Language_ID TINYINT IDENTITY(1,1),
    Language_Name VARCHAR(32) NOT NULL,
    CONSTRAINT languages_pk PRIMARY KEY (Language_ID)
);

-- Events
CREATE TABLE Event_Types (
	Event_Type_ID SMALLINT IDENTITY(1,1),
    Event_Type VARCHAR(32) NOT NULL,
    CONSTRAINT event_type_pk PRIMARY KEY (Event_Type_ID)
);

-- Attractions
CREATE TABLE Attraction_Types (
	Attraction_Type_ID SMALLINT IDENTITY(1,1),
    Attraction_Type VARCHAR(32) NOT NULL,
    CONSTRAINT attraction_type_pk PRIMARY KEY (Attraction_Type_ID)
);

-- Restaurants
CREATE TABLE Cuisine_Types (
	Cuisine_Type_ID SMALLINT IDENTITY(1,1),
    Cuisine_Type VARCHAR(32) NOT NULL,
    CONSTRAINT cuisine_type_pk PRIMARY KEY (Cuisine_Type_ID)
);

-- Community
CREATE TABLE Accounts (
	Account_ID INT IDENTITY(1,1),
	Account_Name VARCHAR(32),
    CONSTRAINT accounts_pk PRIMARY KEY (Account_ID)
);

-- Promotions
CREATE TABLE Promotion_Prices (
	Promotion_Price_ID SMALLINT IDENTITY(1,1),
    Promotion_Price DECIMAL(5,2) NOT NULL,
    CONSTRAINT promotion_prices_pk PRIMARY KEY (Promotion_Price_ID)
);

-- Misc.
-- The website screenshots did not include any Postal Codes in the address
-- information. Therefore, we did not include a Postal_Code attribute in this table.
CREATE TABLE Addresses (
	Address_ID INT IDENTITY(1,1),
    Street_Number SMALLINT NOT NULL,
    Street_Name VARCHAR(32) NOT NULL,
    City VARCHAR(32) NOT NULL,
    Province VARCHAR(32) NOT NULL,
    CONSTRAINT addresses_pk PRIMARY KEY (Address_ID),
    CONSTRAINT unique_addresses UNIQUE (Street_Number, Street_Name, City, Province)
);

----------------------
-- Tables with FKs: --
----------------------

-- Movies
CREATE TABLE Movies (
	Movie_ID INT IDENTITY(1,1),
    Movie_Name VARCHAR(64) NOT NULL,
    Movie_Genre_ID SMALLINT,
    Year_Released SMALLINT NOT NULL,
    Movie_Director_ID INT,
    Language_ID TINYINT,
    Rating TINYINT NULL,
    URL VARCHAR(255) NULL,
    CONSTRAINT movies_pk PRIMARY KEY (Movie_ID),
    CONSTRAINT movies_movie_genres_fk FOREIGN KEY (Movie_Genre_ID)
		REFERENCES Movie_Genres (Movie_Genre_ID),
    CONSTRAINT movies_movie_directors_fk FOREIGN KEY (Movie_Director_ID)
		REFERENCES Movie_Directors (Movie_Director_ID),
    CONSTRAINT movies_languages_fk FOREIGN KEY (Language_ID)
		REFERENCES Languages (Language_ID),
	CONSTRAINT movie_year_range
		CHECK (Year_Released BETWEEN 1850 AND 9999),
    CONSTRAINT movie_rating_range
		CHECK (Rating BETWEEN 0 and 100)
);

CREATE TABLE Movie_Cast_Members (
	Movie_Actor_ID INT,
    Movie_ID INT,
    CONSTRAINT movie_cast_members_pk PRIMARY KEY (Movie_Actor_ID, Movie_ID),
    CONSTRAINT movie_cast_members_movie_actors_fk FOREIGN KEY (Movie_Actor_ID)
		REFERENCES Movie_Actors (Movie_Actor_ID),
	CONSTRAINT movie_cast_members_movies_fk FOREIGN KEY (Movie_ID)
		REFERENCES Movies (Movie_ID)
);

CREATE TABLE Movie_Theaters (
	Movie_Theater_ID INT IDENTITY(1,1),
    Movie_Theater_Name VARCHAR(32) NOT NULL,
    Address_ID INT,
    URL VARCHAR(255) NULL,
    CONSTRAINT movie_theaters_pk PRIMARY KEY (Movie_Theater_ID),
	CONSTRAINT movie_theaters_addresses_fk FOREIGN KEY (Address_ID)
		REFERENCES Addresses (Address_ID)    
);

CREATE TABLE Movie_Theater_Show_Times (
	Showing_ID INT IDENTITY(1,1),
    Movie_Theater_ID INT,
    Movie_ID INT,
    Show_Date DATE NOT NULL,
    Show_Hour TIME NOT NULL,
    CONSTRAINT movie_theater_show_times_pk PRIMARY KEY (Showing_ID),
    CONSTRAINT movie_theater_show_times_movie_theaters_fk FOREIGN KEY (Movie_Theater_ID)
		REFERENCES Movie_Theaters (Movie_Theater_ID),
    CONSTRAINT movie_theater_show_times_movies_fk FOREIGN KEY (Movie_ID)
		REFERENCES Movies (Movie_ID)        
);

-- Events
CREATE TABLE Events (
	Event_ID INT IDENTITY(1,1),
    Event_Name VARCHAR(64) NOT NULL,
    Event_Type_ID SMALLINT,
    Address_ID INT,
    Description VARCHAR(255) NULL,
    Admission_Fee DECIMAL(5,2) NOT NULL,
    CONSTRAINT events_pk PRIMARY KEY (Event_ID),
	CONSTRAINT events_event_types_fk FOREIGN KEY (Event_Type_ID)
		REFERENCES Event_Types (Event_Type_ID),    
	CONSTRAINT events_addresses_fk FOREIGN KEY (Address_ID)
		REFERENCES Addresses (Address_ID),
	CONSTRAINT event_fee_positive_value
		CHECK (Admission_Fee >= 0)        
);

-- Attractions
CREATE TABLE Attractions (
	Attraction_ID INT IDENTITY(1,1),
    Attraction_Name VARCHAR(64) NOT NULL,
    Attraction_Type_ID SMALLINT,
    Address_ID INT,
    Description VARCHAR(255) NULL,
    Admission_Fee DECIMAL(5,2) NOT NULL,
    URL VARCHAR(255) NULL,
    CONSTRAINT attractions_pk PRIMARY KEY (Attraction_ID),
	CONSTRAINT attractions_attraction_types_fk FOREIGN KEY (Attraction_Type_ID)
		REFERENCES Attraction_Types (Attraction_Type_ID),      
	CONSTRAINT attractions_addresses_fk FOREIGN KEY (Address_ID)
		REFERENCES Addresses (Address_ID),
	CONSTRAINT attraction_fee_positive_value
		CHECK (Admission_Fee >= 0)
);

-- Restaurants
CREATE TABLE Restaurants (
	Restaurant_ID INT IDENTITY(1,1),
    Restaurant_Name VARCHAR(64) NOT NULL,
    Cuisine_Type_ID SMALLINT,
    Address_ID INT,
    Price_Minimum DECIMAL(5,2) NOT NULL,
    Price_Maximum DECIMAL(7,2) NOT NULL,
    Rating TINYINT NULL,
    URL VARCHAR(255) NULL,
    CONSTRAINT restaurants_pk PRIMARY KEY (Restaurant_ID),
	CONSTRAINT restaurants_cuisine_types_fk FOREIGN KEY (Cuisine_Type_ID)
		REFERENCES Cuisine_Types (Cuisine_Type_ID),      
	CONSTRAINT restaurants_addresses_fk FOREIGN KEY (Address_ID)
		REFERENCES Addresses (Address_ID),
    CONSTRAINT valid_price_range
		CHECK (Price_Maximum >= Price_Minimum),        
    CONSTRAINT restaurant_rating_range
		CHECK (Rating BETWEEN 0 and 100)        
);

-- Community
CREATE TABLE Community_Discussion_Postings (
	Topic_ID INT IDENTITY(1,1),
    Account_ID INT,
    Subject VARCHAR(255) NOT NULL,
    CONSTRAINT community_discussion_postings_pk PRIMARY KEY (Topic_ID),
	CONSTRAINT postings_accounts_fk FOREIGN KEY (Account_ID)
		REFERENCES Accounts (Account_ID)    
);

CREATE TABLE Community_Discussion_Replies (
	Reply_ID INT IDENTITY(1,1),
    Topic_ID INT,
    Account_ID INT,
    Reply_Text VARCHAR(1024) NOT NULL,
    CONSTRAINT community_discussion_replies_pk PRIMARY KEY (Reply_ID),
	CONSTRAINT replies_postings_fk FOREIGN KEY (Topic_ID)
		REFERENCES Community_Discussion_Postings (Topic_ID),    
	CONSTRAINT replies_accounts_fk FOREIGN KEY (Account_ID)
		REFERENCES Accounts (Account_ID)    
);

-- Promotions
CREATE TABLE Promotions (
	Restaurant_ID INT,
    Attraction_ID INT,
    Movie_ID INT,
    Promotion_Price_ID SMALLINT,
    CONSTRAINT promotions_pk PRIMARY KEY (Restaurant_ID, Attraction_ID, Movie_ID),
	CONSTRAINT promotions_restaurants_fk FOREIGN KEY (Restaurant_ID)
		REFERENCES Restaurants (Restaurant_ID),      
	CONSTRAINT promotions_attractions_fk FOREIGN KEY (Attraction_ID)
		REFERENCES Attractions (Attraction_ID),     
	CONSTRAINT promotions_movies_fk FOREIGN KEY (Movie_ID)
		REFERENCES Movies (Movie_ID),         
	CONSTRAINT promotions_promotion_prices_fk FOREIGN KEY (Promotion_Price_ID)
		REFERENCES Promotion_Prices (Promotion_Price_ID)    
);

-- Misc.
-- The fields Day_Start or Day_End can be NULL, since some interests might
-- not require them, e.g. a restaurant, while others could, e.g. an event.
CREATE TABLE Hours_of_Operation (
	Hours_of_Operation_ID INT IDENTITY(1,1),
    Event_ID INT NULL,
    Attraction_ID INT NULL,
    Restaurant_ID INT NULL,
    Date_Start DATE NULL,
    Date_End DATE NULL,
	Day_Start VARCHAR(10) NOT NULL,
	Day_End VARCHAR(10) NOT NULL,
    Hour_Start TIME NOT NULL,
    Hour_End TIME NOT NULL,
    CONSTRAINT hours_of_operation_pk PRIMARY KEY (Hours_of_Operation_ID),
	CONSTRAINT hours_of_operation_events_fk FOREIGN KEY (Event_ID)
		REFERENCES Events (Event_ID),      
	CONSTRAINT hours_of_operation_attractions_fk FOREIGN KEY (Attraction_ID)
		REFERENCES Attractions (Attraction_ID),     
	CONSTRAINT hours_of_operation_restaurants_fk FOREIGN KEY (Restaurant_ID)
		REFERENCES Restaurants (Restaurant_ID),
	-- Typically only one of the Event_ID, Attraction_ID, and Restaurant_ID fields will be
	-- NOT NULL per record. Conceivably, however, if Event_ID and Attraction_ID or
	-- any combination of the three IDs had the exact same hours of operation, they could
	-- occupy the same record. Therefore, only the constraint that they all not be NULL 
	-- at once in any record is used.
    CONSTRAINT at_least_one_interest_hours
		CHECK (NOT (Event_ID IS NULL AND Attraction_ID IS NULL AND Restaurant_ID IS NULL)),
    CONSTRAINT date_ends_not_in_past
		CHECK (Date_End >= Date_Start),
    CONSTRAINT hour_ends_in_future
		CHECK (Hour_End > Hour_Start)
);

CREATE TABLE Reviews (
	Review_ID INT IDENTITY(1,1),
    Movie_ID INT NULL,
    Restaurant_ID INT NULL,
    Account_ID INT,
    Review_Text VARCHAR(1024) NOT NULL,
    Rating TINYINT NOT NULL,
    CONSTRAINT reviews_pk PRIMARY KEY (Review_ID),
	CONSTRAINT reviews_movies_fk FOREIGN KEY (Movie_ID)
		REFERENCES Movies (Movie_ID),      
	CONSTRAINT reviews_restaurants_fk FOREIGN KEY (Restaurant_ID)
		REFERENCES Restaurants (Restaurant_ID),   
	CONSTRAINT reviews_accounts_fk FOREIGN KEY (Account_ID)
		REFERENCES Accounts (Account_ID),
	CONSTRAINT at_least_one_interest_review
		CHECK (NOT (Movie_ID IS NULL AND Restaurant_ID IS NULL) 
			AND NOT (Movie_ID IS NOT NULL AND Restaurant_ID IS NOT NULL)),    
    CONSTRAINT review_rating_range
		CHECK (Rating BETWEEN 0 and 100)      
);

CREATE TABLE Reviews_Liked (
	Review_ID INT,
    Account_ID INT,
    CONSTRAINT reviews_liked_pk PRIMARY KEY (Review_ID, Account_ID),
	CONSTRAINT reviews_liked_reviews_fk FOREIGN KEY (Review_ID)
		REFERENCES Reviews (Review_ID),      
	CONSTRAINT reviews_liked_accounts_fk FOREIGN KEY (Account_ID)
		REFERENCES Accounts (Account_ID)    
);