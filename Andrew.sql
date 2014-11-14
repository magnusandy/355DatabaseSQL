--TABLE CHECKLIST
/*
clients DONE 
item creators DONE (not need for andrew)
materials DONE
subcomponenets DONE (not need for andrew)
locations DONE
internal locations DONE 
external locations DONE
location doors DONE
exhibitions DONE
exhibition locations DONE 
items DONE
item materials DONE 
transactions DONE
item locations DONE
exhibition items DONE
*/
/*
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
*/


INSERT INTO itemowners (onroname) VALUES ('Andrew Museum');
UPDATE itemcollection SET coloname = 'Andrew Museum' WHERE coloname = 'Our Museum';
DELETE FROM itemowners WHERE onroname = 'Our Museum';

--FINISHING CLIENTS
INSERT INTO ns_t_clients (ns_cl_clname)
select onroname from itemowners;

UPDATE ns_t_clients
	SET
		ns_cl_email = lonemail,
		ns_cl_phonenum = lonphonenum,
		ns_cl_buildingnum = '1400',
		ns_cl_buildingname = 'GPO Box',
		ns_cl_streetname = 'CANBERRA ACT 2601'
	FROM loaninfo
	WHERE ns_cl_clname = 'National Portrait Gallery';
	
UPDATE ns_t_clients
	SET
		ns_cl_email = lonemail,
		ns_cl_phonenum = lonphonenum,
		ns_cl_buildingnum = '22',
		ns_cl_streetname = 'Hines Road',
		ns_cl_city = 'Ipswich Suffolk',
		ns_cl_postalcode = 'IP3 9BG',
		ns_cl_country = 'UK'
	FROM loaninfo
	WHERE ns_cl_clname = 'Guggenheim Museum';
	
UPDATE ns_t_clients
	SET
		ns_cl_email = lonemail,
		ns_cl_phonenum = lonphonenum,
		ns_cl_buildingnum = '39',
		ns_cl_streetname = 'Magpie Street',
		ns_cl_city = 'Ballarat, Victoria',
		ns_cl_postalcode = '3350',
		ns_cl_country = 'Australia'
	FROM loaninfo
	WHERE ns_cl_clname = 'The Gold Museum';
	
	
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

--EXHIBITION LOCATIONS
INSERT INTO ns_t_exhibition_locations (ns_exl_ename, ns_exl_showdate_start, ns_exl_locname, ns_exl_museumkey, ns_exl_exldate_start, ns_exl_exldate_end)
SELECT elcshowname, elcshowdatestart, elcrmname, 'Andrew', elcexblocdatestart, elcexblocdateend FROM exibitionlocations;

--ITEMS

--normalzation work, making it so all types are standard before adding to the main
UPDATE itemcollection SET colmaintype = 'Clay' where colmaintype = 'Clay ';
UPDATE itemcollection SET colmaintype = 'Claywork' where colmaintype = 'Clay';
UPDATE itemcollection SET colsubtype = 'Military' WHERE colsubtype = 'Arms';
UPDATE itemcollection SET colsubtype = 'Watercolor' WHERE colsubtype = 'Waterclor';

--basic item info without types and subtypes
INSERT INTO ns_t_items (
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_museumkey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription)
SELECT colnumid, colalphaid, 'Andrew', coliname, colsource, colmaintype, colinsuranceval, colaquisitiondate, colcompletiondate, coloname, colidescription FROM itemcollection;


UPDATE ns_t_items
	SET ns_i_isubformat = (SELECT colsubtype FROM itemcollection WHERE ns_i_inumkey = colnumid AND colsubtype != 'Military');
	
UPDATE ns_t_items
	SET ns_i_isubject = (SELECT colsubtype FROM itemcollection WHERE ns_i_inumkey = colnumid AND colsubtype = 'Military');

	--item icolor from text search
CREATE VIEW color
AS SELECT textalphaid, textnumid, attattribute, attdescriptor
FROM textsearch_view, attributes_view
WHERE tsv_description @@ to_tsquery('english', attdescriptor) AND 
attattribute = 'Colourful' AND ((attdescriptor != 'paint') AND (attdescriptor != 'color'))
ORDER BY textnumid;

UPDATE ns_t_items SET ns_i_icolor = attdescriptor
FROM color
WHERE textnumid = ns_i_inumkey;
	
