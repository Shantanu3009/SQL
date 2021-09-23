 -- Ans 1.

select ( count(ClaimNb)*100/  (select count(*)from auto_insurance_risk)) as percentage
 from auto_insurance_risk
where ClaimNb not in(0);

-- Result :5%

-- Ans 2.

-- 1.
alter table auto_insurance_risk
add  claim_flag integer;

-- 2.
update auto_insurance_risk
set claim_flag = CASE
when ClaimNb > 0 then 1
when ClaimNb < 0 then 0
else 0
end ;

-- Ans 3.

-- 1.
select claim_flag, avg(Exposure) from auto_insurance_risk
group by claim_flag;

-- 2.
-- Result : The Average Exposure period for those who made a claim is greater than those who didn't

-- Ans 4.

-- 1.
alter table auto_insurance_risk
add  exposure_buckets varchar(2);

update auto_insurance_risk
set exposure_buckets = CASE 
when Exposure between 0 and 0.25 then 'E1'
when Exposure between 0.26 and 0.50 then 'E2'
when Exposure between 0.51 and 0.75 then 'E3'
when Exposure > 0.75 then 'E4'
end ;

select exposure_buckets,(sum(ClaimNb)*100/(SELECT sum(ClaimNb)  from auto_insurance_risk where claim_flag in (1)  )) AS Claim_percent from auto_insurance_risk
group by exposure_buckets;

-- 2.
-- Result :The Claim Percentage increaser rapidly to from 17 % to 45% as exposure period incereases above 0.75

-- Ans 5.
select Area, avg(ClaimNb) *100 as percentage from Auto_insurance_risk GROUP by Area;

-- Result : Area "F" has the highest number of average claims

-- Ans 6.

select Area,exposure_buckets , sum(ClaimNb) *100.0 / count (ClaimNb) as "Claim_rate" from auto_insurance_risk
 GROUP by  Area,exposure_buckets ;

 -- Result :For any particular area the claim_rate increases as exposure increases i.e from E1 to E4

-- Ans 7.

-- 1.
select  claim_flag,avg(VehAge)  from auto_insurance_risk
group by claim_flag;

-- Result :The Average Vehicle Age for those who did not claim is greater by 0.5 years than those who claimed.

-- 2.
select Area,avg(VehAge) from auto_insurance_risk
where claim_flag in(1)
group by Area;

-- Result :The average vehicle age decreases as we move from Area A to F

-- Ans 8.

Select exposure_buckets ,claim_flag,avg(VehAge) from auto_insurance_risk
group by exposure_buckets,claim_flag;

-- Result :The average vehicle age for those who did not claim is greater than those who claimed in each Exposure Bucket

-- Ans 9.

-- 1.
alter table auto_insurance_risk
add  Claim_Ct varchar(20);

update auto_insurance_risk
set Claim_Ct = CASE 
when ClaimNb = 1 then '1 CLaim'
when ClaimNb = 0 then 'No Claims'
when ClaimNb > 1 then 'MT 1 Claims '
end;

select Claim_Ct, avg(BonusMalus) from auto_insurance_risk
group by Claim_Ct;
 
-- 2.
-- Result :As number of claims increases BonusMalus also increases

-- Ans 10.

select Claim_Ct,avg(Density) from auto_insurance_risk
group by Claim_Ct;

-- Result :The average density increases as the number of claims increase

-- Ans 11.

Select VehBrand,VehGas,avg(ClaimNb) from auto_insurance_risk
group by VehBrand,VehGas
order by avg(ClaimNb) desc;


-- Result :VehBrand =B12 and VehGas = Regular has the highest number of average claims

-- Ans 12.

SELECT Region,exposure_buckets, (sum(claim_flag)*100/count(claim_flag)) as claim_rate from auto_insurance_risk
group by Region,exposure_buckets
order by claim_rate desc;

/*  Result :top five regions and exposure_bucket combo is
Region	Exposure_Bucket		Claim_Rate
R11	E4			7
R22	E4			7
R25	E4			7
R42	E3			7
R53	E3			7
 */

-- Ans 13.

-- 1.

select count(DrivAge) from auto_insurance_risk
where DrivAge<18 and claim_flag in (1);


-- Result : No cases of undergrads driving

-- 2.
alter table auto_insurance_risk
add  DrivAge_Bucket varchar(20);

update auto_insurance_risk
set DrivAge_Bucket  = CASE 
when  DrivAge = 18 then '1-Beginner'
when  DrivAge BETWEEN 19 and 30 then '2-Junior'
when  DrivAge between 31 and 45 then '3-Middle Age'
when  DrivAge between 46 and 60 then '4-Mid Senior'
when  DrivAge > 60 then 'Senior'
end;

select DrivAge_Bucket ,avg(BonusMalus) from auto_insurance_risk
group by DrivAge_Bucket ;

-- Result :Average BonusMalus Decreases as age increases


/* Ans 14.

-Only one Primary Key can be created per table while more than one unique constraints can be added to a table
-We cannot insert null values into a primary key coloumn while coloumns having unique constraint can have null values

Ans 15.
The main idea behind the Cross Join is that it returns the Cartesian product of the joined tables.If there are 5 records in table A and 10 records in table B then,

After cross joining the resultant set will have 5*10= 50 records
 

Ans 16.
-Inner join :Inner join returns only the matching rows between both the tables while the non-matching rows are eliminated.
 

-Left outer join : Left Outer Join returns only the matching rows between both the tables along with the non-matching rows from the left table.
 


Ans 17.

tableA
Reg_id	Name												
1		A
2		B
3		C
4		D
5		E
	
tableB
log_id	Name
1		A
1		A
2		B
3		C
7		F	

SELECT reg_id,tablea.Name,log_id
From tablea
INNER JOIN tableb
ON tablea.Name=tableb.Name;



Reg_ID	Name	Log_id
1		A			1
1		A			1
2		B			2
3		C			3

Thus we get a result table which has the duplicated row joined twice


Ans 18.

-Where clause is used to filter before executing but if we want to filter based on some aggeregate function like sum() or count() etc we use Having clause with a group by
-Where clause can be used with or without a group by but having clause can't be used without a group by
-Where clause can be used with SELECT, DELETE or UPDATE commands but Having can only be used with a SELECT statement.  */





