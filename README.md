
# Cardiovascular Disease Analysis

This project offers a detailed exploration of key factors influencing cardiovascular disease risk. By analyzing patient demographics, including age distribution, and BMI categories, alongside crucial metrics such as blood pressure (both systolic and diastolic), Glucose, Cholesterol and parameters like smoking and alcohol intake. The project gives a comprehensive overview of cardiovascular health trends within the patient population. By uncovering correlations and patterns among these variables, healthcare professionals and researchers can gain valuable insights into potential risk factors and tailor interventions more effectively to promote heart health and prevent cardiovascular disease.

**_source_** : _kaggle,_ _Cardiovascular Disease dataset._

_Data description_

There are 3 types of input features:

•	Objective: factual information;

•	Examination: results of medical examination;

•	Subjective: information given by the patient.

Features:
1.	Age | Objective Feature | age | int (days)
2.	Height | Objective Feature | height | int (cm) |
3.	Weight | Objective Feature | weight | float (kg) |
4.	Gender | Objective Feature | gender | categorical code |
5.	Systolic blood pressure | Examination Feature | ap_hi | int |
6.	Diastolic blood pressure | Examination Feature | ap_lo | int |
7.	Cholesterol | Examination Feature | cholesterol | 1: normal, 2: above normal, 3: well above normal |
8.	Glucose | Examination Feature | gluc | 1: normal, 2: above normal, 3: well above normal |
9.	Smoking | Subjective Feature | smoke | binary |
10.	Alcohol intake | Subjective Feature | alco | binary |
11.	Physical activity | Subjective Feature | active | binary |
12.	Presence or absence of cardiovascular disease | Target Variable | cardio | binary | 

##

_"In examining the dataset provided, it encapsulates key patient details including age, gender, height, and weight, coupled with comprehensive medical reports concerning cardiovascular health. This combination of information offers a comprehensive view into the factors potentially influencing cardiovascular disease._

_By meticulously examining this dataset, we aim to uncover correlations, trends, and predictive indicators that may contribute significantly to understanding the dynamics of cardiovascular health within this cohort. The integration of demographic factors with medical insights is poised to offer actionable intelligence, aiding healthcare professionals and policymakers in refining preventive strategies and enhancing patient care.
The information contained within this dataset holds the promise of revealing valuable connections between patient attributes and cardiovascular health markers, fostering a deeper understanding of this critical health concern."_



## Understanding the domine concept

### Cholesterol
The levels of cholesterol are often divided into different categories:

**Normal**: This level indicates that the cholesterol levels are within the healthy range. It typically means that the levels of LDL cholesterol (often referred to as "bad" cholesterol) are lower while the levels of HDL cholesterol ("good" cholesterol) are higher.

**Above Normal**: This category suggests that the cholesterol levels, especially LDL cholesterol, are higher than the recommended range. Elevated LDL cholesterol can lead to the accumulation of cholesterol in the arteries, potentially increasing the risk of heart disease.

**Well Above Normal**: This level signifies significantly elevated cholesterol levels, especially LDL cholesterol, which substantially increases the risk of cardiovascular problems. Having well above normal cholesterol levels may indicate a greater risk of developing heart disease or experiencing related health issues.



### Bood pressure
Blood pressure categories help determine the level of risk associated with a person's blood pressure readings. They are typically classified as follows:

**Normal**: Blood pressure falls within a healthy range. It usually indicates that your heart is functioning well, and your risk of heart disease or other health issues related to high blood pressure is lower.

**Elevated**: This category suggests that the blood pressure readings are higher than the optimal range but not high enough to be classified as hypertension. It's a warning sign that indicates a higher risk of developing hypertension in the future if preventive measures are not taken.

**Hypertension Stage 1**: This stage indicates moderately high blood pressure. It means that the systolic pressure (the pressure when the heart beats) ranges from 130 to 139 mm Hg or the diastolic pressure (the pressure when the heart is at rest between beats) ranges from 80 to 89 mm Hg. At this stage, lifestyle changes are often recommended to manage blood pressure and reduce the risk of complications.

