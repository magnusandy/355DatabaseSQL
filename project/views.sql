-- VIEW CREATION FOR ALL TABLES
--CLIENTS
CREATE VIEW v_clients AS SELECT 
	cl_clname,
	cl_email,
	cl_phonenum,	
	cl_buildingnum,
	cl_buildingname,
	cl_streetname,
	cl_city,
	cl_country,
	cl_region,
	cl_postalcode
	FROM t_clients
;


--ITEMS
CREATE VIEW v_items AS SELECT 
	i_inumkey,
	i_ialphakey,
	i_clientkey,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iinsurance,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription,
	i_itsvector
	FROM t_items
;

-- ITEM CREATORS
CREATE VIEW v_item_creators AS SELECT 
	cr_inumkey,
	cr_ialphakey,
	cr_clientkey,
	cr_crname
	FROM t_item_creators
;

--MATERIALS
CREATE VIEW v_materials AS SELECT 
	mat_matname
	FROM t_materials
;

--SUB COMPONENTS
CREATE VIEW v_materials_subcomponents AS SELECT 
	matsub_matname,
	matsub_subcomponent
	FROM t_materials_subcomponents
;

--ITEM MATERIALS
CREATE VIEW v_item_materials AS SELECT 
	imat_inumkey,
	imat_ialphakey,
	imat_clientkey,
	imat_matname
	FROM t_item_materials
;

--ITEM TRANSACTIONS
CREATE VIEW v_item_transactions AS SELECT 
	it_inumkey,
	it_ialphakey,
	it_clientkey,
	it_clname,
	it_ittype,
	it_itdatetime_start,
	it_itdatetime_end,
	it_itdatetime_returnby,
	it_itgross
	FROM t_item_transactions
;

--LOCATIONS
CREATE VIEW v_locations AS SELECT 
	loc_locname,
	loc_clientkey,
	loc_loctype,
	loc_numitems_min,
	loc_numitems_max,
	loc_locdimensionmetres_height,
	loc_locdimensionmetres_length,
	loc_locdimensionmetres_width,
	loc_loccreationdate,
	loc_elocdate_start,
	loc_elocdate_end,
	loc_iinsurance_total
	FROM t_locations;
;

--ITEM LOCATIONS
CREATE VIEW v_item_locations AS SELECT 
	ilo_inumkey,
	ilo_ialphakey,
	ilo_clientkey_item,
	ilo_locname,
	ilo_clientkey_location,
	ilo_ilodatetime_start,
	ilo_ilodatetime_end
	FROM t_item_locations
;


--LOCATION DOORS
CREATE VIEW v_location_doors AS SELECT 
	lodor_locname_entrance,
	lodor_clientkey_entrance,
	lodor_locname_exit,
	lodor_clientkey_exit
	FROM t_location_doors
;

--EXHIBITIONS 
CREATE VIEW v_exhibitions AS SELECT 
	ex_ename,
	ex_showdate_start,
	ex_showdate_end,
	ex_edescription
	FROM t_exhibitions
;


--EXHIBITION ITEMS
CREATE VIEW v_exhibition_items AS SELECT 
	exi_inumkey,
	exi_ialphakey,
	exi_clientkey,
	exi_ename,
	exi_showdate_start,
	exi_exidate_start,
	exi_exidate_end
	FROM t_exhibition_items
;

--EXHIBITION LOCATIONS
CREATE VIEW v_exhibition_locations AS SELECT 
	exl_ename,
	exl_showdate_start,
	exl_locname,
	exl_clientkey,
	exl_exldate_start,
	exl_exldate_end,
	exl_security
	FROM t_exhibition_locations
;

-- ITEM COLORS
CREATE VIEW v_item_colors AS SELECT
	icol_inumkey,
	icol_ialphakey,
	icol_clientkey,
	icol_icolor
	FROM t_item_colors
;

-- VIEW CREATION FROM ASSIGNMENTS AND OTHER USEFUL VIEWS

-- current item location
CREATE VIEW v_current_item_location AS SELECT
	ilo_inumkey,
	ilo_ialphakey,
	ilo_clientkey_item,
	ilo_locname,
	ilo_clientkey_location,
	ilo_ilodatetime_start,
	ilo_ilodatetime_end
	FROM
	t_item_locations
	WHERE 
	ilo_ilodatetime_start <= current_timestamp AND 
	(ilo_ilodatetime_end >= current_timestamp OR ilo_ilodatetime_end IS NULL)
;
	
-- currently in storage
CREATE VIEW v_current_items_in_storage AS SELECT
	ilo_inumkey,
	ilo_ialphakey,
	ilo_clientkey_item,
	ilo_locname,
	ilo_clientkey_location,
	ilo_ilodatetime_start,
	ilo_ilodatetime_end
	FROM
	v_current_item_location
	WHERE
	ilo_locname = 'Storage' OR ilo_locname = 'storage'
