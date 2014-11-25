-- created by Andrew Magnus 
-- Nov 10, 2014
--Database File for creation of Domains and the master database


--CLIENTS
CREATE TABLE ns_t_clients_temp (
	ns_cl_clname ns_clname NOT NULL,
	ns_cl_email ns_email,
	ns_cl_phonenum ns_phonenum,	
	--address
	ns_cl_buildingnum ns_buildingnum,
	ns_cl_buildingname ns_buildingname,
	ns_cl_streetname ns_streetname,
	ns_cl_city ns_city,
	ns_cl_country ns_country,
	ns_cl_region ns_region,
	ns_cl_postalcode ns_postalcode
);


--ITEMS
CREATE TABLE ns_t_items_temp (
	ns_i_inumkey ns_inumkey NOT NULL,
	ns_i_ialphakey ns_ialphakey NOT NULL,
	ns_i_museumkey ns_museumkey NOT NULL,
	ns_i_iname ns_iname NOT NULL,
	ns_i_iorigin ns_iorigin, 
	ns_i_iformat ns_iformat,
	ns_i_isubformat ns_isubformat,
	ns_i_ischool ns_ischool,
	ns_i_isubject ns_isubject,
	ns_i_icolor ns_icolor,
	ns_i_iinsurance ns_iinsurance NOT NULL,
	ns_i_iacquisitiondate ns_iacquisitiondate, --changed to be able to be null for potential works
	ns_i_icreationyear ns_icreationyear NOT NULL,
	ns_i_clname_owner ns_clname NOT NULL,
	ns_i_idescription ns_idescription NOT NULL,
	ns_i_itsvector ns_itsvector
);

-- ITEM CREATORS
CREATE TABLE ns_t_item_creators_temp(
	ns_cr_inumkey ns_inumkey NOT NULL,
	ns_cr_ialphakey ns_ialphakey NOT NULL,
	ns_cr_museumkey ns_museumkey NOT NULL,
	ns_cr_crname ns_crname NOT NULL
);

--MATERIALS
CREATE TABLE ns_t_materials_temp(
	ns_mat_matname ns_matname NOT NULL
);

--SUB COMPONENTS
CREATE TABLE ns_t_materials_subcomponents_temp(
	ns_matsub_matname ns_matname NOT NULL,
	ns_matsub_subcomponent ns_subcomponent NOT NULL
);

--ITEM MATERIALS
CREATE TABLE ns_t_item_materials_temp(
	ns_imat_inumkey ns_inumkey NOT NULL,
	ns_imat_ialphakey ns_ialphakey NOT NULL,
	ns_imat_museumkey ns_museumkey NOT NULL,
	ns_imat_matname ns_matname NOT NULL
);

--ITEM TRANSACTIONS
CREATE TABLE ns_t_item_transactions_temp(
	ns_it_inumkey ns_inumkey NOT NULL,
	ns_it_ialphakey ns_ialphakey NOT NULL,
	ns_it_museumkey ns_museumkey NOT NULL,
	ns_it_clname ns_clname NOT NULL,
	ns_it_ittype ns_ittype NOT NULL,
	ns_it_itdatetime_start ns_itdatetime NOT NULL,
	ns_it_itdatetime_end ns_itdatetime, --NULL IF ITS A SALE
	ns_it_itdatetime_returnby ns_itdatetime, --null if its not a loan
	ns_it_itgross ns_itgross NOT NULL
);

--LOCATIONS MAIN
CREATE TABLE ns_t_locations_temp (
	ns_loc_locname ns_locname NOT NULL,
	ns_loc_museumkey ns_museumkey NOT NULL,
	ns_loc_loctype ns_loctype NOT NULL
);

