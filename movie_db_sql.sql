use project_weirc5;  -- Specifies the databse in current use
-- Cleans out tables before elements get added so theydon't overide
DROP TABLE IF EXISTS Actor_Receives;
DROP TABLE IF EXISTS Director_Receives;
DROP TABLE IF EXISTS Movie_Receives;
DROP TABLE IF EXISTS Produces;
DROP TABLE IF EXISTS Works_With;
DROP TABLE IF EXISTS Directs;
DROP TABLE IF EXISTS Acts_In;
DROP TABLE IF EXISTS Movie_Genre;
DROP TABLE IF EXISTS Award;
DROP TABLE IF EXISTS ProductionStudio;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Director;
DROP TABLE IF EXISTS Movie;

-- Creating table with director entities containing attributes followed from the document
CREATE TABLE if not exists Director( -- only create table if it does not exist already
	director_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- auto increment will place director id in chronological order
    fName VARCHAR(200) NOT NULL, -- string variable containing letters
    sName VARCHAR(200) NOT NULL,
    DOB DATE,  -- using the format of dd-mm-yyyy
    NetWorth BIGINT -- 3byte size number
);

-- Creating table with the movie entities containing attributes followed from the document
CREATE TABLE if not exists Movie( -- only create table if it does not exist already
	Movie_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- this will place MovieID in chronological order, going 1,2,3,etc
    AgeRating VARCHAR(5) NOT NULL,
    Title VARCHAR(50) NOT NULL, -- more string elements
    ReviewRating INT, -- integer element used
    Revenue BigINT,
    Length INT
);

-- Do the same for the remaining attributes in outlined in our ER Diagram

CREATE TABLE if not exists Award(
	Award_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- this will place AwardID in chronological order from low to high
    Category VARCHAR(100) NOT NULL, -- string variable containing letters
    Year INT, -- integer variable used
    AwardType VARCHAR(50) NOT NULL
);

-- Creating table with the ProductionStudio entities containing attributes followed from the document
CREATE TABLE if not exists ProductionStudio(
	Studio_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- place StudioID in chronological order
    YearlyRevenue BigINT,
    Name VARCHAR(100), -- string variable containing letters
    Location VARCHAR(100) NOT NULL,
    CEO VARCHAR(100) NOT NULL,
    YearFounded int
);

-- Creating table with the Actor entities containing attributes followed from the document
CREATE TABLE if not exists Actor(
	Actor_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fName VARCHAR(100) NOT NULL, -- string variable containing letters
    sName VARCHAR(100) NOT NULL,
    NetWorth BigINT,
    DOB DATE
);

CREATE TABLE if not exists Movie_Genre(
 	Movie_ID INT,
	Genre VARCHAR(100) not null,
	PRIMARY KEY (Movie_ID, Genre),
	FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID) -- References create a relational link between two tables
 );
    
--  Acts_In Table
CREATE TABLE if not exists Acts_In (
    Movie_ID INT,
    Actor_ID INT,
    PRIMARY KEY (Movie_ID, Actor_ID),
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID), -- References create a relational link between two tables
    FOREIGN KEY (Actor_ID) REFERENCES Actor(Actor_ID)
);

--  Directs Table
CREATE TABLE if not exists Directs (
    Director_ID INT,
    Movie_ID INT,
    PRIMARY KEY (Director_ID, Movie_ID),
    FOREIGN KEY (Director_ID) REFERENCES Director(Director_ID), -- References create a relational link between two tables
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID)
);

--  Works_With Table
CREATE TABLE if not exists Works_With (
    Director_ID INT,
    Actor_ID INT,
    PRIMARY KEY (Director_ID, Actor_ID),
    FOREIGN KEY (Director_ID) REFERENCES Director(Director_ID),
    FOREIGN KEY (Actor_ID) REFERENCES Actor(Actor_ID)
);

--  Produces Table
CREATE TABLE if not exists Produces (
    Studio_ID INT,
    Movie_ID INT,
    PRIMARY KEY (Studio_ID, Movie_ID),
    FOREIGN KEY (Studio_ID) REFERENCES ProductionStudio(Studio_ID),
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID)
);

--  Actor_Receives Table
CREATE TABLE if not exists Actor_Receives (
    Award_ID INT,
    Actor_ID INT,
    PRIMARY KEY (Award_ID, Actor_ID), -- Actor receives Award Id in our table
    FOREIGN KEY (Award_ID) REFERENCES Award(Award_ID), -- References create a relational link between two tables
    FOREIGN KEY (Actor_ID) REFERENCES Actor(Actor_ID)
);

