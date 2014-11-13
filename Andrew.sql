--TABLE CHECKLIST

clients DONE 
item creators DONE (not need for andrew)
materials DONE
subcomponenets DONE (not need for andrew)
locations DONE
internal locations DONE 
external locations DONE
location doors DONE
exhibitions
exhibition locations
items
item materials
transactions
item locations
exhibition items


DROP TABLE ns_t_clients CASCADE;
DROP TABLE ns_t_items CASCADE;
DROP TABLE ns_t_item_creators CASCADE;
DROP TABLE ns_t_materials CASCADE;
DROP TABLE ns_t_materials_subcomponents CASCADE;
DROP TABLE ns_t_item_materials CASCADE;
DROP TABLE ns_t_item_transactions CASCADE;
DROP TABLE ns_t_locations CASCADE;
DROP TABLE ns_t_internal_locations CASCADE;
DROP TABLE ns_t_external_locations CASCADE;
DROP TABLE ns_t_item_locations CASCADE;
DROP TABLE ns_t_location_doors CASCADE;
DROP TABLE ns_t_exhibitions CASCADE;
DROP TABLE ns_t_exhibition_items CASCADE;
DROP TABLE ns_t_exhibition_locations CASCADE;

DROP DOMAIN ns_inumkey;
DROP DOMAIN ns_ialphakey;
DROP DOMAIN ns_museumkey;
DROP DOMAIN ns_iname;
DROP DOMAIN ns_crname;
DROP DOMAIN ns_iorigin;
--SUBTYPES
DROP DOMAIN ns_iformat;
DROP DOMAIN ns_isubformat;
DROP DOMAIN ns_ischool;
DROP DOMAIN ns_isubject;

DROP DOMAIN ns_iinsurance;
DROP DOMAIN ns_iacquisitiondate;
DROP DOMAIN ns_icreationyear;
DROP DOMAIN ns_clname;
DROP DOMAIN ns_idescription;
DROP DOMAIN ns_email;
DROP DOMAIN ns_phonenum;

--address domains
DROP DOMAIN ns_buildingnum ;
DROP DOMAIN ns_buildingname;
DROP DOMAIN ns_streetname;
DROP DOMAIN ns_city;
DROP DOMAIN ns_country;
DROP DOMAIN ns_region;
DROP DOMAIN ns_postalcode;

DROP DOMAIN ns_locname;
DROP DOMAIN ns_loctype;
DROP DOMAIN ns_numitems;
DROP DOMAIN ns_dimension;
DROP DOMAIN ns_loccreationdate;
DROP DOMAIN ns_sponsor;
DROP DOMAIN ns_security;

DROP DOMAIN ns_ilodate;

DROP DOMAIN ns_ittype;
DROP DOMAIN ns_itdate;
DROP DOMAIN ns_itgross;

DROP DOMAIN ns_ename;
DROP DOMAIN ns_showdate;
DROP DOMAIN ns_edescription;

DROP DOMAIN ns_exidate;

DROP DOMAIN ns_matname;
DROP DOMAIN ns_exldate;

DROP DOMAIN ns_subcomponent;

DROP DOMAIN ns_itsvector;
DROP DOMAIN ns_elocdate;

DROP DOMAIN ns_icolor;
INSERT INTO itemowners (onroname) VALUES ('Our Museum');
UPDATE itemcollection SET coloname = 'Our Museum' WHERE coloname = 'Andrew Museum';
DELETE FROM itemowners WHERE onroname = 'Andrew Museum';



INSERT INTO itemowners (onroname) VALUES ('Andrew Museum');
UPDATE itemcollection SET coloname = 'Andrew Museum' WHERE coloname = 'Our Museum';
DELETE FROM itemowners WHERE onroname = 'Our Museum';

--FINISHING CLIENTS
INSERT INTO ns_t_clients (ns_cl_clname)
select onroname from itemowners;

--FINISHING MATERIALS
INSERT INTO ns_t_materials (ns_mat_matname)
SELECT matmedium from itemmaterials GROUP BY matmedium;

--LOCATIONS
INSERT INTO ns_t_locations (ns_loc_locname, ns_loc_museumkey, ns_loc_loctype)
SELECT locrmname, 'Andrew', 'Internal' FROM locations WHERE locdimentionlength IS NOT NULL;
INSERT INTO ns_t_locations (ns_loc_locname, ns_loc_museumkey, ns_loc_loctype)
SELECT locrmname, 'Andrew', 'External' FROM locations WHERE locdimentionlength IS NULL;

--INTERNAL LOCATIONS
INSERT INTO ns_t_internal_locations (ns_iloc_locname, ns_iloc_museumkey, ns_iloc_numitems_min, ns_iloc_numitems_max, ns_iloc_dimension_height, ns_iloc_dimension_length, ns_iloc_dimension_width)
SELECT locrmname, 'Andrew', locnumitemsmin, locnumitemsmax, locdimentionheight, locdimentionlength, locdimentionwidth FROM locations WHERE locdimentionlength IS NOT NULL;

--EXTERNAL LOCATIONS
 INSERT INTO ns_t_external_locations(
	ns_eloc_locname, ns_eloc_museumkey, ns_eloc_sponsor, ns_eloc_security, ns_eloc_elocdate_start, ns_eloc_elocdate_end, ns_eloc_iinsurance_total, ns_eloc_city, ns_eloc_country, ns_eloc_region)
	SELECT tmprmname, 'Andrew', tmponamesponsor, tmponamesecurity, elcexblocdatestart, elcexblocdateend, tmpinsuranceval, tmprmname, 'Canada', 'SK'
	FROM templocations, exibitionlocations WHERE tmprmname = elcrmname;
	
UPDATE ns_t_external_locations
	SET ns_eloc_buildingnum = '342',
	ns_eloc_streetname = 'Grand Ave'
	WHERE ns_eloc_locname = 'Luseland';
	
UPDATE ns_t_external_locations
	SET ns_eloc_buildingnum = '3463',
	ns_eloc_streetname = 'Broadway Road West'
	WHERE ns_eloc_locname = 'Saskatoon';
	
UPDATE ns_t_external_locations
	SET ns_eloc_buildingnum = '976',
	ns_eloc_streetname = 'rustin street 43 house north'
	WHERE ns_eloc_locname = 'Regina';
	
UPDATE ns_t_external_locations
	SET ns_eloc_buildingnum = '777',
	ns_eloc_streetname = 'valey drive'
	WHERE ns_eloc_locname = 'Climax';
	
UPDATE ns_t_external_locations
	SET ns_eloc_buildingnum = '46',
	ns_eloc_streetname = 'doge road northface drive'
	WHERE ns_eloc_locname = 'Kindersley';
	
-- LOCATION DOORS
INSERT INTO ns_t_location_doors (ns_lodor_locname_entrance, ns_lodor_museumkey_entrance, ns_lodor_locname_exit, ns_lodor_museumkey_exit)
SELECT lodrmnameentrance, 'Andrew', lodrmnameexit, 'Andrew' from locationdoors;


--EXHIBITIONS
INSERT INTO ns_t_exhibitions (ns_ex_ename, ns_ex_showdate_start, ns_ex_showdate_end, ns_ex_edescription)
SELECT exbshowname, exbshowdatestart, exbshowdateend, exbshowdescription FROM exibitions;


 
