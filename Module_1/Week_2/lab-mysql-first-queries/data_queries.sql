#1. Which are the different genres?
SELECT  prime_genre, count(prime_genre) as apps_by_genre 
FROM  applestore.data
GROUP BY prime_genre
;


#2. Which is the genre with more apps rated?
SELECT  prime_genre, count(prime_genre) as app_by_genre, 
sum(rating_count_tot) as total_raiting_by_genre, 
sum(rating_count_ver) as  ver_raiting_by_genre
FROM  applestore.data
GROUP BY prime_genre 
ORDER BY total_raiting_by_genre DESC 
;


#3. Which is the genre with more apps?
SELECT  prime_genre,  count(prime_genre) as app_per_genre, rating_count_tot, rating_count_ver 
FROM  applestore.data
GROUP BY prime_genre
ORDER BY  app_per_genre desc
LIMIT 1
;

#4. Which is the one with less?
SELECT  prime_genre,  count(prime_genre) as app_per_genre, rating_count_tot, rating_count_ver 
FROM  applestore.data
GROUP BY prime_genre
ORDER BY  app_per_genre
LIMIT 1
;

#5. Take the 10 apps most rated.
select track_name as app_name, rating_count_tot,
user_rating
FROM  applestore.data
order by  rating_count_tot desc, user_rating desc
limit 10
;


#6. Take the 10 apps best rated by users.
select track_name as app_name, user_rating,
rating_count_tot
FROM  applestore.data
order by user_rating desc, rating_count_tot desc
limit 10
;

#9. Now compare the data from questions 5 and 6. What do you see?

#10. How could you take the top 3 regarding the user ratings but also the number of votes?
select track_name as app_name, user_rating,
rating_count_tot, rating_count_ver
FROM  applestore.data
order by user_rating desc, rating_count_tot desc, rating_count_ver desc
limit 3
;

#11. Does people care about the price? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?

select track_name as app_name, user_rating,
rating_count_tot, price
FROM  applestore.data
order by user_rating desc, rating_count_tot desc
limit 25
;

select track_name as app_name, user_rating,
rating_count_tot, price
FROM  applestore.data
order by price desc, user_rating desc, rating_count_tot desc
limit 25
;



select prime_genre as app_by_genre, round(avg(user_rating),2) rating_avg,
avg(rating_count_tot) as tot_rating_avg, round(AVG(price),2) as price_avg
FROM  applestore.data
group by prime_genre
order by rating_avg desc, price_avg desc,  tot_rating_avg desc
limit 25
;