;
-- currently not in storage
CREATE VIEW v_current_items_not_in_storage AS SELECT
	ilo_inumkey,
	ilo_ialphakey,
	ilo_clientkey_item,
	ilo_locname,
	ilo_clientkey_location,
	ilo_ilodatetime_start,
	ilo_ilodatetime_end
	FROM
	v_current_item_location
	WHERE
	ilo_locname != 'Storage' AND
	ilo_locname != 'storage'
;

--current exhibitions
CREATE VIEW v_current_exhibitions AS SELECT 
	ex_ename,
	ex_showdate_start,
	ex_showdate_end,
	ex_edescription
	FROM
	t_exhibitions
	WHERE 
	ex_showdate_start <= current_timestamp AND 
	ex_showdate_end >= current_timestamp
;
	
-- finished exhibitions
CREATE VIEW v_past_exhibitions AS SELECT 
	ex_ename,
	ex_showdate_start,
	ex_showdate_end,
	ex_edescription
	FROM
	t_exhibitions
	WHERE  
	ex_showdate_end < current_timestamp
;
-- planned exhibitions
CREATE VIEW v_future_exhibitions AS SELECT 
	ex_ename,
	ex_showdate_start,
	ex_showdate_end,
	ex_edescription
	FROM
	t_exhibitions
	WHERE 
	ex_showdate_start > current_timestamp
;
-- view used to debug the item locations table
CREATE VIEW v_problem AS SELECT
	ilo_ialphakey,
	ilo_inumkey,
	count(ilo_inumkey)
	FROM
	v_current_item_location
	GROUP BY
	ilo_inumkey,
	ilo_ialphakey
	HAVING
	(Count(ilo_inumkey) > 1)
;

-- key, name, insurance of works in currently storage (also not in storage)
CREATE VIEW v_current_insurance_storage AS SELECT
	i_iname,
	i_inumkey, 
	i_ialphakey,
	i_clientkey,
	i_iinsurance
	FROM 
	v_items,
	v_current_items_in_storage
	WHERE 
	i_inumkey = ilo_inumkey AND 
	i_ialphakey = ilo_ialphakey AND 
	i_clientkey = ilo_clientkey_item
;

-- key, name, insurance of works currently not in storage
CREATE VIEW v_current_insurance_not_storage AS SELECT
	i_iname,
	i_inumkey, 
	i_ialphakey,
	i_clientkey,
	i_iinsurance
	FROM 
	v_items,
	v_current_items_not_in_storage
	WHERE 
	i_inumkey = ilo_inumkey AND 
	i_ialphakey = ilo_ialphakey AND 
	i_clientkey = ilo_clientkey_item
;
-- current number of items in all exhibitions
CREATE VIEW v_numitems_in_exhibitions AS SELECT
	exi_ename AS showname,
	exi_showdate_start AS showstart,
	count(exi_ename) AS numitems
	FROM
	t_exhibition_items
	GROUP BY
	exi_ename,
	exi_showdate_start
;

-- name, desc, location, numworks of all exhititions (public_current, public_past, public_future)
CREATE VIEW v_public_data_exhibitions AS SELECT
	ex_ename,
	ex_showdate_start,
	exl_locname,
	exl_clientkey,
	numitems,
	ex_edescription
	FROM
	v_exhibitions,
	v_exhibition_locations,
	v_numitems_in_exhibitions
	WHERE
	ex_ename = exl_ename AND ex_ename = showname AND
	ex_showdate_start = exl_showdate_start AND ex_showdate_start = showstart
;
	
CREATE VIEW v_public_data_past_exhibitions AS SELECT
	ex_ename,
	ex_showdate_start,
	exl_locname,
	exl_clientkey,
	numitems,
	ex_edescription
	FROM
	v_past_exhibitions,
	v_exhibition_locations,
	v_numitems_in_exhibitions
	WHERE
	ex_ename = exl_ename AND ex_ename = showname AND
	ex_showdate_start = exl_showdate_start AND ex_showdate_start = showstart
;

CREATE VIEW v_public_data_current_exhibitions AS SELECT
	ex_ename,
	ex_showdate_start,
	exl_locname,
	exl_clientkey,
	numitems,
	ex_edescription
	FROM
	v_current_exhibitions,
	v_exhibition_locations,
	v_numitems_in_exhibitions
	WHERE
	ex_ename = exl_ename AND ex_ename = showname AND
	ex_showdate_start = exl_showdate_start AND ex_showdate_start = showstart
;

CREATE VIEW v_public_data_future_exhibitions AS SELECT
	ex_ename,
	ex_showdate_start,
	exl_locname,
	exl_clientkey,
	numitems,
	ex_edescription
	FROM
	v_future_exhibitions,
	v_exhibition_locations,
	v_numitems_in_exhibitions
	WHERE
	ex_ename = exl_ename AND ex_ename = showname AND
	ex_showdate_start = exl_showdate_start AND ex_showdate_start = showstart
;
	
--public info on all works in the items table
CREATE VIEW v_public_data_items AS SELECT
	i_inumkey,
	i_ialphakey,
	i_clientkey,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription
	FROM
	v_items
;

