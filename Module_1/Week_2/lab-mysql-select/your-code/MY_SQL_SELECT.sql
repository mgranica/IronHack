#Challenge 1 - Who Have Published What At Where?
SELECT authors.au_id as AUTOR, au_lname as LAST_NAME, au_fname as FIRST_NAME, titles.title AS TITLE, pub_name as PUBLISHER
FROM publications.authors
JOIN titleauthor ON (authors.au_id=titleauthor.au_id)
JOIN titles ON (titleauthor.title_id=titles.title_id)
JOIN publishers ON (titles.pub_id=publishers.pub_id)
;

#Challenge 2 - Who Have Published How Many At Where?
SELECT authors.au_id as AUTOR, au_lname as LAST_NAME, au_fname as FIRST_NAME, count(titles.title) AS TITLE, pub_name as PUBLISHER
FROM publications.authors
JOIN titleauthor ON (authors.au_id=titleauthor.au_id)
JOIN titles ON (titleauthor.title_id=titles.title_id)
JOIN publishers ON (titles.pub_id=publishers.pub_id)
GROUP BY authors.au_id
;

#Challenge 3 - Best Selling Authors
SELECT authors.au_id as AUTOR, au_lname as LAST_NAME, 
au_fname as FIRST_NAME, titles.title as TITLE, pub_name as PUBLISHER,
sum(sales.qty) as TOTAL
FROM publications.authors
JOIN titleauthor ON (authors.au_id=titleauthor.au_id)
JOIN titles ON (titleauthor.title_id=titles.title_id)
JOIN publishers ON (titles.pub_id=publishers.pub_id)
JOIN sales ON (titles.title_id=sales.title_id)
GROUP BY authors.au_id
ORDER BY TOTAL DESC
LIMIT 3
;

#Challenge 4 - Best Selling Authors Ranking
SELECT authors.au_id as AUTOR, au_lname as LAST_NAME, 
au_fname as FIRST_NAME, titles.title as TITLE, pub_name as PUBLISHER,
sales.qty as TOTAL
FROM publications.authors
JOIN titleauthor ON (authors.au_id=titleauthor.au_id)
JOIN titles ON (titleauthor.title_id=titles.title_id)
JOIN publishers ON (titles.pub_id=publishers.pub_id)
JOIN sales ON (titles.title_id=sales.title_id)
GROUP BY authors.au_id
ORDER BY TOTAL DESC
;

