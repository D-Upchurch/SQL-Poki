-- 1. What grades are stored in the database?

/*
Select * from Grade;
*/

-- 2. What emotions may be associated with a poem?

/*
Select * from Emotion;
*/

-- 3. How many poems are in the database?

/*
Select Count(p.Id) NumberOfPoems
from Poem p;
*/

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?

/*
Select distinct top 76 auth.Name
from Author auth
Order by auth.Name asc;
*/

-- 5. Starting with the above query, add the grade of each of the authors.

/*
Select distinct top 76 
	auth.Name,
	 grd.Name
from Author auth Left Join Grade grd on auth.GradeId = grd.Id
Order by auth.Name asc;
*/

-- 6. Starting with the above query, add the recorded gender of each of the authors.

/*
Select distinct top 76 
	auth.Name,
	 grd.Name,
	  gn.Name
from Author auth Left Join Grade grd on auth.GradeId = grd.Id Left Join Gender gn on auth.GenderId = gn.Id
Order by auth.Name asc;
*/

-- 7. What is the total number of words in all poems in the database?

/*
Select sum(WordCount) WordCount
from Poem;
*/

-- 8. Which poem has the fewest characters?

/*
Select top 1 p.Title,
		min(charCount) Characters
from Poem p
group by p.Title, p.CharCount;
*/

-- 9. How many authors are in the third grade?

/*
Select count(auth.Name) NumberOfAuthors
from Author auth Left Join Grade grd on auth.GradeId = grd.Id
where grd.Id = 3
*/

-- 10. How many total authors are in the first through third grades?

/*
Select count(auth.Name) NumberOfAuthors
from Author auth Left Join Grade grd on auth.GradeId = grd.Id
where grd.Id = 3 or grd.Id = 2 or grd.Id = 1;
*/

-- 11. What is the total number of poems written by fourth graders?

/*
Select count(p.Id) NumberOfPoems
from Poem p Left Join Author auth on p.AuthorId = auth.Id Left Join Grade grd on auth.GradeId = grd.Id
where grd.Id = 4;
*/

-- 12. How many poems are there per grade?

/*
Select  grd.Name,
		count(p.Id) NumberOfPoems
from Poem p Left Join Author auth on p.AuthorId = auth.Id Left Join Grade grd on auth.GradeId = grd.Id
group by grd.Id, grd.Name, auth.gradeId
order by grd.Id asc;
*/

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)

/*
Select grd.Name,
	count(auth.Id) NumberOfAuthors
from Author auth Left Join Grade grd on auth.GradeId = grd.Id
group by grd.Id, grd.Name, auth.GradeId
order by grd.Id asc;
*/

-- 14. What is the title of the poem that has the most words?

/*
Select p.Title
from Poem p
where p.WordCount = (select max(p.WordCount) from Poem p);
*/

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)

/*
Select top 3 auth.Name,
		Count(p.id)
from poem p join author auth on p.authorid = auth.id
group by Auth.Id, auth.name
order by count(p.Id) desc;
*/

-- 16. How many poems have an emotion of sadness?

/*
select count(pe.id) NumberOfPoems,
	  e.Name
from PoemEmotion pe 
right join emotion e on pe.emotionid = e.id
where pe.emotionid = 3
group by pe.emotionid, e.name;
*/

-- 17. How many poems are not associated with any emotion?

/*
Select Count(*) as EmotionlessPoems
from Poem p
Left Join PoemEmotion pe on pe.PoemId = p.Id
where pe.Id is Null;
*/

-- 18. Which emotion is associated with the least number of poems?

/*
select top 1 count(pe.id) NumberOfPoems,
	  e.Name
from PoemEmotion pe 
right join emotion e on pe.emotionid = e.id
group by pe.emotionid, e.name
order by pe.emotionid asc;
*/

-- 19. Which grade has the largest number of poems with an emotion of joy?

/*
select top 1 g.Name
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on pe.EmotionId = e.Id
join Author a on p.authorId = a.id
join grade g on a.gradeid = g.id
where e.Name = 'Joy'
group by g.Name
order by count(p.id) desc;
*/

-- 20. Which gender has the least number of poems with an emotion of fear?

/*
select top 1 count(pe.id) NumberOfPoems,
	  e.Name,
	  g.Name
from PoemEmotion pe 
join emotion e on pe.emotionid = e.id
join poem p on pe.poemid = p.id
join author auth on auth.id = p.authorid
join gender g on auth.genderid = g.id
where e.id = 2
group by pe.emotionid, e.name, g.name
order by pe.emotionid asc;
*/