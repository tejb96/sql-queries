# query 1
SELECT competitor.FName,competitor.LName
FROM competition.competitor;

# query 2
SELECT competitor.FName,competitor.LName
FROM competition.competitor
WHERE Age<12 AND Instrument='Oboe';

# query 3
SELECT competitor.CompetitorID, teacher.StudioName
FROM competition.competitor, competition.teacher
WHERE competitor.TeacherID=teacher.TeacherID;

# query 4
SELECT competitor.FName, performance.Score
FROM competition.competitor,competition.performance
WHERE competitor.CompetitorID=performance.CompetitorID;