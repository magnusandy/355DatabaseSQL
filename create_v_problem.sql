-- View to identify items which have duplicate entries for the current time period in the t_item_locations table
-- This is working to the new naming structure, for the old naming structure prefix all the attributes with ns_
CREATE VIEW v_problem 
AS 
SELECT DISTINCT 
	count(ilo_inumkey||ilo_ialphakey) AS duplicates, 
	ilo_inumkey , 
	ilo_ialphakey 
	FROM 
	t_item_locations 
	WHERE 
	(
		(ilo_ilodatetime_start < current_timestamp AND ilo_ilodatetime_end > current_timestamp) 
		OR 
		(ilo_ilodatetime_start < current_timestamp AND ilo_ilodatetime_end IS NULL)
	) 
	GROUP BY ilo_inumkey, ilo_ialphakey ORDER BY ilo_inumkey;