--  Director_Receives Table
CREATE TABLE if not exists Director_Receives (
    Award_ID INT,
    Director_ID INT, -- integer element
    PRIMARY KEY (Award_ID, Director_ID),
    FOREIGN KEY (Award_ID) REFERENCES Award(Award_ID), -- shows connectionn between award and director
    FOREIGN KEY (Director_ID) REFERENCES Director(Director_ID)
);

-- Movie_Receives Table
CREATE TABLE if not exists Movie_Receives (
    Award_ID INT,
    Movie_ID INT,
    PRIMARY KEY (Award_ID, Movie_ID),
    FOREIGN KEY (Award_ID) REFERENCES Award(Award_ID), -- references award to movie being awarded
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID)
);

-- INSERTIONS (BELOW)
-- Insert movie data into the Movie table
INSERT INTO Movie (Title, ReviewRating, Revenue, Length, AgeRating)
VALUES 
('Oppenheimer', 8, 975985123, 181, 'R'), -- Historical thriller directed by Nolan
('Kung Fu Panda', 7, 631000000, 92, 'PG'), -- Animated action-comedy
('Inception', 9, 839030630, 148, 'PG13'), -- Sci-fi thriller by Nolan
('Minecraft', 6, 551000000, 101, 'PG'),
('Titanic', 8, 2264000000, 194, 'PG13'),
('Barbie', 7, 1444459229, 114, 'PG13'),
('The Wolf Of Wall Street', 8, 406900000, 180, 'R');
-- Insert director data into the Director table
INSERT INTO director(fName, sName, DOB, NetWorth)
	VALUES
    ('Christopher', 'Nolen', '1970-7-30', 250000000),  -- Directed Oppenheimer, Inception
    ('Mark','Osborn', '1970-9-17', 2200000), -- Directed Kung Fu Panda
	('Jared', 'Hess', '1979-7-18', 15000000), -- Directed Minecraft
    ('James', 'Cameron', '1954-8-16', 800000000), -- Directed Titanic
    ('Greta', 'Gerwig', '1983-8-4', 12000000), -- Directed Barbie
    ('Martin', 'Scorsese', '1942-11-17', 200000000); -- Directed The Wolf of Wall Street
    
    -- Insert studio data into the ProductionStudio table
INSERT INTO ProductionStudio(Name, YearlyRevenue, Location, CEO, YearFounded)
VALUES
('Universal Pictures', 10700000, 'California', 'Mark Woodbury', 1912),
('DreamWorks', 319000000, 'California', 'Jeffrey Katzenberg', 1994),
('Warner Bros. Pictures', 12150000000, 'Burbank California', 'Michael De Luca and Pamela Abdy ', 1923),
('Mojang Studios', 75000000, 'Stockholm Sweden', 'Jonas Mårtensson', 2009),
('Fox Baja', 13980000000, 'Mexico', 'Lachlan Murdoch', 1996),
('Red Granite Pictures', 47333333, 'California', 'Riza Aziz', 2010);


-- Insert actor data into the Actor table
INSERT INTO Actor(fName, sName, NetWorth, DOB)
VALUES
('Jack', 'Black', 5000000, '1969-8-28'), -- Starred in Kung Fu Panda, Minecraft
('Leonado', 'Di Caprio', 3000000, '1964-11-11'), -- Starred in Inception, Titanic, Wolf of Wall Street
('Margot', 'Robbie', 6000000, '1990-7-2'), -- Starred in Barbie, Wolf of Wall Street
('Cillian', 'Murphy', 2000000, '1976-5-25'), -- Starred in Oppenheimer, Inception
('Jackie', 'Chan', 40000000, '1954-4-7'); -- Starred in Kung Fu Panda

-- Insert award data into the Award table
INSERT INTO Award(Category, Year, AwardType)
VALUES
('Best Actor', 2024, 'BAFTA'),
('Best Actor', 2014, 'Golden Globe'),
('Best Fight', 2002, 'MTV Movie & TV Award'),
('Comedic Genius', 2022, 'MTV Movie & TV Award'),
('Favourite Movie Actress', 2024, "People's Choice Award"),
('Cinematic Box Office Achievement', 2024, 'Golden Globe'),
('Best Picture', 1998, 'Academy Award'),
('Best Original Song', 2024, 'Academy Awards'),
('Best Movie', 1998, 'MTV Movie & TV Award'),
('Best Cinematography', 2011, 'Academy Awards'),
('Best Directing', 2007, 'Academy Award'),
('Best Directing', 1998, 'Academy Award'),
('Best Motion Picture', 1998, 'Golden Globe'),
('Best Animated Short Film', 2023, 'Grand Jury Award'),
('Best Original Screenplay', 2004, 'Critics Choice Movie Awards');

