
## Challenge 1 - Most Profiting Authors

### Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
SELECT authors.au_id, au_fname, au_lname, titles.title_id, titles.title, round((titles.advance*titleauthor.royaltyper/100),2) as advance_per_title_autor, 
round(titles.price * sales.qty * (titles.royalty/100) * (titleauthor.royaltyper/100),2) royalty_per_sale FROM publications.sales
join titles on (sales.title_id = titles.title_id)
join titleauthor on (titles.title_id=titleauthor.title_id)
join authors on (titleauthor.au_id=authors.au_id)
#group by authors.au_id, titles.title_id
order by qty desc
;

### Step 2: Aggregate the total royalties for each title and author
select sales_per_autor.au_id, au_fname, au_lname, sales_per_autor.title_id, sales_per_autor.title, sum(sales_per_autor.royalty_per_sale) as royalty_per_sale
 from(
	SELECT titleauthor.au_id, au_fname, au_lname, titles.title_id, titles.title, round((titles.advance*titleauthor.royaltyper/100),2) as advance_per_title_autor, 
	round(titles.price * sales.qty * (titles.royalty/100) * (titleauthor.royaltyper/100),2) royalty_per_sale FROM publications.sales
	join titles on (sales.title_id = titles.title_id)
	join titleauthor on (titles.title_id=titleauthor.title_id)
	join publications.authors on (titleauthor.au_id=authors.au_id)) as sales_per_autor
group by sales_per_autor.au_id, sales_per_autor.title_id
order by sales_per_autor.title 
;

### Step 3: Calculate the total profits of each author
select total_profits.au_id, total_profits.royalty_per_sale + total_profits.advance_per_autor as profit_per_autor
from (select sales_per_autor.au_id, au_fname, au_lname, sales_per_autor.title_id, 
	 sales_per_autor.title, sum(sales_per_autor.royalty_per_sale) as royalty_per_sale,
     sales_per_autor.advance_per_title_autor as advance_per_autor
	 from(
		SELECT titleauthor.au_id, au_fname, au_lname, titles.title_id, titles.title, round((titles.advance*titleauthor.royaltyper/100),2) as advance_per_title_autor, 
		round(titles.price * sales.qty * (titles.royalty/100) * (titleauthor.royaltyper/100),2) royalty_per_sale FROM publications.sales
		join titles on (sales.title_id = titles.title_id)
		join titleauthor on (titles.title_id=titleauthor.title_id)
		join publications.authors on (titleauthor.au_id=authors.au_id)) as sales_per_autor
		group by sales_per_autor.au_id, sales_per_autor.title_id
		order by sales_per_autor.title) as  total_profits
order by profit_per_autor desc limit 3
;

## Challenge 2 - Alternative Solution

# from the first subquery that we use before, we create a new temp table. and we will try to chain it to the next one.
create temporary table Royalty_advance
select * from (
	SELECT titleauthor.au_id, au_fname, au_lname, titles.title_id, titles.title, round((titles.advance*titleauthor.royaltyper/100),2) as advance_per_title_autor, 
	round(titles.price * sales.qty * (titles.royalty/100) * (titleauthor.royaltyper/100),2) royalty_per_sale FROM publications.sales
	join titles on (sales.title_id = titles.title_id)
	join titleauthor on (titles.title_id=titleauthor.title_id)
	join publications.authors on (titleauthor.au_id=authors.au_id)) as sales_per_autor
	group by sales_per_autor.au_id, sales_per_autor.title_id
	order by sales_per_autor.title;
  
create temporary table aggregate_royalties
select * from ( 
	 select au_id, au_fname, au_lname, title_id, 
	 title, sum(royalty_per_sale) as royalty_per_sale,
     advance_per_title_autor as advance_per_autor
	 from Royalty_advance
     group by Royalty_advance.au_id, Royalty_advance.title_id
	 order by Royalty_advance.title) as sales_per_autor
;

select au_id, royalty_per_sale + advance_per_autor as profit_per_autor
from aggregate_royalties
order by profit_per_autor desc 
limit 3
;


## Challenge 3
CREATE TABLE `most_profiting_authors` (
	`au_id` char(11),
	`profits` dec(7,2)
    );
    
insert into publications.most_profiting_authors (au_id, profits)
values( '722-51-5454',  11263.46), 
	  ('213-46-8915', 10150.12), 
      ('238-95-7766', 7110.16);
   

