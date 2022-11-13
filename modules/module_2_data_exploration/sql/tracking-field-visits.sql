
-- Case Study - Tracking field visits

-- Query 1 
-- For each cluster, center and CO (community organiser)
-- 		1. Count the total number of pregnant women
-- 		2. Count the number of high risk pregnancies
-- 		3. Find the distribution of pregnant women by month of pregnancy

--1.1
SELECT clusterid, center, coid, count(*) AS totalPregnantWomen
	FROM public.case_anc_visit_reduced
	WHERE closed=FALSE
	GROUP BY clusterid, center, coid
	ORDER BY totalPregnantWomen DESC;

--1.2
SELECT clusterid, center, coid, count(*) AS totalPregnantWomen_HighRisk
	FROM public.case_anc_visit_reduced
	WHERE closed=FALSE AND high_risk_preg='Yes'
	GROUP BY clusterid, center, coid
	ORDER BY totalPregnantWomen_HighRisk DESC;
	
--1.3
SELECT clusterid, center, coid, pregnantmonth, 
	count(*) AS totalWomen
	FROM public.case_anc_visit_reduced
	WHERE closed=FALSE
	GROUP BY clusterid, center, coid, pregnantmonth
	ORDER BY pregnantmonth;
	
	
-- Query 2
-- Find the cluster, center and CO with the highest number of pregnancies in the sixth and seventh month
SELECT clusterid, center, coid, 
	count(*) AS PregnantWomen_month6_month7
	FROM public.case_anc_visit_reduced
	WHERE closed=FALSE AND pregnantmonth >=6 AND pregnantmonth <=7
	GROUP BY clusterid, center, coid
	ORDER BY PregnantWomen_month6_month7 DESC LIMIT 1;


-- Query 3
-- For all women in this group, find the total number of field visits
SELECT caseid, COUNT(caseid) AS totalVisits
	FROM form_anc_visit_reduced
	WHERE caseid IN 
		(
			SELECT id FROM case_anc_visit_reduced
		 	WHERE clusterid='03' AND center='02' AND coid='14'
		 	AND closed=FALSE AND pregnantmonth >=6 AND pregnantmonth <=7
		)
	GROUP BY caseid 
	ORDER BY totalVisits DESC;

-- Query 4
-- For all women in the above group, count the total number of visits per month
SELECT caseid, 
	TO_CHAR(anc_visit_date, 'YYYY-MM') as visitMonth, 
	COUNT(caseid) AS totalVisits
	FROM form_anc_visit_reduced
	WHERE caseid IN 
		(
			SELECT id FROM case_anc_visit_reduced
		 	WHERE clusterid='03' AND center='02' AND coid='14'
		 	AND closed=FALSE AND pregnantmonth >=6 AND pregnantmonth <=7
		)
	GROUP BY caseid, visitMonth
	ORDER BY caseid, visitmonth;


