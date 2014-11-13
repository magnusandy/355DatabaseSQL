-- created by Andrew Magnus 
-- Nov 10, 2014
--Database File for creation of Domains and the master database

--DOMAINS GO HERE

CREATE DOMAIN ns_inumkey as double precision;
CREATE DOMAIN ns_ialphakey as varchar(26);
CREATE DOMAIN ns_museumkey as varchar(10) CHECK (VALUE IN('Iain', 'Andrew', 'Ryan', 'Ken', 'Evan'));
CREATE DOMAIN ns_iname as varchar(400); --longest painting name ever
CREATE DOMAIN ns_crname as varchar(75);
CREATE DOMAIN ns_iorigin as varchar(40); --TODO

--SUBTYPES
CREATE DOMAIN ns_iformat as varchar(50);
CREATE DOMAIN ns_isubformat as varchar(50);
CREATE DOMAIN ns_ischool as varchar(50);
CREATE DOMAIN ns_isubject as varchar(50);

CREATE DOMAIN ns_iinsurance as numeric;
CREATE DOMAIN ns_iacquisitiondate as date;
CREATE DOMAIN ns_icreationyear as bigint;
CREATE DOMAIN ns_clname as varchar(75);
CREATE DOMAIN ns_idescription as text;
CREATE DOMAIN ns_email as varchar(100);
CREATE DOMAIN ns_phonenum as varchar(20);

--address domains
CREATE DOMAIN ns_buildingnum as varchar(10);
CREATE DOMAIN ns_buildingname as varchar(60);
CREATE DOMAIN ns_streetname as varchar(40);
CREATE DOMAIN ns_city as varchar(60);
CREATE DOMAIN ns_country as varchar(60);
CREATE DOMAIN ns_region as varchar(60);
CREATE DOMAIN ns_postalcode as varchar(20);

CREATE DOMAIN ns_locname as varchar(30);
CREATE DOMAIN ns_loctype as varchar(13)CHECK (VALUE IN('External', 'Internal'));
CREATE DOMAIN ns_numitems as smallint;
CREATE DOMAIN ns_dimension as real;
CREATE DOMAIN ns_loccreationdate as date;
CREATE DOMAIN ns_sponsor as varchar(75);
CREATE DOMAIN ns_security as varchar(75); 

CREATE DOMAIN ns_ilodate as timestamp;

CREATE DOMAIN ns_ittype as varchar(15) CHECK (VALUE IN ('borrow', 'loan', 'purchase', 'sale'));
CREATE DOMAIN ns_itdate as timestamp;
CREATE DOMAIN ns_itgross as numeric;

CREATE DOMAIN ns_ename as varchar(200);
CREATE DOMAIN ns_showdate as date;
CREATE DOMAIN ns_edescription as text;

CREATE DOMAIN ns_exidate as timestamp;

CREATE DOMAIN ns_matname as varchar(200);
CREATE DOMAIN ns_exldate as timestamp;

CREATE DOMAIN ns_subcomponent as varchar(50);

CREATE DOMAIN ns_itsvector as tsvector;
CREATE DOMAIN ns_elocdate as timestamp;

CREATE DOMAIN ns_icolor as varchar(50);



--TABLES GO HERE



--CLIENTS
CREATE TABLE ns_t_clients (
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
	ns_cl_postalcode ns_postalcode,
	PRIMARY KEY (ns_cl_clname)
);


--ITEMS
CREATE TABLE ns_t_items (
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
	ns_i_iacquisitiondate ns_iacquisitiondate NOT NULL,
	ns_i_icreationyear ns_icreationyear NOT NULL,
	ns_i_clname_owner ns_clname NOT NULL,
	ns_i_idescription ns_idescription NOT NULL,
	ns_i_itsvector ns_itsvector,
	PRIMARY KEY (ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey),
	FOREIGN KEY (ns_i_clname_owner) REFERENCES ns_t_clients (ns_cl_clname)
);

