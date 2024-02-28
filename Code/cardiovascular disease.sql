select * from [Cardiovascular Disease]

--BMI = weight in kilograms/(height in meters)^2
​
--Underweight: BMI less than 18.5
--Normal weight: BMI between 18.5 and 24.9
--Overweight: BMI between 25 and 29.9
--Obesity: BMI of 30 or higher

-- inserting new​ column for BMI category
ALTER TABLE [Cardiovascular Disease]
ADD bmi_category NVARCHAR(100);

-- inserting values
UPDATE [Cardiovascular Disease]
SET bmi_category = 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.99999 THEN 'Normal weight'
        WHEN bmi BETWEEN 25 AND 29.99999 THEN 'Overweight'
        WHEN bmi >= 30 THEN 'Obesity'
        ELSE 'Unknown' -- or any other 
    END;


--checking duplicate id's
select id, count(*) from [Cardiovascular Disease]
group by id
having count(*) > 1


--- count of female and male
select Gender, count(*) as count from [Cardiovascular Disease] group by Gender 

-- 0-12 
-- 13-18
-- 19-35
-- 36-65
-- >=65

-- calculating the age bins for cardio disease
select Cardiovascular_Disease,
count(case when age_years between 0 and 12 then id end) as '0-12',
count(case when age_years between 13 and 18 then id end) as '13-18',
count(case when age_years between 19 and 35 then id end) as '19-35',
count(case when age_years between 36 and 65 then id end) as '36-65',
count(case when age_years >= 65 then id end) as '>=65'
from [Cardiovascular Disease]
group by Cardiovascular_Disease

-- calculating the age bins for cholesterol
select cholesterol,
count(case when age_years between 0 and 12 then id end) as '0-12',
count(case when age_years between 13 and 18 then id end) as '13-18',
count(case when age_years between 19 and 35 then id end) as '19-35',
count(case when age_years between 36 and 65 then id end) as '36-65',
count(case when age_years >= 65 then id end) as '>=65'
from [Cardiovascular Disease]
group by cholesterol

-- calculating the age bins for glucose
select Glucose,
count(case when age_years between 0 and 12 then id end) as '0-12',
count(case when age_years between 13 and 18 then id end) as '13-18',
count(case when age_years between 19 and 35 then id end) as '19-35',
count(case when age_years between 36 and 65 then id end) as '36-65',
count(case when age_years >= 65 then id end) as '>=65'
from [Cardiovascular Disease]
group by Glucose

-- average weight by gender where cardiovascular is present
select gender, Round(avg(weight_kg),2) as weight from [Cardiovascular Disease]
where cardiovascular_disease = 'Present'
group by Gender

-- cardiovascular disease present by gender
select gender, count(*) as count from [Cardiovascular Disease]
where cardiovascular_disease = 'Present'
group by Gender


-- smoking percentage present and absent

