-- Q3. Display the number of the customer group by their genders who have placed any order 
-- of amount greater than or equal to Rs.3000

select CUS_GENDER,count(CUS_GENDER) from `order` inner join customer on `order`.CUS_ID = customer.CUS_ID where ORD_AMOUNT >= 3000 group by CUS_GENDER;

-- Q4. Display all the orders along with the product name ordered by a customer having Customer_Id=2.

select `order`.*,product.PRO_NAME from `order`,product,product_details where `order`.CUS_ID =2 and `order`.PROD_ID = product_details.PROD_ID 
and product_details.PRO_ID = product.PRO_ID; 

-- Q5. Display the Supplier details who can supply more than one product.

select * from supplier where SUPP_ID in (select SUPP_ID from product_details group by SUPP_ID having count(SUPP_ID) > 1);

-- Q6. Find the category of the product whose order amount is minimum.

select category.* from `order` inner join product_details on `order`.prod_id = product_details.prod_id inner join product on product.pro_id = product_details.pro_id 
inner join category on product.cat_id = category.cat_id where `order`.ORD_AMOUNT = (select min(ORD_AMOUNT) from `order`);

-- Q7. Display the Id and Name of the Product ordered after “2021-10-05”. 

select product.PRO_ID, product.PRO_NAME from `order` inner join product_details on product_details.PROD_ID = `order`.PROD_ID inner join
product on product.PRO_ID = product_details.PRO_ID where `order`.ORD_DATE > '2021-10-05';

-- Q8. Print the top 3 supplier name and id and their rating on the basis of their rating along with the customer name who has given the rating.
 
select supplier.SUPP_ID,supplier.SUPP_NAME,rating.RAT_RATSTARS,customer.CUS_NAME from `supplier` inner join rating on rating.SUPP_ID = supplier.SUPP_ID
inner join customer on customer.CUS_ID = rating.CUS_ID order by rating.RAT_RATSTARS desc limit 3;

-- Q9. Display customer name and gender whose names start or end with character 'A'.  

select CUS_NAME, CUS_GENDER from customer where CUS_NAME LIKE 'A%' or CUS_NAME LIKE '%A';

-- Q10. Display the total order amount of the male customers. 

select sum(ORD_AMOUNT) from `order` inner join customer on `order`.CUS_ID = customer.CUS_ID and customer.CUS_GENDER = 'M';

-- Q11.	Display all the Customers left outer join with  the orders.

select * from customer left outer join `order` on customer.CUS_ID = `order`.CUS_ID;

-- Q12. 12)	Create a stored procedure to display the Rating for a Supplier if any along with the 
-- Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average 
-- Supplier” else “Supplier should not be considered”. 

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplierRatings`()
BEGIN
select supplier.supp_id, supplier.supp_name,rating.rat_ratstars,
case
when rating.rat_ratstars > 4 then 'Genuine Supplier' 
when rating.rat_ratstars > 2 then 'Average Supplier'
else 'Supplier should not be considered'
end as verdict from rating inner join supplier on supplier.supp_id = rating.supp_id;

END


