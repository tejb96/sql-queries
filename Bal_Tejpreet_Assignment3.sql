SELECT competitor.FName, competitor.LName, teacher.StudioName
FROM competition.competitor, competition.teacher
WHERE competitor.TeacherID=teacher.TeacherID;

# query 2
SELECT teacher.StudioName,count(competitor.CompetitorID)
FROM competition.competitor, competition.teacher
WHERE competitor.TeacherID=teacher.TeacherID
group by teacher.StudioName;

# query 3
SELECT teacher.StudioName, count(TeacherID)
FROM competition.teacher
group by teacher.StudioName;

# query 4
SELECT nc.name, nc.c as total_students
FROM (SELECT teacher.LName as name, count(CompetitorID) as c
FROM competition.competitor, competition.teacher
WHERE competitor.TeacherID=teacher.TeacherID
group by teacher.LName) as nc
WHERE c>1;

# Query 5

SELECT competitor.FName, competitor.LName, composition.Title

FROM competition.competitor, competition.composition, competition.performance, (SELECT composition.MusicID as MID
FROM competition.composition
WHERE composition.Genre='Romantic') as romantic

Where composition.MusicID=romantic.MID AND competitor.CompetitorID=performance.CompetitorID AND performance.MusicID=romantic.MID;

# query 6
select distinct composition.Title, performance.CategoryID
From competition.composition as composition
left join competition.performance as performance
on composition.MusicID=performance.MusicID;

# query 7
CREATE VIEW competition.SCORE_ANALYSIS AS
select competitor.Age, performance.Score
FROM competition.competitor, competition.performance
WHERE competitor.CompetitorID=performance.CompetitorID;

# query 8
select *
from competition.score_analysis
order by Score DESC;

# query 9
select min(Score), MAX(Score), AVG(Score)
from score_analysis;

# query 10
ALTER TABLE competition.composition ADD
COLUMN Copyright varchar(15) DEFAULT 'SOCAN';

SELECT * FROM competition.composition;

# query 11
SELECT c.FName,c.LName,c.Age, cat.CategoryID, cat.AgeMin, cat.AgeMax
FROM competition.competitor AS c
JOIN competition.performance AS p on c.CompetitorID = p.CompetitorID
JOIN competition.category AS cat on cat.CategoryID = p.CategoryID
WHERE NOT EXISTS (SELECT 1
                  WHERE  c.Age BETWEEN cat.AgeMin AND cat.AgeMax);

# query 12
ALTER TABLE competition.competitor ADD CONSTRAINT check_age CHECK ( Age>=5 AND Age<=18);

# query 13
UPDATE competition.studio
SET studio.Name='Harmony Studio'
WHERE Name='Harmony Inc.';
# this change was automatically updated in the teacher table since when the table was created
# the ON UPDATE CASCADE contraint was placed on the foreign key

# query 14
# DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';
# this query causes an error because it breaks the referential integrity
# it attempts to delete tuple with musicID c1 which is also referred to in performance
# the on delete cascade contraint can be used for the MusicId fk in performance, for the query to run

# query 15
# it creates a trigger called Certification which executes for any update called on the teacher table
# it handles the issue by raising an exception that displays the custom message that 'Proof of certification must be provided to the main
# office.'