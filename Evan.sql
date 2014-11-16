BEGIN;
\i master.sql



update works set wrk_subtype = 'Military' where wrk_subtype = 'Wars';
update works set wrk_subtype = 'Figure' where wrk_subtype = 'Figures';
update works set wrk_type = 'Tool' where wrk_type = 'Tools';
update works set wrk_subtype = 'Container' where wrk_subtype = 'Containment';
update works set wrk_subtype = 'Container' where wrk_subtype = 'Vessel';


--First, we need the clients table so we can reference the client in the works.
--A big problem with this is that we need to extract data from the address field
--and the easiest way to do it is just rewrite it.
INSERT INTO ns_t_clients(
		ns_cl_clname,
		ns_cl_phonenum,
		ns_cl_buildingnum,
		ns_cl_streetname)
	SELECT
		own_name,
		own_phone,
		(substring(own_address FROM '^[0-9]+')),
		(substring(own_address FROM '[A-Za-z]+'))
	FROM
		owners_table;
--Insert all items in the table, then we'll worry about all the format
--and everything else.

INSERT INTO ns_t_items (ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey, ns_i_iname, ns_i_iorigin, ns_i_iformat, ns_i_isubformat, ns_i_ischool, ns_i_isubject, ns_i_icolor, ns_i_iinsurance, ns_i_iacquisitiondate, ns_i_icreationyear, ns_i_clname_owner, ns_i_idescription, ns_i_itsvector)
select wrk_numid, wrk_charid, 'Evan', wrk_name, NULL, NULL, NULL, NULL, NULL, NULL, wrk_insurance, wrk_acquistion, wrk_creation, wrk_ownername, wrk_desc, NULL from works;

--Update the format for all the works, and subformats and other 'types' that are more defined.
UPDATE ns_t_items SET ns_i_iformat = works.wrk_type from works where works.wrk_numid = ns_i_inumkey and (works.wrk_type = 'Meteorite' OR works.wrk_type = 'Crystal' OR works.wrk_type = 'Mineral' OR works.wrk_type = 'Gem' OR works.wrk_type = 'Tool' OR works.wrk_type = 'Ore' OR works.wrk_type = 'Jewelry' OR works.wrk_type = 'Mineral Carving' OR works.wrk_type = 'Bones' OR works.wrk_type = 'Container' OR works.wrk_type = 'Rock');

UPDATE ns_t_items SET ns_i_isubformat = works.wrk_subtype from works where works.wrk_numid = ns_i_inumkey and (works.wrk_subtype = 'Coin' OR works.wrk_subtype = 'Axes' OR works.wrk_subtype = 'Mirror' OR works.wrk_subtype = 'Knives' OR works.wrk_subtype = 'Inscriptions' OR works.wrk_subtype = 'Spears' OR works.wrk_subtype = 'Medal' OR works.wrk_subtype = 'Carrier' OR works.wrk_subtype = 'Weapon' OR works.wrk_subtype = 'Discs' OR works.wrk_subtype = 'Brooch' OR works.wrk_subtype = 'Armor' OR works.wrk_subtype = 'Plaque' OR works.wrk_subtype = 'Clasp' OR works.wrk_subtype = 'Horn' OR works.wrk_subtype = 'Container' OR works.wrk_subtype = 'Ring' OR works.wrk_subtype = 'Pendant' OR works.wrk_subtype = 'Scraper' OR works.wrk_subtype = 'Earring' OR works.wrk_subtype = 'Necklace' OR works.wrk_subtype = 'Figure' OR works.wrk_subtype = 'Pocket' OR works.wrk_subtype = 'Table' OR works.wrk_subtype = 'Basket' OR works.wrk_subtype = 'Metamorphic' OR works.wrk_subtype = 'Sedimentary' OR works.wrk_subtype = 'Igneous');
UPDATE ns_t_items set ns_i_iorigin = 'Mayan', ns_i_isubformat = 'Pendant' where ns_i_inumkey = 96615 and ns_i_ialphakey = 'maya' and ns_i_museumkey = 'Evan';
UPDATE ns_t_items SET ns_i_isubject = works.wrk_subtype from works where works.wrk_numid = ns_i_inumkey and (works.wrk_subtype = 'Military' OR works.wrk_subtype = 'Imperial');
UPDATE ns_t_items SET ns_i_isubject = works.wrk_type from works where works.wrk_numid = ns_i_inumkey and (works.wrk_type = 'Conflict' OR works.wrk_type = 'Ceremony');
UPDATE ns_t_items set ns_i_iorigin = 'Roman', ns_i_isubformat = 'Pendant' where ns_i_inumkey = 95020 and ns_i_ialphakey = 'roma' and ns_i_museumkey = 'Evan';


