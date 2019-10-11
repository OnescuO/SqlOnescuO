

INSERT INTO Movie
VALUES
('Django Unchained','2012-12-12','8','2:45:00'),
('The Wolf of Wall Street','2013-12-25','8','3:00:00'),
('King Arthur','2017-05-14', '7','2:06:00'),
('Memoirs of a Geisha','2005-12-23','7','2:25:00'),
('The Dark Knight','2008-07-10','9','2:32:00');

UPDATE Movie SET Title='ArtificiallyUpdated' WHERE Rating<10;

CREATE TABLE Actor (
ActorId int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirhDate date,
PopularityRating int
);

INSERT INTO Actor
VALUES
('Leonardo','DiCaprio','USA','1974-11-11','7'),
('Heath','Ledger','Australia','1979-04-04','5'),
('Charlie','Hunnam','England','1980-04-10','6');

SELECT MIN(Rating) AS SmallestRating FROM Movie;
SELECT MAX(Id) AS MostMovieDirected FROM Director;

SELECT * FROM Director ORDER BY LastName ASC;
SELECT * FROM Director ORDER BY Birth DESC;

UPDATE Movie SET Rating = Rating + 1 WHERE DirectorId=7;

CREATE TABLE MovieActor (
    MovieId int IDENTITY(1,1) PRIMARY KEY,
	DirectorId int CONSTRAINT fk_director REFERENCES Director(Id),
	ActorId int CONSTRAINT fk_actor REFERENCES Actor(ActorId)
);

INSERT INTO MovieActor(DirectorId,ActorId) VALUES(1,5);

CREATE TABLE Genre(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(MAX) NOT NULL
);



CREATE TABLE MovieGenre(
	MovieId int CONSTRAINT fk_movie REFERENCES Movie(MovieId),
	GenreId int CONSTRAINT fk_genre REFERENCES Genre(Id)
);

INSERT INTO Genre(Name) VALUES('Comedy');
INSERT INTO Genre(Name) VALUES('Action');

SELECT A.ActorId, COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId
HAVING COUNT(d.Id) >= (SELECT COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId)

SELECT A.FirstName, A.LastName,g.Name
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m 
ON ma.MovieId =m.DirectorId INNER JOIN MovieGenre mg ON m.DirectorId=mg.MovieId INNER JOIN Genre g ON mg.GenreId=g.GenreID