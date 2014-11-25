-- VIEW CREATION FOR ALL TABLES
--CLIENTS
CREATE VIEW ns_v_clients AS SELECT 
	ns_cl_clname,
	ns_cl_email,
	ns_cl_phonenum,	
	ns_cl_buildingnum,
	ns_cl_buildingname,
	ns_cl_streetname,
	ns_cl_city,
	ns_cl_country,
	ns_cl_region,
	ns_cl_postalcode
	FROM ns_t_clients
;


--ITEMS
CREATE VIEW ns_v_items AS SELECT 
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_clientkey,
	ns_i_iname,
	ns_i_iorigin, 
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_idescription,
	ns_i_itsvector
	FROM ns_t_items
;

-- ITEM CREATORS
CREATE VIEW ns_v_item_creators AS SELECT 
	ns_cr_inumkey,
	ns_cr_ialphakey,
	ns_cr_clientkey,
	ns_cr_crname
	FROM ns_t_item_creators
;

--MATERIALS
CREATE VIEW ns_v_materials AS SELECT 
	ns_mat_matname
	FROM ns_t_materials
;

--SUB COMPONENTS
CREATE VIEW ns_v_materials_subcomponents AS SELECT 
	ns_matsub_matname,
	ns_matsub_subcomponent
	FROM ns_t_materials_subcomponents
;

--ITEM MATERIALS
CREATE VIEW ns_v_item_materials AS SELECT 
	ns_imat_inumkey,
	ns_imat_ialphakey,
	ns_imat_clientkey,
	ns_imat_matname
	FROM ns_t_item_materials
;

--ITEM TRANSACTIONS
CREATE VIEW ns_v_item_transactions AS SELECT 
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_clientkey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross
	FROM ns_t_item_transactions
;

--LOCATIONS
CREATE VIEW ns_v_locations AS SELECT 
	ns_loc_locname,
	ns_loc_clientkey,
	ns_loc_loctype,
	ns_loc_numitems_min,
	ns_loc_numitems_max,
	ns_loc_locdimensionmetres_height,
	ns_loc_locdimensionmetres_length,
	ns_loc_locdimensionmetres_width,
	ns_loc_loccreationdate,
	ns_loc_elocdate_start,
	ns_loc_elocdate_end,
	ns_loc_iinsurance_total
	FROM ns_t_locations;
;

--ITEM LOCATIONS
CREATE VIEW ns_v_item_locations AS SELECT 
	ns_ilo_inumkey,
	ns_ilo_ialphakey,
	ns_ilo_clientkey_item,
	ns_ilo_locname,
	ns_ilo_clientkey_location,
	ns_ilo_ilodatetime_start,
	ns_ilo_ilodatetime_end
	FROM ns_t_item_locations
;


--LOCATION DOORS
CREATE VIEW ns_v_location_doors AS SELECT 
	ns_lodor_locname_entrance,
	ns_lodor_clientkey_entrance,
	ns_lodor_locname_exit,
	ns_lodor_clientkey_exit
	FROM ns_t_location_doors
;

--EXHIBITIONS 
CREATE VIEW ns_v_exhibitions AS SELECT 
	ns_ex_ename,
	ns_ex_showdate_start,
	ns_ex_showdate_end,
	ns_ex_edescription
	FROM ns_t_exhibitions
;


--EXHIBITION ITEMS
CREATE VIEW ns_v_exhibition_items AS SELECT 
	ns_exi_inumkey,
	ns_exi_ialphakey,
	ns_exi_clientkey,
	ns_exi_ename,
	ns_exi_showdate_start,
	ns_exi_exidate_start,
	ns_exi_exidate_end
	FROM ns_t_exhibition_items
;

--EXHIBITION LOCATIONS
CREATE VIEW ns_v_exhibition_locations AS SELECT 
	ns_exl_ename,
	ns_exl_showdate_start,
	ns_exl_locname,
	ns_exl_clientkey,
	ns_exl_exldate_start,
	ns_exl_exldate_end,
	ns_exl_security
	FROM ns_t_exhibition_locations
