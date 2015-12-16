USE toronto_hub

-- SELECT statements for the Movies website tab
-- Get the single attribute details for the movie Shutter Island
SELECT m.Movie_Name, mg.Movie_Genre_Name, m.Year_Released, md.Director_First_Name, 
	md.Director_Last_Name, l.Language_Name, m.Rating
FROM Movies AS m 
	INNER JOIN Movie_Genres AS mg
		ON m.Movie_Genre_ID = mg.Movie_Genre_ID
	INNER JOIN Movie_Directors AS md
		ON m.Movie_Director_ID = md.Movie_Director_ID
	INNER JOIN Languages AS l
		ON m.Language_ID = l.Language_ID
WHERE Movie_Name LIKE 'Shutter Island'

-- Get the multivalued attribute details for Shutter Island
-- Cast members
SELECT ma.Actor_First_Name, ma.Actor_Last_Name
FROM Movie_Actors AS ma
	INNER JOIN Movie_Cast_Members AS mcm
		ON ma.Movie_Actor_ID = mcm.Movie_Actor_ID
	INNER JOIN Movies AS m
		ON mcm.Movie_ID = m.Movie_ID
WHERE m.Movie_Name LIKE 'Shutter Island'

-- Reviews
SELECT DISTINCT a.Account_Name, r.Review_Text, r.Rating,
	COUNT(rl.Review_ID) OVER(PARTITION BY rl.Review_ID) AS Number_of_Review_Likes
FROM Accounts AS a
	INNER JOIN Reviews AS r 
		ON a.Account_ID = r.Account_ID
	INNER JOIN Movies AS m
		ON r.Movie_ID = m.Movie_ID
	INNER JOIN Reviews_Liked AS rl
		ON r.Review_ID = rl.Review_ID
WHERE m.Movie_Name LIKE 'Shutter Island'

-- SELECT statements for the community discussion page
-- Get the original post; I've chosen the post where the Topic_ID is 1
SELECT a.Account_Name, cdp.Subject
FROM Accounts AS a
	INNER JOIN Community_Discussion_Postings AS cdp
		ON a.Account_ID = cdp.Account_ID
WHERE cdp.Topic_ID = 1;

-- Get the replies to that post
SELECT a.Account_Name, cdr.Reply_Text
FROM Accounts AS a
	INNER JOIN Community_Discussion_Replies AS cdr
		ON a.Account_ID = cdr.Account_ID
WHERE cdr.Topic_ID = 1