SELECT 'No' as somking,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN smoking = 'No' AND cardiovascular_disease = 'present' THEN 1 ELSE 0  END) AS smokers_with_cvd_present,
    Round((SUM(CASE WHEN smoking = 'No' AND cardiovascular_disease = 'present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS percentage_present,
	SUM(CASE WHEN smoking = 'No' AND cardiovascular_disease = 'absent' THEN 1 ELSE 0  END) AS smokers_with_cvd_absent,
	Round((SUM(CASE WHEN smoking = 'No' AND cardiovascular_disease = 'absent' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS percentage_absent
FROM 
    [Cardiovascular Disease]
WHERE 
    smoking = 'No'
	union
SELECT 'Yes' as smoking,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN smoking = 'Yes' AND cardiovascular_disease = 'present' THEN 1 ELSE 0  END) AS smokers_with_cvd_present,
    Round((SUM(CASE WHEN smoking = 'Yes' AND cardiovascular_disease = 'present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS percentage_present,
	SUM(CASE WHEN smoking = 'Yes' AND cardiovascular_disease = 'absent' THEN 1 ELSE 0  END) AS smokers_with_cvd_absent,
	Round((SUM(CASE WHEN smoking = 'Yes' AND cardiovascular_disease = 'absent' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS percentage_absent
FROM 
    [Cardiovascular Disease]
WHERE 
    smoking = 'Yes';

-- Alcohol takers where cardiovascular disease is present
select 
'No' as Alcohol_intake,
count(*) as total_patient,
sum(case when cardiovascular_disease = 'Present' then 1 else 0 end) as Alcohol_takers_with_cvd_present,
(sum(case when cardiovascular_disease = 'Present' then 1 else 0 end)*100.0 /count(*)) as percentage
from [Cardiovascular Disease]
where Alcohol_intake = 'No'
union
select
'Yes' as Alcohol_intake,
count(*) as total_patient,
sum(case when cardiovascular_disease = 'Present' then 1 else 0 end) as Alcohol_takers_with_cvd_present,
(sum(case when cardiovascular_disease = 'Present' then 1 else 0 end)*100.0 /count(*)) as percentage
from [Cardiovascular Disease]
where Alcohol_intake = 'Yes'

-- cholesterol percent of patient by cardiovascular disease
select cardiovascular_disease, count(*) as patient_count,
 sum(case when cholesterol = 'Normal' then 1 else 0 end)*100.0/ count(*) as 'Normal cholesterol',
 sum(case when cholesterol = 'Above Normal' then 1 else 0 end )*100.0/ count(*) as 'Above Normal cholesterol',
 sum(case when cholesterol = 'Well Above Normal' then 1 else 0 end ) * 100.0/ count(*) as 'Well Above Normal cholesterol'
 from [Cardiovascular Disease]
group by cardiovascular_disease

-- Glucose percent of patient by cardiovascular disease
select cardiovascular_disease, count(*) as patient_count,
 sum(case when Glucose = 'Normal' then 1 else 0 end)*100.0/ count(*) as 'Normal Glucose',
 sum(case when Glucose = 'Above Normal' then 1 else 0 end )*100.0/ count(*) as 'Above Normal Glucose',
 sum(case when Glucose = 'Well Above Normal' then 1 else 0 end ) * 100.0/ count(*) as 'Well Above Normal Glucose'
 from [Cardiovascular Disease]
group by cardiovascular_disease

-- avg age by blood pressure category
select blood_pressure_category, AVG(age_years) avg_age from [Cardiovascular Disease]
group by blood_pressure_category
order by avg_age

-- Physical_activity percentage 

select 'Yes' as Physical_activity,
count(*) as count_of_patient,
sum(case when cardiovascular_disease = 'Present' then 1 else 0 end) patient_wit_cardio_present,
(sum(case when cardiovascular_disease = 'Present' then 1 else 0 end)*100.0)/count(*) as percentage
from [Cardiovascular Disease]
where Physical_activity = 'Yes'
union
select 'No' as Physical_activity,
count(*) as count_of_patient,
sum(case when cardiovascular_disease = 'Present' then 1 else 0 end) patient_wit_cardio_present,
(sum(case when cardiovascular_disease = 'Present' then 1 else 0 end)*100.0)/count(*) as percentage
from [Cardiovascular Disease]
where Physical_activity = 'No'

-- Average age by bmi_category where cardi disease is present
select bmi_category, Round(avg(age_years),2) as avg_age from [Cardiovascular Disease]
where cardiovascular_disease = 'Present'
group by bmi_category
 -- Average age by bmi_category where cardi disease is absent
select bmi_category, Round(avg(age_years),2) as avg_age from [Cardiovascular Disease]
where cardiovascular_disease = 'Absent'
group by bmi_category

-- count of paitent cholesterol category by bmi
select 
bmi_category,
count(case when cholesterol = 'Normal' then id end) as Normal,
count(case when cholesterol = 'Above Normal' then id end) as Above_Normal,
count(case when cholesterol = 'Well Above Normal' then id end) as Well_Above_Normal
from [Cardiovascular Disease]
group by bmi_category

-- count of paitent cholesterol category by blood pressure
select 
Blood_pressure_category,
count(case when cholesterol = 'Normal' then id end) as Normal,
count(case when cholesterol = 'Above Normal' then id end) as Above_Normal,
count(case when cholesterol = 'Well Above Normal' then id end) as Well_Above_Normal
from [Cardiovascular Disease]
group by Blood_pressure_category

-- Risk Stratification
-- paitents may need to change their lifestyle and the paitents have higher risk of getting cardiovascular disease
select id, cardiovascular_disease, age_years from [Cardiovascular Disease]
where cholesterol = 'Above Normal' and Blood_pressure_category = 'Hypertension Stage 1'  and bmi_category in ('Overweight','Obesity') 
