USE toronto_hub
GO

INSERT INTO Movie_Directors (Director_First_Name, Director_Last_Name)
VALUES ('Steven', 'Spielberg'),
	('Alfred', 'Hitchcock'),
	('Quentin', 'Tarantino'),
	('Martin', 'Scorsese'),
	('Stanley', 'Kubrick');

INSERT INTO Movie_Actors (Actor_First_Name, Actor_Last_Name)
VALUES ('Liam', 'Neeson'),
	('Ben', 'Kingsley'),
	('Ralph', 'Fiennes'),
	('Tom', 'Hanks'),
	('Tom', 'Sizemore'),
	('Matt', 'Damon'),
	('Anthony', 'Perkins'),
	('Vera', 'Miles'),
	('James', 'Stewart'),
	('Kim', 'Novak'),
	('John', 'Travolta'),
	('Tim', 'Roth'),
	('Harvey', 'Keitel'),
	('Leonardo', 'DiCaprio'),
	('Jonah', 'Hill'),
	('Mark', 'Ruffalo'),
	('Malcolm', 'McDowell'),
	('Jack', 'Nicholson'),
	('Shelley', 'Duvall');

INSERT INTO Movie_Genres (Movie_Genre_Name)
VALUES ('Drama'),
	('War'),
	('Mystery'),
	('Horror'),
	('Crime'),
	('Biography'),
	('Sci-Fi'),
	('Comedy'),
	('Adventure');

INSERT INTO Languages (Language_Name)
VALUES ('English'),
	('Spanish'),
	('French'),
	('German'),
	('Russian');

INSERT INTO Event_Types (Event_Type)
VALUES ('Science'),
	('Art'),
	('Sport'),
	('Family');

INSERT INTO Attraction_Types (Attraction_Type)
VALUES ('Museum'),
	('Gallery'),
	('Shopping'),
	('Arenas');

INSERT INTO Cuisine_Types (Cuisine_Type)
VALUES ('Italian'),
	('Mediterranean'),
	('Middle Eastern'),
	('Greek'),
	('American'),
	('Canadian'),
	('French'),
	('Chinese'),
	('Indian');

INSERT INTO Accounts (Account_Name)
VALUES ('Nice Glasses'),
	('Pierre'),
	('The Nice Guy'),
	('Sherlock Holmes'),
	('Nick'),
	('Michael'),
	('Chris'),
	('Connor'),
	('Bill');

INSERT INTO Promotion_Prices (Promotion_Price)
VALUES (45),
	(50),
	(34.99);

INSERT INTO Addresses (Street_Number, Street_Name, City, Province)
VALUES (231, 'My Street', 'Toronto', 'ON'),
	(235, 'Dynosaur Rd', 'Toronto', 'ON'),
	(145, 'Bloomfield Dr', 'Toronto', 'ON'),
	(45, 'Sherman Rd', 'Toronto', 'ON'),
	(77, 'Wynford Dr', 'Toronto', 'ON'),
	(1, 'Blue Jays Way', 'Toronto', 'ON'),
	(66, 'Danforth Crt', 'Toronto', 'ON'),
	(67, 'Front St E', 'Toronto', 'ON'),
	(220, 'Yonge St', 'Toronto', 'ON');

INSERT INTO Movies (Movie_Name, Movie_Genre_ID, Year_Released, Movie_Director_ID, Language_ID, Rating, URL)
VALUES ('Saving Private Ryan', 2, 1998, 1, 1, 86, 'http://www.imdb.com/title/tt0120815'),
	('Schindler''s List', 1, 1993, 1, 1, 89, 'http://www.imdb.com/title/tt0108052'),
	('Vertigo', 2, 1958, 3, 2, 84, 'http://www.imdb.com/title/tt0052357'),
	('Psycho', 2, 1960, 4, 2, 85, 'http://www.imdb.com/title/tt0054215'),
	('Pulp Fiction', 1, 1994, 3, 1, 89, 'http://www.imdb.com/title/tt0110912'),
	('Reservoir Dogs', 5, 1992, 3, 1, 84, 'http://www.imdb.com/title/tt0105236'),
	('The Wolf of Wall Street', 6, 2013, 4, 1, 82, 'http://www.imdb.com/title/tt0993846'),
	('Shutter Island', 3, 2010, 4, 1, 81, 'http://www.imdb.com/title/tt1130884'),
	('A Clockwork Orange', 7, 1971, 5, 1, 84, 'http://www.imdb.com/title/tt0066921'),
	('The Shining', 4, 1980, 5, 1, 84, 'http://www.imdb.com/title/tt0081505');

INSERT INTO Movie_Cast_Members (Movie_Actor_ID, Movie_ID)
VALUES (4, 1),
	(5, 1),
	(6, 1),
	(1, 2),
	(2, 2),
	(3, 2),
	(9, 3),
	(10, 3),
	(7, 4),
	(8, 4),
	(11, 5),
	(12, 5),
	(12, 6),
	(13, 6),
	(14, 7),
	(15, 7),
	(2, 8),
	(14, 8),
	(16, 8),
	(17, 9),
	(18, 10),
	(19, 10);

INSERT INTO Movie_Theaters (Movie_Theater_Name, Address_ID, URL)
VALUES ('Cineplex Sheridan', 1, 'http://www.cineplexsheridan.com'),
	('SilverCity Toronto', 3, 'http://www.silvercitytoronto.com'),
	('Movietown', 4, 'http://www.movietown.com');