--ITEM MATERIALS
INSERT INTO ns_t_item_materials (ns_imat_inumkey, ns_imat_ialphakey, ns_imat_museumkey, ns_imat_matname )
SELECT matnumid, matalphaid, 'Andrew', matmedium FROM itemMaterials;

--ITEM TRANSACTIONS
UPDATE itemcollection SET colaquisitiondate = '2014-10-20' WHERE ((colnumid = '1978400415') OR (colnumid = '1972118101') OR (colnumid = '1998544354'));

--borrowed items
INSERT INTO ns_t_item_transactions (ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdate_start, ns_it_itdate_returnby, ns_it_itgross)
	SELECT colnumid, colalphaid, 'Andrew', coloname, 'borrow', colaquisitiondate, colitemdatedeparture, colinsuranceval FROM itemcollection WHERE colborrowedstatus = 'B';
	
INSERT INTO ns_t_item_transactions (ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdate_start, ns_it_itdate_returnby, ns_it_itgross)
	SELECT colnumid, colalphaid, 'Andrew', coloname, 'loan', colaquisitiondate, '2017-06-01 00:00:00', colinsuranceval FROM itemcollection WHERE colborrowedstatus = 'L';

INSERT INTO ns_t_item_transactions (ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdate_start, ns_it_itgross)
	SELECT colnumid, colalphaid, 'Andrew', coloname, 'sale', colitemdatedeparture, colinsuranceval FROM itemcollection WHERE colborrowedstatus = 'S';

	--fixed these dates, didnt get changed last time
UPDATE itemcollection SET colaquisitiondate = '2014-10-20' WHERE ((colnumid = '1978400415') OR (colnumid = '1972118101') OR (colnumid = '1998544354'));
	
INSERT INTO ns_t_item_transactions (ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdate_start, ns_it_itgross)
	SELECT colnumid, colalphaid, 'Andrew', coloname, 'purchase', colaquisitiondate, colinsuranceval FROM itemcollection WHERE colaquisitiondate = '2014-10-20';

--ITEM LOCATIONS;
INSERT INTO ns_t_item_locations( ns_ilo_inumkey, ns_ilo_ialphakey, ns_ilo_museumkey_item, ns_ilo_locname, ns_ilo_museumkey_location, ns_ilo_ilodate_start, ns_ilo_ilodate_end)
SELECT ilonumid, iloalphaid, 'Andrew', ilormname, 'Andrew', ilolocdatestart, ilolocdateend from itemlocations; 

--EXHIBITION ITEMS
INSERT INTO ns_t_exhibition_items(ns_exi_inumkey, ns_exi_ialphakey, ns_exi_museumkey, ns_exi_ename, ns_exi_showdate_start, ns_exi_exidate_start, ns_exi_exidate_end)
SELECT exinumid, exialphaid, 'Andrew', exishowname, exishowdatestart, exishowdatestart, exbshowdateend FROM exibitionitems, exibitions where exbshowname = exishowname AND exbshowdatestart = exishowdatestart;


--update the date for the few items that were put into the exibition at a different time than the start date of the exhibition.
UPDATE ns_t_exhibition_items
SET ns_exi_exidate_start = ilolocdatestart
	FROM itemlocations 
	WHERE ilonumid = ns_exi_inumkey AND ilolocdatestart = '2014-10-27 00:00:00' AND ilolocdateend = ns_exi_exidate_end + interval '1 day';

	/*
SELECT * FROM ns_t_clients;                 
SELECT * FROM ns_t_exhibition_items;        
SELECT * FROM ns_t_exhibition_locations;    
SELECT * FROM ns_t_exhibitions;             
SELECT * FROM ns_t_external_locations;      
SELECT * FROM ns_t_internal_locations;      
SELECT * FROM ns_t_item_creators;           
SELECT * FROM ns_t_item_locations;          
SELECT * FROM ns_t_item_materials ;         
SELECT * FROM ns_t_item_transactions  ;     
SELECT * FROM ns_t_items    ;               
SELECT * FROM ns_t_location_doors  ;        
SELECT * FROM ns_t_locations   ;            
SELECT * FROM ns_t_materials  ;             
SELECT * FROM ns_t_materials_subcomponents ;
--LOOKS LIKE I DIDNT FORGET ANYTHING
*/

 