--select ns_i_inumkey, ns_i_iformat, ns_i_isubformat, ns_i_isubject from ns_t_items order by ns_i_inumkey;
--Minor problems with specific values for the types. Some subtypes where actually types, and their subtypes
--were actually origins. Fixed that.


INSERT INTO ns_t_item_creators (ns_cr_inumkey, ns_cr_ialphakey, ns_cr_museumkey, ns_cr_crname)
SELECT wrk_numid, wrk_charid, 'Evan', wrk_donate from works;

--Many duplicate materials, and submaterials in this table. Fixed by editing the
--table to remove all submaterials.
INSERT INTO ns_t_materials (ns_mat_matname)
select distinct mt_material from works_materials;

--select * from ns_t_materials;

--Now insert into sub materials.
INSERT INTO ns_t_materials_subcomponents (ns_matsub_matname, ns_matsub_subcomponent)
SELECT smt_mainmat, smt_submat from subMaterial;

INSERT INTO ns_t_item_materials (ns_imat_inumkey, ns_imat_ialphakey, ns_imat_museumkey, ns_imat_matname)
SELECT mt_numid, mt_charid, 'Evan', mt_material from works_materials;

--Insert in exhibitions right before locations so we can reference dates.
INSERT INTO ns_t_exhibitions(ns_ex_ename, ns_ex_showdate_start, ns_ex_showdate_end, ns_ex_edescription)
SELECT exn_name, exn_start, exn_end, exn_desc 
FROM exhibition;


--Locations, main area. Start with internal.
INSERT INTO ns_t_locations (ns_loc_locname, ns_loc_museumkey, ns_loc_loctype)
SELECT lct_location, 'Evan', 'Internal' from locationareas;
INSERT INTO ns_t_locations (ns_loc_locname, ns_loc_museumkey, ns_loc_loctype)
SELECT trx_location, 'Evan', 'External' from travelingexhibition 
WHERE (trx_location <> 'Storage' and trx_location <> 'Transit');
--Now update the last two, on Loan and on travel.
UPDATE ns_t_locations SET ns_loc_loctype = 'External' where ns_loc_locname = 'Travel' or ns_loc_locname = 'On Loan';

--Work on internal locations now.
INSERT INTO ns_t_internal_locations (
		ns_iloc_locname,
		ns_iloc_museumkey,
		ns_iloc_numitems_min,
		ns_iloc_numitems_max,
		ns_iloc_locdimensionmetres_height,
		ns_iloc_locdimensionmetres_length,
		ns_iloc_locdimensionmetres_width)
	SELECT
		lct_location,
		'Evan',
		lct_minworks,
		lct_maxworks,
		lct_height,
		lct_width,
		lct_length
	FROM
		locationareas
	WHERE
		lct_location = 'Storage' OR 
		lct_location= 'Lobby' OR 
		lct_location = 'Gallery A' OR 
		lct_location  ='Gallery B' OR 
		lct_location = 'Gallery C' OR 
		lct_location = 'Gallery D';
		

--Door locations.
INSERT INTO ns_t_location_doors (ns_lodor_locname_entrance, ns_lodor_museumkey_entrance, ns_lodor_locname_exit, ns_lodor_museumkey_exit)
SELECT lcon_location,'Evan', lcon_connectionfrom, 'Evan' FROM locationareas_connect;


--Now for external locations using traveling exhibitions table.
INSERT INTO ns_t_external_locations(ns_eloc_locname, ns_eloc_museumkey, ns_eloc_sponsor, ns_eloc_security, ns_eloc_elocdate_start, ns_eloc_elocdate_end, ns_eloc_iinsurance_total, ns_eloc_buildingnum, ns_eloc_streetname, ns_eloc_city)
SELECT trx_location, 'Evan', trx_sponsor, trx_security, exn_start, exn_end, trx_insurance, (substring(trx_address FROM '^[0-9]+')), (substring(trx_address FROM '[A-Za-z]+')), trx_location
FROM travelingexhibition, exhibition
WHERE trx_name = exn_name and trx_location <> 'Transit' and trx_location <> 'Storage';

--item locations, followed by exhibition item locations.

INSERT INTO ns_t_item_locations (ns_ilo_inumkey, ns_ilo_ialphakey, ns_ilo_museumkey_item, ns_ilo_locname, ns_ilo_museumkey_location, ns_ilo_ilodatetime_start,ns_ilo_ilodatetime_end)
SELECT wrl_numid, wrl_charid, 'Evan', wrl_location, 'Evan', wrl_startdate, wrl_enddate
FROM works_locations;