**Hypertension Stage 2**: Hypertension Stage 2 is considered more severe than Stage 1 and poses a higher risk of cardiovascular complications such as heart attacks, strokes, and other related conditions. Individuals with Stage 2 hypertension typically require more aggressive management strategies, including lifestyle modifications (such as dietary changes, exercise, and weight management) and medication to lower blood pressure and reduce the risk of cardiovascular events.

### Glucose

**Normal**: Glucose levels within the healthy range indicate that the body is processing sugar properly. Typically, this means that the fasting blood sugar level is between 70 to 100 milligrams per deciliter (mg/dL).

**Above Normal**: This could imply that the glucose levels are higher than the optimal range but might not be classified as diabetic. It might indicate a borderline or prediabetic condition, where the fasting blood sugar levels are slightly elevated, usually between 100 to 125 mg/dL.

**Well Above Normal**: This category typically suggests significantly elevated glucose levels, often associated with diabetes or uncontrolled blood sugar. It indicates fasting blood sugar levels of 126 mg/dL or higher, which is considered diagnostic for diabetes.


## Process

**Modifying The Data**
*	Changing the Gender 
*	=IF(C2=1, "F", IF(C2=2, "M", ""))
*	Changing the Cholesterol
*	=IF(I2=1,"Normal",IF(I2=2,"Above Normal",(IF(I2=3,"Well Above Normal"))))
*	Changing Glucose
*	=IF(K2=1,"Normal",IF(K2=2,"Above Normal",(IF(K2=3,"Well Above Normal"))))
*	Changing Smoking, Alcohol intake, Physical activity by the below sample formula
*	=IF(Q2=0,"No",IF(Q2=1,"Yes",""))
*	Changing Presence or absence of cardiovascular disease
*	=IF(S2=0,"Absent",IF(S2=1,"Present",""))

### SQL Analysis

```
--checking duplicate id's

select id, count(*) from [Cardiovascular Disease]
group by id
having count(*) > 1

-- inserting new column for BMI category
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

```

* count of female and male

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/8628dc86-902c-482a-b538-069833f524e4)

* Average Weight by Gender where cardiovascular disease present

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/eb0ba0ab-fda6-4c24-85e0-559f06608535)

* Gender count by cardiovascular disease present

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/0c3436b0-cd36-49b3-89a6-802ccc425e75)

* count the occurrences of individuals with cardiovascular disease in different age groups

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/bcf00a29-622d-457e-b584-567eef7142d3)

* count the occurrences of individuals with cholesterol level in different age groups

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/48c479fe-364c-44c3-b6ea-97a7600a895c)

* Smoking Percentage in Both present and absent patient

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/8c182482-008a-4de8-a743-61e37f4b22d2)

* cholesterol percentage of patient by cardiovascular disease

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/acf86507-6e88-4965-9bb9-cd964658ceef)

* Average age of patients by blood pressure category
  
  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/03671c11-5fee-4bde-bc6e-524bc122bb6d)

* Count of patient’s cholesterol by BMI category 

  ![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/2c86f747-ea57-4492-98c6-b7c85757fc95)

### Refer to Code Section for complete Analysis [SQL Code](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/blob/b5b94e10b16e11ff7c22b9087781c9766d8ac396/Code/cardiovascular%20disease.sql)


# Data Visualization and Analysis

Representing the data visually help the viewers to understand the complex datasets more easily, below is the dashboard for
Cardiovascular Disease Analysis   

![Cardiovascular Disease Analysis](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/c9cba409-75f8-4312-a157-76c236c5adff)