-- info public on items in exhibitions sorted by exhibition and name of the work (current, future, past)
CREATE VIEW v_public_data_items_in_exhibitions AS SELECT
    exi_ename,
	exi_showdate_start,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription
	FROM
	v_exhibition_items,
	v_public_data_items
	WHERE
	exi_ialphakey = i_ialphakey AND
	exi_inumkey = i_inumkey AND 
	exi_clientkey = i_clientkey
	ORDER BY 
	exi_ename,
	exi_showdate_start,
	i_iname
;

CREATE VIEW v_public_data_items_in_past_exhibitions AS SELECT
    exi_ename,
	exi_showdate_start,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription
	FROM 
	v_public_data_items_in_exhibitions,
	v_past_exhibitions
	WHERE
	exi_ename = ex_ename AND 
	exi_showdate_start = ex_showdate_start
;

CREATE VIEW v_public_data_items_in_current_exhibitions AS SELECT
    exi_ename,
	exi_showdate_start,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription
	FROM 
	v_public_data_items_in_exhibitions,
	v_current_exhibitions
	WHERE
	exi_ename = ex_ename AND 
	exi_showdate_start = ex_showdate_start
;

CREATE VIEW v_public_data_items_in_future_exhibitions AS SELECT
    exi_ename,
	exi_showdate_start,
	i_iname,
	i_iorigin, 
	i_iformat,
	i_isubformat,
	i_ischool,
	i_isubject,
	i_iacquisitiondate,
	i_icreationyear,
	i_idescription
	FROM 
	v_public_data_items_in_exhibitions,
	v_future_exhibitions
	WHERE
	exi_ename = ex_ename AND 
	exi_showdate_start = ex_showdate_start
;
	
-- listing of works SORTED by when they are available for use in a new exhibition and by classification ()
CREATE VIEW v_item_availability AS SELECT
	i_iname,
	i_inumkey,
	i_ialphakey,
	i_clientkey,
	ilo_ilodatetime_end
	FROM
	v_items,
	v_current_items_not_in_storage
	WHERE 
	i_ialphakey = ilo_ialphakey AND
	i_inumkey = ilo_inumkey AND 
	i_clientkey = ilo_clientkey_item
;

	
-- additional works that could be added to an exhibition just name of exhibition and number you could add (just make for all exhibitions)
CREATE VIEW v_space_available_in_exhibitions AS SELECT
	ex_ename,
	ex_showdate_start,
	exl_locname,
	exl_clientkey,
	numitems as current_numitems,
	loc_numitems_max - numitems as space_available
	FROM 
	v_public_data_exhibitions,
	v_locations
	WHERE
	exl_locname = loc_locname AND
	exl_clientkey = loc_clientkey AND 
	loc_numitems_max IS NOT NULL
	ORDER BY 
	ex_ename
;

-- current and future exhibitions, name, dates, max capacity, current num of works
	--pretty much the same as v_space_available_in_exhibitions

-- query that lists locations a work is/was/will be in between two dates
	--some kind of dbvisualizer scripts
-- all works found in an exhibition between two dates including, name of work, dates, 
	--some kind of dbvisualizer scripts
-- all the exhibitions that use a location between two dates
	--some kind of dbvisualizer scripts

-- all borrowed, purchased, sold, rented, etc items
CREATE VIEW v_borrowed_item_info AS SELECT
	it_inumkey,
	it_ialphakey,
	it_clientkey,
	i_iname,
	it_itdatetime_start,
	it_itdatetime_end,
	it_itdatetime_returnby
	FROM 
	v_item_transactions,
	v_items
	WHERE
	it_ialphakey = i_ialphakey AND
	it_inumkey = i_inumkey AND 
	it_clientkey = i_clientkey AND 
	it_ittype = 'Borrow'
;

CREATE VIEW v_Loaned_item_info AS SELECT
	it_inumkey,
	it_ialphakey,
	it_clientkey,
	i_iname,
	it_itdatetime_start,
	it_itdatetime_end,
	it_itdatetime_returnby
	FROM 
	v_item_transactions,
	v_items
	WHERE
	it_ialphakey = i_ialphakey AND
	it_inumkey = i_inumkey AND 
	it_clientkey = i_clientkey AND 
	it_ittype = 'Loan'
;

CREATE VIEW v_purchased_item_info AS SELECT
	it_inumkey,
	it_ialphakey,
	it_clientkey,
	i_iname,
	it_itdatetime_start
	FROM 
	v_item_transactions,
	v_items
	WHERE
	it_ialphakey = i_ialphakey AND
	it_inumkey = i_inumkey AND 
	it_clientkey = i_clientkey AND 
	it_ittype = 'Purchase'
;

CREATE VIEW v_sold_item_info AS SELECT
	it_inumkey,
	it_ialphakey,
	it_clientkey,
	i_iname,
	it_itdatetime_start
	FROM 
	v_item_transactions,
	v_items
	WHERE
	it_ialphakey = i_ialphakey AND
	it_inumkey = i_inumkey AND 
	it_clientkey = i_clientkey AND 
	it_ittype = 'Sale'
;
	