--Exhibtion Items.
INSERT INTO ns_t_exhibition_items (
	ns_exi_inumkey,
	ns_exi_ialphakey,
	ns_exi_museumkey,
	ns_exi_ename,
	ns_exi_showdate_start,
	ns_exi_exidate_start,
	ns_exi_exidate_end)
SELECT
	etw_numid, etw_charid, 'Evan', etw_name, exn_start, exn_start, exn_end 
FROM 
	exhibition_works, exhibition
WHERE 
	exn_name = etw_name AND exn_name <> 'Traveling Like Throwing Knife!';


INSERT INTO ns_t_exhibition_items (
	ns_exi_inumkey,
	ns_exi_ialphakey,
	ns_exi_museumkey,
	ns_exi_ename,
	ns_exi_showdate_start,
	ns_exi_exidate_start,
	ns_exi_exidate_end)
SELECT
	etw_numid, etw_charid, 'Evan', etw_name, exn_start, exr_startdate, exn_end
FROM
	exhibition_works, exhibition_rooms, exhibition
WHERE
	exr_name = etw_name AND exn_name = etw_name AND exr_name = 'Traveling Like Throwing Knife!';


--Exhibition_rooms to locations
INSERT INTO ns_t_exhibition_locations (
	ns_exl_ename,
	ns_exl_showdate_start,
	ns_exl_locname,
	ns_exl_museumkey,
	ns_exl_exldate_start,
	ns_exl_exldate_end)
SELECT 
	exr_name, exr_startdate, exr_location, 'Evan', exn_start, exn_end
FROM 
	exhibition_rooms, exhibition
WHERE exn_name = exr_name AND exr_name <> 'Traveling Like Throwing Knife!';

INSERT INTO ns_t_exhibition_locations (
	ns_exl_ename,
	ns_exl_showdate_start,
	ns_exl_locname,
	ns_exl_museumkey,
	ns_exl_exldate_start,
	ns_exl_exldate_end)
SELECT 
	exr_name, exr_startdate, exr_location, 'Evan', exr_startdate, exn_end
FROM 
	exhibition_rooms, exhibition
WHERE exn_name = exr_name AND exr_name = 'Traveling Like Throwing Knife!';


--Item transactions
--Borrowed
INSERT INTO ns_t_item_transactions (
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_museumkey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross)
SELECT
	wrk_numid, wrk_charid, 'Evan', wrk_ownername, 'Borrow', wrk_acquistion, '2016-07-11', NULL, wrk_insurance
FROM
	works
WHERE 
	wrk_ownership = 'B' OR wrk_ownership = 'P';
--Sold
INSERT INTO ns_t_item_transactions (
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_museumkey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross)
SELECT
	wrk_numid, wrk_charid, 'Evan', wrk_ownername, 'Sale', wrk_acquistion, NULL, NULL, wrk_insurance
FROM
	works
WHERE 
	wrk_ownership = 'S';

--Purchased
INSERT INTO ns_t_item_transactions (
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_museumkey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross)
SELECT
	wrk_numid, wrk_charid, 'Evan', wrk_ownername, 'Purchase', wrk_acquistion, NULL, NULL, wrk_insurance
FROM
	works
WHERE 
	wrk_ownership = 'A';

--Loan
INSERT INTO ns_t_item_transactions (
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_museumkey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itgross)
SELECT DISTINCT
	works_locations.wrl_numid, works_locations.wrl_charid, 'Evan', works_locations.wrl_Loaner, 'Loan', works_locations.wrl_startdate, works_locations.wrl_enddate, works.wrk_insurance
FROM
	works, works_locations
WHERE 
	works_locations.wrl_location = 'On Loan' and works_locations.wrl_numid = works.wrk_numid;
\copy ns_t_clients TO ns_t_clients.txt
\copy ns_t_exhibition_items TO ns_t_exhibition_items.txt
\copy ns_t_exhibition_locations TO ns_t_exhibition_locations.txt
\copy ns_t_exhibitions TO ns_t_exhibitions.txt
\copy ns_t_external_locations TO ns_t_external_locations.txt
\copy ns_t_internal_locations TO ns_t_internal_locations.txt
\copy ns_t_item_creators TO ns_t_item_creators.txt
\copy ns_t_item_locations TO ns_t_item_locations.txt
\copy ns_t_item_materials TO ns_t_item_materials.txt
\copy ns_t_item_transactions TO ns_t_item_transactions.txt
\copy ns_t_items TO ns_t_items.txt
\copy ns_t_location_doors TO ns_t_location_doors.txt
\copy ns_t_locations TO ns_t_locations.txt
\copy ns_t_materials TO ns_t_materials.txt
\copy ns_t_materials_subcomponents TO ns_t_materials_subcomponents.txt

--rollback;
--COMMIT;