INSERT INTO Movie_Theater_Show_Times (Movie_Theater_ID, Movie_ID, Show_Date, Show_Hour)
VALUES (1, 3, '2015-12-13', '19:30:00'),
	(1, 5, '2015-12-13', '21:30:00'),
	(2, 2, '2015-12-15', '18:30:00'),
	(2, 4, '2015-12-16', '20:00:00'),
	(3, 5, '2016-01-18', '18:00:00'),
	(3, 7, '2016-01-19', '12:30:00');

INSERT INTO Events (Event_Name, Event_Type_ID, Address_ID, Description, Admission_Fee)
VALUES ('Dinosaur Exhibition', 1, 2, 'This exhibition is coming from the museum of
		Natural History in London, UK and it has the most recent discovery of the oldest
		dinosaur specimens.', 13),
	('Aga Khan Museum Exhibition', 2, 5, 'The Aga Khan Museum’s groundbreaking new 
		exhibition, Home Ground: Contemporary Art from the Barjeel Art Foundation, will 
		push boundaries and test limits as it examines how private life in the Arab world 
		is shaped by current political events.', 20);

INSERT INTO Attractions (Attraction_Name, Attraction_Type_ID, Address_ID, Description, Admission_Fee, URL)
VALUES ('Museum of Natural History', 1, 2, 'This museum has the biggest mammal specimens collection.', 23,
		'http://www.museumofnaturalhistory.com'),
	('Rogers Centre', 4, 6, 'Rogers Centre (originally named SkyDome) is a multi-purpose stadium in 
		downtown Toronto, Ontario, Canada situated just southwest of the CN Tower near the northern 
		shore of Lake Ontario.', 75, 'http://www.rogerscentre.com'),
	('Toronto Eaton Centre', 3, 9, 'The Toronto Eaton Centre (branded CF Toronto Eaton Centre) is a 
		shopping mall and office complex in downtown Toronto, Ontario, Canada, named after the Eaton''s 
		department store chain that once anchored it but became defunct in the late 1990s.', 0,
		'http://www.torontoeatoncentre.com/');

INSERT INTO Restaurants (Restaurant_Name, Cuisine_Type_ID, Address_ID, Price_Minimum, Price_Maximum, Rating, URL)
VALUES ('Ivar''s', 1, 7, 35, 75, 95, 'http://www.ivarsrestaurant.com'),
	('C''est What', 6, 8, 15, 40, 82, 'http://www.cestwhat.com');

INSERT INTO Community_Discussion_Postings (Account_ID, Subject)
VALUES (1, 'What is the best thing about Toronto?'),
	(5, 'Where can I find a good restaurant here?');

INSERT INTO Community_Discussion_Replies (Topic_ID, Account_ID, Reply_Text)
VALUES (1, 2, 'I like the weather.'),
	(1, 3, 'I like the island.'),
	(2, 6, 'There is a good one on Front street!');

INSERT INTO Promotions (Restaurant_ID, Attraction_ID, Movie_ID, Promotion_Price_ID)
VALUES (1, 2, 3, 1),
	(2, 1, 5, 1);

INSERT INTO Hours_of_Operation (Attraction_ID, Day_Start, Day_End, Hour_Start, Hour_End)
VALUES (1, 'Monday', 'Friday', '10:00:00', '22:00:00'),
	(1, 'Saturday', 'Saturday', '10:00:00', '19:00:00'),
	(1, 'Sunday', 'Sunday', '12:00:00', '18:00:00');

INSERT INTO Hours_of_Operation (Event_ID, Date_Start, Date_End, Day_Start, Day_End, Hour_Start, Hour_End)
VALUES (1, '2015-09-01', '2015-11-01', 'Monday', 'Friday', '10:00:00', '22:00:00');

INSERT INTO Reviews (Movie_ID, Account_ID, Review_Text, Rating)
VALUES (7, 4, 'The Wolf Of Wall Street details the rise and 
		fall in real life of one Jordan Belfort who for a while was living high 
		and wide off of other people''s money. It was good while it lasted until 
		some relentless FBI agents took him down partly because of his own hubris.',
		80),
	(8, 8, 'Shutter Island. A film that will divide the film community. A film that 
		will leave many upset, and hating it. A film that has already completely split 
		the critics. A movie that messes with you. And no one likes to be messed with. 
		And that is exactly where it exceeds. Think I''m contradicting myself?', 100),
	(8, 9, 'There is one line of dialogue, right at the end of Shutter Island before 
		the credits roll, that elevates the emotion of the film and makes it much more 
		powerful. For those of you, like me, who read and enjoyed the novel before seeing 
		the film and felt that the trailers and advertisements for this film were leading 
		you to believe there wouldn''t be any narrative surprises in store, think again! 
		Scorsese''s film features that one brief piece of dialogue at the films conclusion
		that results in an entirely different perception of the final act. The rest of the
		film, however, is very faithful to Dennis Lehane''s already great story.', 90);

INSERT INTO Reviews (Restaurant_ID, Account_ID, Review_Text, Rating)
VALUES (2, 7, 'Wide selection of Canadian craft beer, helpful staff, 
	unique decor. Laid back atmosphere. Food was surprisingly good for a pub.',
	82);

INSERT INTO Reviews_Liked (Review_ID, Account_ID)
VALUES (1, 5),
	(2, 3),
	(2, 1),
	(2, 4),
	(2, 2),
	(3, 6),
	(3, 7);