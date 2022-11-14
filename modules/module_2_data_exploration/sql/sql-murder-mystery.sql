-- SQL Murder Mystery 
-- https://mystery.knightlab.com/#experienced

-- SQL queries

/*

A crime has taken place and the detective needs your help. 

The detective gave you the crime scene report, but you somehow 
lost it. You vaguely remember that the crime was a murder
that occurred sometime on Jan.15, 2018 and that it took place 
in SQL City. Start by retrieving the corresponding crime scene 
report from the police department’s database.

*/

-- Check the crime_scene_report table to find more details

SELECT * FROM crime_scene_report 
  WHERE date='20180115' 
    AND city='SQL City'
    AND type LIKE '%murder%';

/*
Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".
*/

-- Check the person (witness) table

SELECT * FROM person
  WHERE address_street_name LIKE '%Northwestern%' 
    OR address_street_name LIKE '%Franklin Ave%'
  ORDER BY address_street_name, address_number DESC;

/*  
16371	Annabel Miller	490173	103	Franklin Ave	318771143
14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949
*/

-- Becase they are witnesses, we can check the interview table 
-- to get more details 

SELECT * FROM interview 
  WHERE person_id = 16371 
    OR person_id=14887;

/*
14887	I heard a gunshot and then saw a man run out. 
He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". 
Only gold members have those bags. The man got into a car with 
a plate that included "H42W".


16371	I saw the murder happen, and I recognized the killer 
from my gym when I was working out last week on January the 9th.
*/

-- Get gym membership details about the accused

SELECT * FROM get_fit_now_member
  WHERE id LIKE '48Z%';

/*
This returns two records

48Z7A	28819	Joe Germuska	20160305	gold
48Z55	67318	Jeremy Bowers	20160101	gold
*/

-- Get the person details, especially the name, as per the 
-- license number 

SELECT * FROM person WHERE 
  license_id IN 
    (SELECT id FROM drivers_license
        WHERE plate_number LIKE '%H42W%'
    );
  
-- This returns three rows, one of which matches the name above

-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279
    
-- To confirm, check if this person was in the gym 
-- on Jan 9th (as per the second witness)

SELECT * FROM get_fit_now_check_in
  WHERE membership_id='48Z55';

-- 48Z55	20180109	1530	1700

-- This confirms that the name of the murderer is Jeremy Bowers

/*
Congrats, you found the murderer! But wait, there's more... 
If you think you're up for a challenge, try querying the 
interview transcript of the murderer to find the real villain 
behind this crime. If you feel especially confident in your SQL 
skills, try to complete this final step with no more than 
2 queries. Use this same INSERT statement with your 
new suspect to check your answer.
*/

SELECT * FROM interview
  WHERE person_id=67318;

/*
I was hired by a woman with a lot of money. I don't know her name 
but I know she's around 5'5" (65") or 5'7" (67"). She has red hair 
and she drives a Tesla Model S. I know that she attended the 
SQL Symphony Concert 3 times in December 2017.
*/


SELECT person.name, person.id
	FROM person JOIN drivers_license 
		ON person.license_id = drivers_license.id
	WHERE drivers_license.gender LIKE '%female%'
    	AND drivers_license.height>= 65 
    	AND drivers_license.height<= 67
    	AND drivers_license.car_make LIKE '%Tesla%'
  		AND person.id IN (
			SELECT person_id FROM facebook_event_checkin
			WHERE facebook_event_checkin.date>=20171201 
				AND facebook_event_checkin.date<=20171231 
				AND event_name LIKE '%SQL Symphony%'
			GROUP BY person_id 
			HAVING count(person_id) >= 3
)

-- Miranda Priestly	99716

/*
Congrats, you found the brains behind the murder! 
Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
*/