-- ITEM CREATORS
CREATE TABLE ns_t_item_creators (
	ns_cr_inumkey ns_inumkey NOT NULL,
	ns_cr_ialphakey ns_ialphakey NOT NULL,
	ns_cr_museumkey ns_museumkey NOT NULL,
	ns_cr_crname ns_crname NOT NULL,
	PRIMARY KEY(ns_cr_inumkey, ns_cr_ialphakey, ns_cr_museumkey, ns_cr_crname),
	FOREIGN KEY (ns_cr_inumkey, ns_cr_ialphakey, ns_cr_museumkey) REFERENCES ns_t_items (ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey) ON UPDATE CASCADE ON DELETE RESTRICT
);

--MATERIALS
CREATE TABLE ns_t_materials(
	ns_mat_matname ns_matname NOT NULL,
	PRIMARY KEY(ns_mat_matname)
);

--SUB COMPONENTS
CREATE TABLE ns_t_materials_subcomponents(
	ns_matsub_matname ns_matname NOT NULL,
	ns_matsub_subcomponent ns_subcomponent,
	PRIMARY KEY(ns_matsub_matname, ns_matsub_subcomponent),
	FOREIGN KEY(ns_matsub_matname) REFERENCES ns_t_materials(ns_mat_matname)
);

--ITEM MATERIALS
CREATE TABLE ns_t_item_materials(
	ns_imat_inumkey ns_inumkey NOT NULL,
	ns_imat_ialphakey ns_ialphakey NOT NULL,
	ns_imat_museumkey ns_museumkey NOT NULL,
	ns_imat_matname ns_matname NOT NULL,
	PRIMARY KEY(ns_imat_inumkey, ns_imat_ialphakey, ns_imat_museumkey, ns_imat_matname),
	FOREIGN KEY(ns_imat_inumkey, ns_imat_ialphakey, ns_imat_museumkey) REFERENCES ns_t_items(ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey),
	FOREIGN KEY(ns_imat_matname) REFERENCES ns_t_materials(ns_mat_matname)
);

--ITEM TRANSACTIONS
CREATE TABLE ns_t_item_transactions(
	ns_it_inumkey ns_inumkey NOT NULL,
	ns_it_ialphakey ns_ialphakey NOT NULL,
	ns_it_museumkey ns_museumkey NOT NULL,
	ns_it_clname ns_clname NOT NULL,
	ns_it_ittype ns_ittype NOT NULL,
	ns_it_itdate_start ns_itdate NOT NULL,
	ns_it_itdate_end ns_itdate, --NULL IF ITS A SALE
	ns_it_itdate_returnby ns_itdate, --null if its not a loan
	ns_it_itgross ns_itgross NOT NULL,
	PRIMARY KEY(ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_itdate_start),--TODO is this right?
	FOREIGN KEY(ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey) REFERENCES ns_t_items(ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey),
	FOREIGN KEY(ns_it_clname) REFERENCES ns_t_clients(ns_cl_clname)
);

--LOCATIONS MAIN
CREATE TABLE ns_t_locations (
	ns_loc_locname ns_locname NOT NULL,
	ns_loc_museumkey ns_museumkey NOT NULL,
	ns_loc_loctype ns_loctype NOT NULL,
	PRIMARY KEY (ns_loc_locname, ns_loc_museumkey)
);

--INTERNAL LOCATIONS
CREATE TABLE ns_t_internal_locations (
	ns_iloc_locname ns_locname NOT NULL,
	ns_iloc_museumkey ns_museumkey NOT NULL,
	ns_iloc_numitems_min ns_numitems NOT NULL,
	ns_iloc_numitems_max ns_numitems NOT NULL,
	ns_iloc_dimension_height ns_dimension NOT NULL,
	ns_iloc_dimension_length ns_dimension NOT NULL,
	ns_iloc_dimension_width ns_dimension NOT NULL,
	ns_iloc_loccreationdate ns_loccreationdate,
	PRIMARY KEY(ns_iloc_locname, ns_iloc_museumkey),
	FOREIGN KEY(ns_iloc_locname, ns_iloc_museumkey) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey)
);

--EXTERNAL LOCATIONS
CREATE TABLE ns_t_external_locations (
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
	ns_eloc_postalcode ns_postalcode,
	PRIMARY KEY(ns_eloc_locname, ns_eloc_museumkey, ns_eloc_elocdate_start),
	FOREIGN KEY(ns_eloc_locname, ns_eloc_museumkey) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey)
);

