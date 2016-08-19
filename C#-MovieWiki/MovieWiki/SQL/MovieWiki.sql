--Contributors: Noe Ascenio, Nick Rose

USE MovieWiki;
GO

DROP TABLE WikiArticleEditHistory;
DROP TABLE WikiArticle;
DROP TABLE UserAccount;
--DROP DATABASE MovieWiki;

--CREATE DATABASE MovieWiki;

CREATE TABLE UserAccount
  (
     [AccountId] INT IDENTITY(1, 1), 
     [Username]  VARCHAR(50) NOT NULL, 
     [Password]  VARCHAR(128) NOT NULL, 
     CONSTRAINT UserAccount_AccountId_pk 
		PRIMARY KEY (AccountId),
     CONSTRAINT UserAccount_Username_uq	
		UNIQUE (Username)
  );

CREATE TABLE WikiArticle
  (
     [ArticleId]   INT IDENTITY(1, 1), 
     [ArticleType] VARCHAR(20) NOT NULL, 
     [Title]       VARCHAR(50) NOT NULL, 
     [Description] TEXT NOT NULL, 
     CONSTRAINT WikiArticle_ArticleId_pk 
		PRIMARY KEY (ArticleId),
     CONSTRAINT WikiArticle_Title_uq 
		UNIQUE (Title)
  );

CREATE TABLE WikiArticleEditHistory
  (
     [EditId]        INT IDENTITY(1, 1), 
     [ArticleId]     INT, 
     [AccountId]     INT, 
     [EditTimestamp] DATETIME NOT NULL,
     CONSTRAINT WikiArticleEditHistory_EditId_pk 
		PRIMARY KEY (EditId),
     CONSTRAINT WikiArticleEditHistory_ArticleId_fk 
		FOREIGN KEY (ArticleId)
		REFERENCES WikiArticle (ArticleId),
     CONSTRAINT WikiArticleEditHistory_AccountId_fk 
		FOREIGN KEY (AccountId)
		REFERENCES UserAccount (AccountId)
  ); 

INSERT INTO UserAccount
VALUES ('Admin', '1F40FC92DA241694750979EE6CF582F2D5D7D28E18335DE05ABC54D0560E0F5302860C652BF08D560252AA5E74210546F369FBBBCE8C12CFC7957B2652FE9A'),
('nick', '1F40FC92DA241694750979EE6CF582F2D5D7D28E18335DE05ABC54D0560E0F5302860C652BF08D560252AA5E74210546F369FBBBCE8C12CFC7957B2652FE9A');