;

-- ITEM COLORS
CREATE VIEW ns_v_item_colors AS SELECT
	ns_icol_inumkey,
	ns_icol_ialphakey,
	ns_icol_clientkey,
	ns_icol_icolor
	FROM ns_t_item_colors
;

-- VIEW CREATION FROM ASSIGNMENTS AND OTHER USEFUL VIEWS

-- current item location
CREATE VIEW ns_v_current_item_location AS SELECT
	ns_ilo_inumkey,
	ns_ilo_ialphakey,
	ns_ilo_clientkey_item,
	ns_ilo_locname,
	ns_ilo_clientkey_location,
	ns_ilo_ilodatetime_start,
	ns_ilo_ilodatetime_end
	FROM
	ns_t_item_locations
	WHERE 
	ns_ilo_ilodatetime_start <= current_timestamp AND 
	(ns_ilo_ilodatetime_end >= current_timestamp OR ns_ilo_ilodatetime_end IS NULL)
;
	
-- currently in storage
CREATE VIEW ns_v_current_items_in_storage AS SELECT
	ns_ilo_inumkey,
	ns_ilo_ialphakey,
	ns_ilo_clientkey_item,
	ns_ilo_locname,
	ns_ilo_clientkey_location,
	ns_ilo_ilodatetime_start,
	ns_ilo_ilodatetime_end
	FROM
	ns_v_current_item_location
	WHERE
	ns_ilo_locname = 'Storage' OR ns_ilo_locname = 'storage'
;
-- currently not in storage
CREATE VIEW ns_v_current_items_not_in_storage AS SELECT
	ns_ilo_inumkey,
	ns_ilo_ialphakey,
	ns_ilo_clientkey_item,
	ns_ilo_locname,
	ns_ilo_clientkey_location,
	ns_ilo_ilodatetime_start,
	ns_ilo_ilodatetime_end
	FROM
	ns_v_current_item_location
	WHERE
	ns_ilo_locname != 'Storage' AND
	ns_ilo_locname != 'storage'
;

--current exhibitions
CREATE VIEW ns_v_current_exhibitions AS SELECT 
	ns_ex_ename,
	ns_ex_showdate_start,
	ns_ex_showdate_end,
	ns_ex_edescription
	FROM
	ns_t_exhibitions
	WHERE 
	ns_ex_showdate_start <= current_timestamp AND 
	ns_ex_showdate_end >= current_timestamp
;
	
-- finished exhibitions
CREATE VIEW ns_v_past_exhibitions AS SELECT 
	ns_ex_ename,
	ns_ex_showdate_start,
	ns_ex_showdate_end,
	ns_ex_edescription
	FROM
	ns_t_exhibitions
	WHERE  
	ns_ex_showdate_end < current_timestamp
;
-- planned exhibitions
CREATE VIEW ns_v_future_exhibitions AS SELECT 
	ns_ex_ename,
	ns_ex_showdate_start,
	ns_ex_showdate_end,
	ns_ex_edescription
	FROM
	ns_t_exhibitions
	WHERE 
	ns_ex_showdate_start > current_timestamp
;

-- key, name, insurance of works in currently storage (also not in storage)
-- name, desc, location, numworks of all exhititions (public_current, public_past, public_future)
-- info public on items in exhibitions sorted by exhibition and name of the work (current, future, past)
-- listing of works SORTED by when they are available for use in a new exhibition and by classification ()
-- additional works that could be added to an exhibition just name of exhibition and number you could add (just make for all exhibitions)
--tsvector stuff?
-- current and future exhibitions, name, dates, max capacity, current num of works
-- query that lists locations a work is/was/will be in between two dates
-- all works found in an exhibition between two dates including, name of work, dates, 
-- all the exhibitions that use a location between two dates
-- all borrowed, purchased, sold, rented, etc items
-- items made out of X material