Please vist the dashboard here: [Dashboard](https://public.tableau.com/app/profile/himanshu.shriwas/viz/Cardivasculardisease/CardiovascularDiseaseAnalysis?publish=yes)


**Blood pressure**

Blood pressure plays a significant role in cardiovascular disease (CVD) as it is one of the primary risk factors for developing various cardiovascular conditions.

![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/d0463162-e1c4-4c6e-8be7-7157b19d5bc3)


As per the above bar chart 23.37% of patients are in the hypertension stage 2 which means this patients have higher risk of having cardiovascular disease. Individuals at this stage typically require more aggressive management strategies, including lifestyle modifications (such as dietary changes, exercise, and weight management) and medication to lower blood pressure and reduce the risk of cardiovascular events.

Around 58.28% of patients are in the Hypertension stage 1. This patients have moderately high blood pressure, Individuals at this stage are often recommended lifestyle changes to reduce the risk of causing cardiovascular disease 

**BMI**

Body Mass Index (BMI) is a measure of body fat based on height and weight that is commonly used to classify individuals into different weight categories. While BMI is not a direct measure of body fat percentage or distribution, it is widely used as a screening tool to identify individuals who may be at increased risk of various health conditions, including cardiovascular disease (CVD).

![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/33cd0ee9-ad8a-49ba-a134-8ba881b3c04a)

The above bar chart show the number of patients by BMI categories who have cardiovascular disease, according to the data around 36.84% of patients are Overweight this means they have the bmi between 25 and 29. Around 32.94% are in Obesity and 29.69% are in normal weight which means they have the bmi greater than 30, and 18.5 to 24 for normal weight respectively.

BMI is known to be associated with several risk factors for cardiovascular disease, including

* Hypertension
* Dyslipidemia
* Type 2 Diabetes
* Heart Failure
* Inflammation and Oxidative Stress

Overall, maintaining a healthy BMI through a balanced diet, regular physical activity, and lifestyle modifications is important for reducing the risk of cardiovascular disease and improving overall cardiovascular health. Individuals who are overweight or obese should work with healthcare professionals to develop personalized strategies for weight management and cardiovascular risk reduction

**Cholesterol**

Cholesterol plays a crucial role in the development of cardiovascular disease (CVD) due to its involvement in the formation of atherosclerotic plaque in the arteries

* Atherosclerosis: Cholesterol is a lipid (fat-like substance) that is transported in the bloodstream in particles called lipoproteins. Low-density lipoprotein (LDL) cholesterol, often referred to as "bad" cholesterol, can accumulate in the walls of arteries and contribute to the formation of atherosclerotic plaque. This plaque consists of cholesterol, fatty deposits, calcium, and other substances, and it narrows and stiffens the arteries, reducing blood flow to vital organs like the heart and brain. --  **_source chat GPT_**

![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/7fb1f48b-79f4-4943-8a3e-dddd42b3d6ab)

The pie chat illustrates the percentage of patients in different categories of cholesterol who have cardiovascular disease, Most of the patients have normal cholesterol i.e 66.14%. Normal cholesterol indicate that the cholesterol levels are within in healthy range, around 16.24% of the patients are in above normal category, this category suggests that cholesterol levels are higher than the recommended range and 17.62% are in well above normal category, this levels has a greater risk of developing heart disease or experiencing related health issues.

cholesterol management, including monitoring LDL cholesterol levels and maintaining a healthy balance of HDL cholesterol, is essential for reducing the risk of cardiovascular disease and its complications. Lifestyle modifications, such as a heart-healthy diet, regular physical activity, smoking cessation, and medication when necessary, can help manage cholesterol levels and lower the risk of CVD. Regular screening and monitoring of cholesterol levels are important components of cardiovascular disease prevention and management strategies.

**Age Distribution**

Let's see how cardiovascular disease changes with age.

![image](https://github.com/himanshu-004/Cardiovascular-Disease-Analysis/assets/81569893/c745ede9-eb71-4e6a-91ba-9212cd5bc37a)

The above line graph illustrates the information about number of patients having cardiovascular disease by different age groups.

patients who are in their mid 50s have higher chance of getting cardiovascular disease, According to the data their are around 3k to 4k patients who have cardiovascular disease at age between 56 to 58 and this range is higher in the graph. The patients who are in their 40s or in 30s are lesser in number when compare to patients who are in their 50s 

Their is gradual increase in the patients till the age of 58 having Cardiovascular disease, and their is sudden decrease in number after that who are at 60 and above.