-- Map each movie to one or more genres in Movie_Genre
INSERT INTO Movie_Genre(Movie_ID, Genre)
VALUES
(1, 'Thriller'), -- Oppenheimer
(1, 'Historical drama'),
(2, 'Animation'), -- Kung Fu Panda
(2, 'Action'),
(3, 'Sci-Fi'), -- Inception
(3, 'Thriller'),
(4, 'Animation'), -- Minecraft
(4, 'Fantasy'),
(5, 'Drama'), -- Titanic
(5, 'Romantic Comedy'),
(6, 'Crime drama'), -- Barbie
(5, 'Thriller'); -- Titanic

-- Link actors to the movies they appeared in
INSERT INTO acts_in(Movie_ID, Actor_ID)
VALUES
(1, 4), -- Cillian in Oppenheimer
(2, 5), -- Jackie in Kung Fu Panda
(2, 1), -- Jack in Kung Fu Panda
(3, 4), -- Cillian in Inception
(3, 2), -- Leonardo in Inception
(4, 1), -- Jack in Minecraft
(5, 2), -- Leonardo in Titanic
(6, 3), -- Margot in Barbie
(7, 3), -- Margot in Wolf of Wall Street
(7, 2); -- Leonardo in Wolf of Wall Street

-- Link directors to the movies they directed
INSERT INTO Directs(Director_ID, Movie_ID)
VALUES
(1, 1), -- Nolan → Oppenheimer
(1, 3), -- Nolan → Inception
(2, 2), -- Osborn → Kung Fu Panda
(3, 4), -- Hess → Minecraft
(4, 5), -- Cameron → Titanic
(5, 6), -- Gerwig → Barbie
(6, 7); -- Scorsese → Wolf of Wall Street

-- Map collaborations between directors and actors
INSERT INTO Works_With(Director_ID, Actor_ID)
VALUES
(1, 2), -- Nolan with Di Caprio
(1, 4), -- Nolan with Cillian
(2, 1), -- Osborn with Jack Black
(3, 1), -- Hess with Jack Black
(4, 2), -- Cameron with Di Caprio
(5, 3), -- Gerwig with Margot
(6, 2), -- Scorsese with Di Caprio
(6, 3), -- Scorsese with Margot
(6, 1), -- Scorsese with Jack Black
(4, 1), -- Cameron with Jack Black
(4, 5); -- Cameron with Jackie Chan 

-- Link movies to the studios that produced them
INSERT INTO Produces(Movie_ID, Studio_ID)
VALUES
(1, 1), -- Oppenheimer → Universal
(2, 2), -- Kung Fu Panda → DreamWorks
(3, 3), -- Inception → Warner Bros
(4, 4), -- Minecraft → Mojang
(5, 5), -- Titanic → Fox Baja
(6, 1), -- Barbie → Universal
(7, 6); -- Wolf of Wall Street → Red Granite

-- Record awards won by actors
INSERT INTO Actor_Receives(Actor_ID, Award_ID)
VALUES
(4, 1), -- Cillian → Best Actor (BAFTA)
(5, 3), -- Jackie → Best Fight
(2, 2), -- Leonardo → Best Actor (Golden Globe)
(1, 4), -- Jack → Comedic Genius
(3, 5); -- Margot → Favourite Actress

-- Record awards received by movies
INSERT INTO Movie_Receives(Movie_ID, Award_ID)
VALUES
(6, 6), -- Barbie → Box Office Achievement
(5, 7), -- Titanic → Best Picture
(6, 8), -- Barbie → Best Original Song
(5, 9), -- Titanic → Best Movie (MTV)
(3, 10); -- Inception → Best Cinematography

-- Record awards won by directors
INSERT INTO Director_Receives(Director_ID, Award_ID)
VALUES
(5, 11), -- Gerwig → Best Directing (2007)
(4, 12), -- Cameron → Best Directing (1998)
(4, 13), -- Cameron → Best Motion Picture
(4, 14), -- Cameron → Animated Short Film
(5, 15); -- Gerwig → Original Screenplay