--INTERNAL LOCATIONS
CREATE TABLE ns_t_internal_locations_temp (
	ns_iloc_locname ns_locname NOT NULL,
	ns_iloc_museumkey ns_museumkey NOT NULL,
	ns_iloc_numitems_min ns_numitems NOT NULL,
	ns_iloc_numitems_max ns_numitems NOT NULL,
	ns_iloc_locdimensionmetres_height ns_locdimensionmetres NOT NULL,
	ns_iloc_locdimensionmetres_length ns_locdimensionmetres NOT NULL,
	ns_iloc_locdimensionmetres_width ns_locdimensionmetres NOT NULL,
	ns_iloc_loccreationdate ns_loccreationdate
);

--EXTERNAL LOCATIONS
CREATE TABLE ns_t_external_locations_temp (
	ns_eloc_locname ns_locname NOT NULL,
	ns_eloc_museumkey ns_museumkey NOT NULL,
	ns_eloc_sponsor ns_sponsor NOT NULL,
	ns_eloc_security ns_security NOT NULL,
	ns_eloc_elocdate_start ns_elocdate NOT NULL,
	ns_eloc_elocdate_end ns_elocdate NOT NULL,
	ns_eloc_iinsurance_total ns_iinsurance, -- NOT SURE IF THIS SHOULD BE HERE OR MAYBE IN EXHIBITIONS? IDK its all calculatable anyway right?
	--address NOT SURE IF THESE SHOULD BE ALL NOT NULL OR MAYBE JUST SOME
	ns_eloc_buildingnum ns_buildingnum,
	ns_eloc_buildingname ns_buildingname,
	ns_eloc_streetname ns_streetname,
	ns_eloc_city ns_city,
	ns_eloc_country ns_country,
	ns_eloc_region ns_region,
	ns_eloc_postalcode ns_postalcode
);

--ITEM LOCATIONS
CREATE TABLE ns_t_item_locations_temp(
	ns_ilo_inumkey ns_inumkey NOT NULL,
	ns_ilo_ialphakey ns_ialphakey NOT NULL,
	ns_ilo_museumkey_item ns_museumkey NOT NULL,
	ns_ilo_locname ns_locname NOT NULL,
	ns_ilo_museumkey_location ns_museumkey NOT NULL,
	ns_ilo_ilodatetime_start ns_ilodatetime NOT NULL,
	ns_ilo_ilodatetime_end ns_ilodatetime
);


--LOCATION DOORS
CREATE TABLE ns_t_location_doors_temp(
	ns_lodor_locname_entrance ns_locname NOT NULL,
	ns_lodor_museumkey_entrance ns_museumkey NOT NULL,
	ns_lodor_locname_exit ns_locname NOT NULL,
	ns_lodor_museumkey_exit ns_museumkey NOT NULL
);

--EXHIBITIONS 
CREATE TABLE ns_t_exhibitions_temp(
	ns_ex_ename ns_ename NOT NULL,
	ns_ex_showdate_start ns_showdate NOT NULL,
	ns_ex_showdate_end ns_showdate NOT NULL,
	ns_ex_edescription ns_edescription NOT NULL
);


--EXHIBITION ITEMS
CREATE TABLE ns_t_exhibition_items_temp(
	ns_exi_inumkey ns_inumkey NOT NULL,
	ns_exi_ialphakey ns_ialphakey NOT NULL,
	ns_exi_museumkey ns_museumkey NOT NULL,
	ns_exi_ename ns_ename NOT NULL,
	ns_exi_showdate_start ns_showdate NOT NULL,
	ns_exi_exidate_start ns_exidate NOT NULL,
	ns_exi_exidate_end ns_exidate NOT NULL
);

--EXHIBITION LOCATIONS
CREATE TABLE ns_t_exhibition_locations_temp(
	ns_exl_ename ns_ename NOT NULL,
	ns_exl_showdate_start ns_showdate NOT NULL,
	ns_exl_locname ns_locname NOT NULL,
	ns_exl_museumkey ns_museumkey NOT NULL,
	ns_exl_exldate_start ns_exldate NOT NULL,
	ns_exl_exldate_end ns_exldate NOT NULL
);

--VIEWS GO HERE