INSERT INTO WikiArticle (ArticleType, Title, [Description])
VALUES ('CrewMemberArticle', 'Clint Eastwood', 
'<CrewMemberArticle>
  <Title>Clint Eastwood</Title>
  <Name>Clinton "Clint" Eastwood Jr.</Name>
  <Age>86</Age>
  <Description>Clinton "Clint" Eastwood Jr. (born May 31, 1930) is an American actor, film director, producer, musician, and political figure.</Description>
  <RoleSections>
    <ActorSection>Best known as the Man with No Name in Sergio Leone''s Dollars trilogy of spaghetti Westerns and as antihero cop Harry Callahan in the five Dirty Harry films</ActorSection>
    <DirectorSection> Mystic River, Letters from Iwo Jima, Changeling, American Sniper </DirectorSection>
  </RoleSections>
</CrewMemberArticle>'),
('MovieArticle', 'The Godfather', 
'<MovieArticle>
  <Title>The Godfather</Title>
  <Theme>Crime</Theme>
  <Characters>Michael Corleone, Vito Corleone, Peter Clemenza</Characters>
  <Language>English</Language>
  <Duration>175mins</Duration>
  <Description>When the aging head of a famous crime family decides to transfer his position to one of his subalterns, a series of unfortunate events start happening to the family, and a war begins between all the well-known families leading to insolence, deportation, murder and revenge, and ends with the favorable successor being finally chosen.</Description>
</MovieArticle>'),
('CharacterArticle', 'Oskar Schindler', 
'<CharacterArticle>
  <Title>Oskar Schindler</Title>
  <Name>Oskar Schindler</Name>
  <Age>66 (d. 9 October 1974)</Age>
  <MoviesAppearedIn>Schindler''s List</MoviesAppearedIn>
  <IsFictional>false</IsFictional>
  <Description>Oskar Schindler was a German industrialist, spy, and member of the Nazi Party who is credited with saving the lives of 1,200 Jews during the Holocaust by employing them in his enamelware and ammunitions factories, which were located in occupied Poland and the Protectorate of Bohemia and Moravia. He is the subject of the 1982 novel Schindler''s Ark, and the subsequent 1993 film Schindler''s List, which reflected his life as an opportunist initially motivated by profit who came to show extraordinary initiative, tenacity and dedication to save the lives of his Jewish employees.</Description>
</CharacterArticle>'),
('PropArticle', 'Lightsaber', 
'<PropArticle>
  <Title>Lightsaber</Title>
  <MoviesFeaturedIn>Star Wars</MoviesFeaturedIn>
  <Function>Weapon</Function>
  <Description>A lightsaber is a fictional energy sword featured in the Star Wars universe. A typical lightsaber usually consists of a metal hilt (usually around 11 inches (28 cm) in length) that projects a brightly-lit energy blade (usually around 3 feet (91 cm) in length), The lightsaber is the signature weapon of the Jedi Order and their Sith counterparts, both of whom can use them for close combat, or to deflect blaster bolts. Its distinct appearance was created using rotoscoping for the original films, and digitally for the prequel trilogy, and the sequel trilogy. The lightsaber first appeared in the original 1977 film A New Hope and every Star Wars movie has featured at least one lightsaber duel. In 2008, a survey of approximately 2,000 film fans found it to be the most popular weapon in film history.</Description>
</PropArticle>'),
('MovieArticle', 'Avatar', 
'<MovieArticle>
  <Title>Avatar</Title>
  <Theme>Sci Fi</Theme>
  <Characters>Jake Sully, Neytiri, Colonel Miles Quaritch</Characters>
  <Language>English</Language>
  <Duration>161mins</Duration>
  <Description>When his brother is killed in a robbery, paraplegic Marine Jake Sully decides to take his place in a mission on the distant world of Pandora. There he learns of greedy corporate figurehead Parker Selfridge''s intentions of driving off the native humanoid "Na''vi" in order to mine for the precious material scattered throughout their rich woodland. In exchange for the spinal surgery that will fix his legs, Jake gathers intel for the cooperating military unit spearheaded by gung-ho Colonel Quaritch, while simultaneously attempting to infiltrate the Na''vi people with the use of an "avatar" identity. While Jake begins to bond with the native tribe and quickly falls in love with the beautiful alien Neytiri, the restless Colonel moves forward with his ruthless extermination tactics, forcing the soldier to take a stand - and fight back in an epic battle for the fate of Pandora.</Description>
</MovieArticle>'),
('MovieArticle', 'Star Wars: The Force Awakens', 
'<MovieArticle>
  <Title>Star Wars: The Force Awakens</Title>
  <Theme>Sci Fi</Theme>
  <Characters>Rey, Kylo Ren, Flinn, Han Solo, Luke Skywalker, Princess Leia, R2D2, General Hux, Supreme Leader Snoke</Characters>
  <Language>English</Language>
  <Duration>138mins</Duration>
  <Description>30 years after the defeat of Darth Vader and the Empire, Rey, a scavenger from the planet Jakku, finds a BB-8 droid that knows the whereabouts of the long lost Luke Skywalker. Rey, as well as a rogue stormtrooper and two smugglers, are thrown into the middle of a battle between the Resistance and the daunting legions of the First Order.</Description>
</MovieArticle>'),
('MovieArticle', 'The Martian', 
'<MovieArticle>
  <Title>The Martian</Title>
  <Theme>Sci Fi</Theme>
  <Characters>Mark Watney, Melisa Lewis, Annie Montrose, Teddy Sanders, Rick Martinez, Mitch Henderson, Beth Johansenn, Chris Beck</Characters>
  <Language>English</Language>
  <Duration>144mins</Duration>
  <Description>During a manned mission to Mars, Astronaut Mark Watney is presumed dead after a fierce storm and left behind by his crew. But Watney has survived and finds himself stranded and alone on the hostile planet. With only meager supplies, he must draw upon his ingenuity, wit and spirit to subsist and find a way to signal to Earth that he is alive. Millions of miles away, NASA and a team of international scientists work tirelessly to bring "the Martian" home, while his crewmates concurrently plot a daring, if not impossible, rescue mission. As these stories of incredible bravery unfold, the world comes together to root for Watney''s safe return.</Description>
</MovieArticle>');

INSERT INTO WikiArticleEditHistory
VALUES (1, 1, '2016-08-06 13:45:49.590'),
(2, 1, '2016-08-06 13:46:00.860'),
(3, 2, '2016-08-06 13:50:51.947'),
(4, 2, '2016-08-06 13:52:47.670'),
(5, 1, '2016-08-11 21:09:32.520'),
(6, 1, '2016-08-11 21:11:58.963'),
(7, 2, '2016-08-11 21:20:09.830');

SELECT * FROM WikiArticle;
SELECT * FROM UserAccount;
SELECT * FROM WikiArticleEditHistory;