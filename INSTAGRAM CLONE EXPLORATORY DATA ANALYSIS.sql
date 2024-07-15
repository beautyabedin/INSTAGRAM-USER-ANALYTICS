/*INSTAGRAM CLONE EXPLORATORY DATA ANALYSIS USING SQL*/

use ig_clone;
-- --------------------------------------------------------------------------------------------------------------

##  A) Marketing Analysis:


/*Ques.1 five oldest users on Instagram */

SELECT *
FROM users
ORDER BY created_at 
LIMIT 5;
-- --------------------------------------------------------------------------------------------------------------

/*Ques.2  The users who have never posted a single photo on Instagram.*/

SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- --------------------------------------------------------------------------------------------------------------

/*Ques.3 The user who gets the most likes on a single photo.*/

SELECT username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

 
/* Ques 5. What day of the week do most users register on It ? */

SELECT 
    dayname(created_at) AS day,
    count(*) As total
FROM users
group by day   
order by total desc
limit 1;


-- --------------------------------------------------------------------------------------------------------------

## B) Investor Metrics:

/* Calculate average number of photos per user. */

SELECT (SELECT count(*) 
              FROM photos) / (SELECT count(*) 
                                         FROM users) As avg;



-- --------------------------------------------------------------------------------------------------------------

/* Finding the bots - the users who have liked every single photo */

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 


