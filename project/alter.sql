

 ALTER TABLE ns_t_items ALTER COLUMN ns_i_museumkey SET DATA TYPE ns_clname;
 ALTER TABLE ns_t_item_creators ALTER COLUMN ns_cr_museumkey SET DATA TYPE ns_clname;
 ALTER TABLE ns_t_item_transactions ALTER COLUMN ns_it_museumkey SET DATA TYPE ns_clname;
 ALTER TABLE ns_t_item_materials ALTER COLUMN ns_imat_museumkey SET DATA TYPE ns_clname;
 ALTER TABLE ns_t_item_locations ALTER COLUMN ns_ilo_museumkey_item SET DATA TYPE ns_clname;
 ALTER TABLE ns_t_exhibition_items ALTER COLUMN ns_exi_museumkey SET DATA TYPE ns_clname;
 UPDATE ns_t_items SET ns_i_museumkey = ns_i_clname_owner;
 
 ALTER TABLE ns_t_items RENAME COLUMN ns_i_museumkey TO ns_i_clientkey;
 ALTER TABLE ns_t_item_creators RENAME COLUMN ns_cr_museumkey TO ns_cr_clientkey;
 ALTER TABLE ns_t_item_transactions RENAME COLUMN ns_it_museumkey TO ns_it_clientkey;
 ALTER TABLE ns_t_item_materials RENAME COLUMN ns_imat_museumkey TO ns_imat_clientkey;
 ALTER TABLE ns_t_item_locations RENAME COLUMN ns_ilo_museumkey_item TO ns_ilo_clientkey_item;
 ALTER TABLE ns_t_exhibition_items RENAME COLUMN ns_exi_museumkey TO ns_exi_clientkey;
 
 --making locations table reflect internal locations
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_numitems_min ns_numitems;
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_numitems_max ns_numitems;
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_locdimensionmetres_height ns_locdimensionmetres;
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_locdimensionmetres_length ns_locdimensionmetres;
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_locdimensionmetres_width ns_locdimensionmetres;
 ALTER TABLE ns_t_locations ADD COLUMN ns_loc_loccreationdate ns_loccreationdate;
 
 UPDATE ns_t_locations SET ns_loc_numitems_min = ns_iloc_numitems_min,
						   ns_loc_numitems_max = ns_iloc_numitems_max,
						   ns_loc_locdimensionmetres_height= ns_iloc_locdimensionmetres_height,
						   ns_loc_locdimensionmetres_length = ns_iloc_locdimensionmetres_length,
						   ns_loc_locdimensionmetres_width = ns_iloc_locdimensionmetres_width,
						   ns_loc_loccreationdate = ns_iloc_loccreationdate
						   FROM ns_t_internal_locations
						   WHERE ns_loc_locname = ns_iloc_locname AND ns_loc_museumkey = ns_iloc_museumkey;
--insert names and addresses into clients
INSERT INTO ns_t_clients (ns_cl_clname,
	ns_cl_buildingnum,
	ns_cl_buildingname,
	ns_cl_streetname,
	ns_cl_city,
	ns_cl_country,
	ns_cl_region,
	ns_cl_postalcode)
SELECT ns_eloc_sponsor,
	ns_eloc_buildingnum,
	ns_eloc_buildingname,
	ns_eloc_streetname,
	ns_eloc_city,
	ns_eloc_country,
	ns_eloc_region,
	ns_eloc_postalcode
	FROM ns_t_external_locations;
	
-- add external locations stuff to the locations table
	ALTER TABLE ns_t_locations ADD COLUMN ns_loc_sponsor ns_sponsor;
	ALTER TABLE ns_t_locations ADD COLUMN ns_loc_security ns_security;
	ALTER TABLE ns_t_locations ADD COLUMN ns_loc_elocdate_start ns_elocdate;
	ALTER TABLE ns_t_locations ADD COLUMN ns_loc_elocdate_end ns_elocdate;
	ALTER TABLE ns_t_locations ADD COLUMN ns_loc_iinsurance_total ns_iinsurance;

UPDATE ns_t_locations SET
	ns_loc_sponsor = ns_eloc_sponsor,
	ns_loc_security = ns_eloc_security,
	ns_loc_elocdate_start = ns_eloc_elocdate_start,
	ns_loc_elocdate_end = ns_eloc_elocdate_end,
	ns_loc_iinsurance_total = ns_eloc_iinsurance_total
	FROM ns_t_external_locations
	WHERE ns_loc_locname = ns_eloc_locname AND ns_loc_museumkey = ns_eloc_museumkey;
	