--ITEM LOCATIONS
CREATE TABLE ns_t_item_locations(
	ns_ilo_inumkey ns_inumkey NOT NULL,
	ns_ilo_ialphakey ns_ialphakey NOT NULL,
	ns_ilo_museumkey_item ns_museumkey NOT NULL,
	ns_ilo_locname ns_locname NOT NULL,
	ns_ilo_museumkey_location ns_museumkey NOT NULL,
	ns_ilo_ilodate_start ns_ilodate NOT NULL,
	ns_ilo_ilodate_end ns_ilodate, 
	PRIMARY KEY(ns_ilo_inumkey, ns_ilo_ialphakey, ns_ilo_museumkey_item, ns_ilo_ilodate_start), --THIS SHOULD BE GOOD RIGHT? DONT NEED LOCATION FOR PRIMARY KEY
	FOREIGN KEY(ns_ilo_inumkey, ns_ilo_ialphakey, ns_ilo_museumkey_item) REFERENCES ns_t_items(ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey),
	FOREIGN KEY(ns_ilo_locname, ns_ilo_museumkey_location) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey)
);


--LOCATION DOORS
CREATE TABLE ns_t_location_doors(
	ns_lodor_locname_entrance ns_locname NOT NULL,
	ns_lodor_museumkey_entrance ns_museumkey NOT NULL,
	ns_lodor_locname_exit ns_locname NOT NULL,
	ns_lodor_museumkey_exit ns_museumkey NOT NULL,
	PRIMARY KEY(ns_lodor_locname_entrance, ns_lodor_museumkey_entrance, ns_lodor_locname_exit, ns_lodor_museumkey_exit),
	FOREIGN KEY(ns_lodor_locname_entrance, ns_lodor_museumkey_entrance) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey),
	FOREIGN KEY(ns_lodor_locname_exit, ns_lodor_museumkey_exit) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey)
);

--EXHIBITIONS 
CREATE TABLE ns_t_exhibitions(
	ns_ex_ename ns_ename NOT NULL,
	ns_ex_showdate_start ns_showdate NOT NULL,
	ns_ex_showdate_end ns_showdate NOT NULL,
	ns_ex_edescription ns_edescription NOT NULL,
	PRIMARY KEY(ns_ex_ename, ns_ex_showdate_start)
);


--EXHIBITION ITEMS
CREATE TABLE ns_t_exhibition_items(
	ns_exi_inumkey ns_inumkey NOT NULL,
	ns_exi_ialphakey ns_ialphakey NOT NULL,
	ns_exi_museumkey ns_museumkey NOT NULL,
	ns_exi_ename ns_ename NOT NULL,
	ns_exi_showdate_start ns_showdate NOT NULL,
	ns_exi_exidate_start ns_exidate NOT NULL,
	ns_exi_exidate_end ns_exidate NOT NULL,
	PRIMARY KEY(ns_exi_inumkey, ns_exi_ialphakey, ns_exi_museumkey, ns_exi_ename, ns_exi_exidate_start),
	FOREIGN KEY(ns_exi_ename, ns_exi_showdate_start) REFERENCES ns_t_exhibitions(ns_ex_ename, ns_ex_showdate_start),
	FOREIGN KEY(ns_exi_inumkey, ns_exi_ialphakey, ns_exi_museumkey) REFERENCES ns_t_items(ns_i_inumkey, ns_i_ialphakey, ns_i_museumkey)
);

--EXHIBITION LOCATIONS
CREATE TABLE ns_t_exhibition_locations(
	ns_exl_ename ns_ename NOT NULL,
	ns_exl_showdate_start ns_showdate NOT NULL,
	ns_exl_locname ns_locname NOT NULL,
	ns_exl_museumkey ns_museumkey NOT NULL,
	ns_exl_exldate_start ns_exldate NOT NULL,
	ns_exl_exldate_end ns_exldate NOT NULL,
	PRIMARY KEY(ns_exl_ename, ns_exl_locname, ns_exl_museumkey, ns_exl_exldate_start),
	FOREIGN KEY(ns_exl_ename, ns_exl_showdate_start) REFERENCES ns_t_exhibitions(ns_ex_ename, ns_ex_showdate_start),
	FOREIGN KEY(ns_exl_locname, ns_exl_museumkey) REFERENCES ns_t_locations(ns_loc_locname, ns_loc_museumkey)
);

--VIEWS GO HERE