UPDATE ns_t_locations set ns_loc_sponsor = 'Andrew Museum' where ns_loc_museumkey = 'Andrew' AND ns_loc_sponsor IS NULL;
UPDATE ns_t_locations set ns_loc_sponsor = 'Owner' where ns_loc_museumkey = 'Evan' AND ns_loc_sponsor IS NULL;
UPDATE ns_t_locations set ns_loc_sponsor = 'Iain' where ns_loc_museumkey = 'Iain' AND ns_loc_sponsor IS NULL;
UPDATE ns_t_locations set ns_loc_sponsor = 'Walker Art Center' where ns_loc_museumkey = 'Ken' AND ns_loc_sponsor IS NULL;
UPDATE ns_t_locations set ns_loc_sponsor = 'Ryans Museum' where ns_loc_museumkey = 'Ryan' AND ns_loc_sponsor IS NULL;

--alter museumkey domain
ALTER TABLE ns_t_locations ALTER COLUMN ns_loc_museumkey SET DATA TYPE ns_clname;
ALTER TABLE ns_t_external_locations ALTER COLUMN ns_eloc_museumkey SET DATA TYPE ns_clname;
ALTER TABLE ns_t_internal_locations ALTER COLUMN ns_iloc_museumkey SET DATA TYPE ns_clname;
ALTER TABLE ns_t_item_locations ALTER COLUMN ns_ilo_museumkey_location SET DATA TYPE ns_clname;
ALTER TABLE ns_t_exhibition_locations ALTER COLUMN ns_exl_museumkey SET DATA TYPE ns_clname;
ALTER TABLE ns_t_location_doors ALTER COLUMN ns_lodor_museumkey_entrance SET DATA TYPE ns_clname;
ALTER TABLE ns_t_location_doors ALTER COLUMN ns_lodor_museumkey_exit SET DATA TYPE ns_clname;
UPDATE ns_t_locations SET ns_loc_museumkey = ns_loc_sponsor; 

ALTER TABLE ns_t_locations RENAME COLUMN ns_loc_museumkey TO ns_loc_clientkey;
ALTER TABLE ns_t_external_locations RENAME COLUMN ns_eloc_museumkey TO ns_eloc_clientkey;
ALTER TABLE ns_t_internal_locations RENAME COLUMN ns_iloc_museumkey TO ns_iloc_clientkey;
ALTER TABLE ns_t_item_locations RENAME COLUMN ns_ilo_museumkey_location TO ns_ilo_clientkey_location;
ALTER TABLE ns_t_exhibition_locations RENAME COLUMN ns_exl_museumkey TO ns_exl_clientkey;
ALTER TABLE ns_t_location_doors RENAME COLUMN ns_lodor_museumkey_entrance TO ns_lodor_clientkey_entrance;
ALTER TABLE ns_t_location_doors RENAME COLUMN ns_lodor_museumkey_exit TO ns_lodor_clientkey_exit;


--cleanup
--get rid of owner column in items
ALTER TABLE ns_t_items DROP COLUMN ns_i_clname_owner;
ALTER TABLE ns_t_items ADD CONSTRAINT client_foreign_key FOREIGN KEY(ns_i_clientkey) REFERENCES ns_t_clients (ns_cl_clname);
--get rid of the redundant sponsor in the locations table
ALTER TABLE ns_t_locations DROP COLUMN ns_loc_sponsor;
ALTER TABLE ns_t_locations ADD CONSTRAINT location_client_foreign_key FOREIGN KEY(ns_loc_clientkey) REFERENCES ns_t_clients (ns_cl_clname);

DROP TABLE ns_t_external_locations;
DROP TABLE ns_t_internal_locations;

--add Colours table 
CREATE TABLE ns_t_item_colors (
	ns_icol_inumkey ns_inumkey NOT NULL,
	ns_icol_ialphakey ns_ialphakey NOT NULL,
	ns_icol_clientkey ns_clname NOT NULL,
	ns_icol_icolor ns_icolor NOT NULL,
	PRIMARY KEY (ns_icol_inumkey, ns_icol_ialphakey, ns_icol_clientkey, ns_icol_icolor),
	FOREIGN KEY (ns_icol_inumkey, ns_icol_ialphakey, ns_icol_clientkey)
		REFERENCES ns_t_items(ns_i_inumkey, ns_i_ialphakey, ns_i_clientkey)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
	);

--make records for all items with colors in the colors table	
INSERT INTO ns_t_item_colors (ns_icol_inumkey, ns_icol_ialphakey, ns_icol_clientkey, ns_icol_icolor)
SELECT ns_i_inumkey, ns_i_ialphakey, ns_i_clientkey, ns_i_icolor FROM ns_t_items WHERE ns_i_icolor IS NOT NULL;

--remove color attribute in items table 
ALTER TABLE ns_t_items DROP COLUMN ns_i_icolor;

--add security to exhibition locations
ALTER TABLE ns_t_exhibition_locations ADD COLUMN ns_exl_security ns_security;

--add values to the new security column
UPDATE ns_t_exhibition_locations SET ns_exl_security = ns_loc_security FROM ns_t_locations WHERE ns_exl_locname = ns_loc_locname AND ns_exl_clientkey = ns_loc_clientkey;

--remove security form locations
ALTER TABLE ns_t_locations DROP COLUMN ns_loc_security;
