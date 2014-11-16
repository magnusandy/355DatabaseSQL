--This file is used to translate Ryan's database into the new database format.
--This file should not be used to attempt to transfer Ryan's data into the actual team database. 
begin;
--Translating my items table

--I need to temporarily drop the constraint on the owner because I must derive this information. 
alter table ns_t_items drop constraint if exists ns_t_items_ns_i_clname_owner_fkey;
alter table ns_t_items alter column ns_i_clname_owner drop not null;

--inserting all of my items into the items table.
insert into ns_t_items
(ns_i_inumkey, ns_i_ialphakey, ns_i_museumKey, ns_i_iname, ns_i_iorigin, ns_i_iinsurance, ns_i_iacquisitionDate, ns_i_icreationYear, ns_i_idescription)
(select ii_numkey, ii_alphakey, 'Ryan', ii_itemName, ii_origin, ii_insurance, ii_aquisition, ii_yearMade, ii_itemDescription from t_itemsinfo);

--Deriving the owner names
--I must add a record for myself in the clients table.
insert into ns_t_clients
(ns_cl_clname, ns_cl_email, ns_cl_phonenum, ns_cl_buildingNum, ns_cl_streetname, ns_cl_city, ns_cl_country, ns_cl_region, ns_cl_postalcode)
VALUES('Ryans Museum', 'fake@fakeemail.com', '666-666-6666', '666', 'U of S', 'Wiggins', 'Saskatoon', 'Saskatchewan', 's7n 2f3');

--If my flag is set to owned, I own it.
update ns_t_items set ns_i_clname_owner = 'Ryans Museum' where ns_i_inumkey in (select ii_numkey from t_itemsinfo where ii_isowned = 'y');

--Now.. to derive the other owners..
--but first, I must put all of my clients into the actual ns_t_clients table.
insert into ns_t_clients(ns_cl_clname, ns_cl_phonenum, ns_cl_email)
(select c_name, c_phonenumber, c_email from t_clients);

--In English: For every item in ns_t_items that has a null owner, find the corresponding item in the itemTransactions table and set the owner accordingly.
update ns_t_items set ns_i_clname_owner = it_clientname from t_itemtransactions where 
it_numkey in (select ns_i_inumkey from ns_t_items where ns_i_clname_owner is null) 
and it_numkey = ns_i_inumkey;

--ReAdding the constraints.
alter table ns_t_items add FOREIGN KEY(ns_i_clname_owner) references ns_t_clients(ns_cl_clname);
alter table ns_t_items alter column ns_i_clname_owner set not null;

--Updating my terms.
update ns_t_items set ns_i_isubject = 'Military' where ns_i_isubject = 'War-related';
update ns_t_items set ns_i_iformat = 'Jewelry' where ns_i_iformat = 'Jewlery';

--Put my tsvector in. 
update ns_t_items set ns_i_itsvector = to_tsvector(ns_i_idescription);

--Now time to deal with the itemTypes. These first three updates easily transfer over according to our categories sheet.
update ns_t_items set ns_i_isubject = ii_type from t_itemsinfo where ii_numkey = 
ns_i_inumkey;

update ns_t_items set ns_i_iformat = ii_subtype from t_itemsinfo where ii_numkey = 
ns_i_inumkey and ii_subtype not in ('Medallion', 'Headdress', 'Mask'); 

update ns_t_items set ns_i_isubformat = ii_subtype from t_itemsinfo where ii_numkey = 
ns_i_inumkey and ii_subtype in ('Medallion', 'Headdress', 'Mask'); 

--There should not be a subformat without a corresponding format.
update ns_t_items set ns_i_iformat = 'Ornament' where ns_i_isubformat = 'Medallion';
update ns_t_items set ns_i_iformat = 'Attire' where ns_i_isubformat in ('Headdress', 'Mask');




--TRANSFERRING THE ITEM AUTHORS
--TRANSFERRING THE ITEM AUTHORS
alter table t_itemauthors drop column if exists ia_author;
alter table t_itemauthors add column ia_author ns_crname;

update t_itemauthors set ia_author = ia_authorlastname 
where ia_authorfirstname = '' and ia_authormiddlename = '' and ia_authorlastname <> '';

update t_itemauthors set ia_author = ia_authorFirstName 
where ia_authorlastname = '' and (ia_authormiddlename = '' or ia_authormiddlename = 'null' or ia_authormiddlename is null) and ia_authorfirstname <> '';

update t_itemauthors set ia_author = ia_authorFirstName || ' ' || ia_authorLastname 
where (ia_authormiddlename = '' or ia_authormiddlename = 'null' or ia_authormiddlename is null) and ia_authorfirstname <> '' and ia_authorlastname <> '';

update t_itemauthors set ia_author = ia_authorFirstName || ' ' || ia_authormiddlename || ' ' || ia_authorlastname
where ia_authorfirstname <> '' and (ia_authormiddlename <> '' and ia_authormiddlename <> 'null' and ia_authormiddlename is not null) and ia_authorlastname <> '';

insert into ns_t_item_creators(ns_cr_inumkey, ns_cr_ialphakey, ns_cr_museumkey, ns_cr_crname)
(select ia_numkey, ia_alphakey, 'Ryan', ia_author from t_itemauthors);

alter table t_itemauthors drop column if exists ia_author;


alter table t_itemauthors drop column if exists ia_author;

--Materials
--normalizing my materials.
update t_itemmaterials set im_itemmaterial = 'Antelope' where im_itemMaterial = 'Antelope horn';
update t_itemmaterials set im_itemmaterial = 'Bronze' where im_itemMaterial in (' Bronze', 'Bronze ', ' Bronze ');
update t_itemmaterials set im_itemmaterial = 'Wood' where im_itemmaterial in ('Carved wood with pigment', 'wood', ' wood', ' wood ', 'wood ', 'Wood carved in high and low relief', 'Wood stand', 'Wood with pigment and gilding');
update t_itemmaterials set im_itemmaterial = 'Enamel' where im_itemmaterial = 'Enamel on canvas';
update t_itemmaterials set im_itemmaterial = 'Limestone' where im_itemmaterial = 'Limestone and pigment';
update t_itemmaterials set im_itemmaterial = 'Manuscript' where im_itemmaterial = 'manuscript';
update t_itemmaterials set im_itemmaterial = 'Marble' where im_itemmaterial in ('Marble top', 'Marble veneer');
update t_itemmaterials set im_itemmaterial = 'Mixed media' where im_itemmaterial = 'Mixed media on wood';
update t_itemmaterials set im_itemmaterial = 'Iron' where im_itemmaterial = 'Mounted on an iron spike';
update t_itemmaterials set im_itemmaterial = 'Oil on canvas' where im_itemmaterial in ('Oil ink on canvas', 'Oil on Canvas');
update t_itemmaterials set im_itemmaterial = 'Palm fiber' where im_itemmaterial = 'Palm fibers';
update t_itemmaterials set im_itemmaterial = 'Pearl' where im_itemmaterial = 'Pearls';
update t_itemmaterials set im_itemmaterial = 'Pigment' where im_itemmaterial = 'Pigments';

--Inserting into master materials table. 
insert into ns_t_materials(ns_mat_matname)
(select distinct im_itemmaterial from t_itemmaterials);

--Item Materials
insert into ns_t_item_materials(ns_imat_inumkey, ns_imat_ialphakey, ns_imat_matname, ns_imat_museumkey)
(select im_numkey, im_alphakey, im_itemmaterial, 'Ryan' from t_itemmaterials);

--LOCATIONS*************
alter table  t_locationnames drop constraint if exists t_locationnames_ln_locationtype_check;
update t_locationnames set ln_locationtype = 'External' where ln_locationtype = 'Travelling';

insert into ns_t_locations(ns_loc_locname, ns_loc_museumkey, ns_loc_loctype)
(select ln_locationname, 'Ryan', ln_locationtype from t_locationnames);

--Internal locations
alter table t_internallocations drop column if exists il_dimension_height cascade;
alter table t_internallocations drop column if exists il_dimension_length cascade;
alter table t_internallocations drop column if exists il_dimension_width cascade;
alter table t_internallocations add column il_dimension_height ns_locdimensionmetres;
alter table t_internallocations add column il_dimension_length ns_locdimensionmetres;
alter table t_internallocations add column il_dimension_width ns_locdimensionmetres;

update t_internallocations set il_dimension_height = 50 where il_locationname in ('Gallery B', 'Gallery A', 'Gallery C');
update t_internallocations set il_dimension_height = 60 where il_locationname = 'Storage';
update t_internallocations set il_dimension_height = 35 where il_locationname = 'Lobby';
update t_internallocations set il_dimension_height = 80 where il_locationname = 'Large Gallery';

update t_internallocations set il_dimension_length = 60 where il_locationname in ('Gallery B', 'Gallery A');
update t_internallocations set il_dimension_length = 120 where il_locationname in ('Lobby', 'Gallery C');
update t_internallocations set il_dimension_length = 75 where il_locationname = 'Storage';
update t_internallocations set il_dimension_length = 140 where il_locationname = 'Large Gallery';

update t_internallocations set il_dimension_width = 50 where il_locationname in ('Gallery A', 'Gallery B');
update t_internallocations set il_dimension_width = 50 where il_locationname = 'Gallery C';
update t_internallocations set il_dimension_width = 140 where il_locationname = 'Storage';
update t_internallocations set il_dimension_width = 40 where il_locationname = 'Lobby';
update t_internallocations set il_dimension_width = 75 where il_locationname = 'Large Gallery';

insert into ns_t_internal_locations
(ns_iloc_locname, ns_iloc_museumkey, ns_iloc_numitems_min, ns_iloc_numitems_max, ns_iloc_locdimensionmetres_height, ns_iloc_locdimensionmetres_length, ns_iloc_locdimensionmetres_width, ns_iloc_loccreationdate)
(select il_locationname, 'Ryan', il_suggestedmin, il_suggestedmax, il_dimension_height, il_dimension_length, il_dimension_width, il_availabledate from t_internallocations
where il_locationname not in ('Possessed By Lender', 'Sold', 'On-Loan'));

alter table t_internallocations drop column if exists il_dimension_height cascade;
alter table t_internallocations drop column if exists il_dimension_width cascade;
alter table t_internallocations drop column if exists il_dimension_length cascade;

--External Locations
alter table t_travellinglocations drop column if exists buildingnum cascade;
alter table t_travellinglocations drop column if exists buildingname cascade;
alter table t_travellinglocations drop column if exists streetname cascade;
alter table t_travellinglocations drop column if exists country cascade;
alter table t_travellinglocations drop column if exists region cascade;

alter table t_travellinglocations add column buildingnum ns_buildingnum;
alter table t_travellinglocations add column buildingname ns_buildingname;
alter table t_travellinglocations add column streetname ns_streetname;
alter table t_travellinglocations add column country ns_country;
alter table t_travellinglocations add column region ns_region;

update t_travellinglocations set country = 'Canada';
update t_travellinglocations set region = 'Saskatchewan';
update t_travellinglocations set tl_address = '127 Salt Road' where tl_address = '127 Sald Road';
update t_travellinglocations set buildingnum = (select split_part(tl_address, ' ', 1));
update t_travellinglocations set streetname = ((select split_part(tl_address, ' ', 2)) || ' ' || (select split_part(tl_address, ' ', 3)));
update t_travellinglocations set buildingname = tl_locationname;

alter table t_travellinglocations add column startdate ns_elocdate;
alter table t_travellinglocations add column enddate ns_elocdate;

update t_travellinglocations set startdate =  tl_revisiondate;

update t_travellinglocations set enddate = el_enddate from t_exhibitionlocations
where el_locationname = tl_locationname;

alter table t_travellinglocations drop column if exists tl_insurancevalue cascade;
alter table t_travellinglocations add column tl_insurancevalue price;
update t_travellinglocations set tl_insurancevalue = 23050000.00 where tl_city = 'Saskatoon';
update t_travellinglocations set tl_insurancevalue = 2307500.00 where tl_city = 'Preeceville';
update t_travellinglocations set tl_insurancevalue = 23120050.00 where tl_city = 'Vanscoy';
update t_travellinglocations set tl_insurancevalue = 2364755.00 where tl_city = 'Rosewood';
update t_travellinglocations set tl_insurancevalue = 23254257.00 where tl_city = 'Martensville';

insert into ns_t_external_locations
(ns_eloc_locname, ns_eloc_museumkey, ns_eloc_sponsor, ns_eloc_elocdate_start, ns_eloc_elocdate_end, ns_eloc_iinsurance_total,ns_eloc_buildingname,ns_eloc_buildingnum,ns_eloc_streetname,ns_eloc_country,ns_eloc_region, ns_eloc_security)
(select tl_locationname, 'Ryan', tl_sponsor, startdate, enddate, tl_insurancevalue, buildingname, buildingnum, streetname, 'Canada', 'Saskatchewan', tl_securityhead from t_travellinglocations);

--Location doors
insert into ns_t_location_doors(ns_lodor_locname_entrance, ns_lodor_museumkey_entrance, ns_lodor_locname_exit, ns_lodor_museumkey_exit)
(select co_locationname, 'Ryan', co_locationconnection, 'Ryan' from t_connections);

--TRANSFERRING EXHIBITIONS
insert into ns_t_exhibitions(ns_ex_ename, ns_ex_showdate_start, ns_ex_showdate_end, ns_ex_edescription)
(select ex_exhibitionName, ex_exhibitionStartDate, ex_exhibitionEndDate, ex_exhibitionDescription from t_exhibitions);


--ITEM LOCATIONS*************
insert into ns_t_item_locations(ns_ilo_inumkey, ns_ilo_ialphakey, ns_ilo_museumkey_item,ns_ilo_locname,ns_ilo_museumkey_location,ns_ilo_ilodatetime_start,ns_ilo_ilodatetime_end)
(select il_numkey, il_alphakey, 'Ryan', il_locationname, 'Ryan', il_startDate, il_enddate from t_itemlocations);


--itemTransactions
alter table t_itemtransactions drop constraint t_itemtransactions_it_transactiontype_check cascade;
update t_itemtransactions set it_transactiontype = 'Loan' where it_transactiontype = 'Lend';

insert into ns_t_item_transactions
(ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdatetime_start, ns_it_itdatetime_end, ns_it_itdatetime_returnBy, ns_it_itgross)
(select it_numkey, it_alphakey, 'Ryan', it_clientname, it_transactiontype, it_date_start, it_date_end, it_date_returnby, it_costOftransaction from t_itemtransactions where it_transactiontype in ('Purchase', 'Sale'));

insert into ns_t_item_transactions
(ns_it_inumkey, ns_it_ialphakey, ns_it_museumkey, ns_it_clname, ns_it_ittype, ns_it_itdatetime_start, ns_it_itdatetime_end, ns_it_itdatetime_returnBy, ns_it_itgross)
(select it_numkey, it_alphakey, 'Ryan', it_clientname, it_transactiontype, it_date_start, it_date_end, it_date_returnby, 0 from t_itemtransactions where it_transactiontype in ('Borrow', 'Loan'));

--TRANSFERRRING EXHIBITION LOCATIONS*************
alter table t_exhibitionlocations add column el_showstart ns_exldate;
update t_exhibitionlocations set el_showstart = ex_exhibitionstartdate from t_exhibitions 
where ex_exhibitionname = el_exhibitionname and (ex_exhibitionstartDate,ex_exhibitionenddate) OVERLAPS(el_startdate, el_enddate);

insert into ns_t_exhibition_locations
(ns_exl_ename, ns_exl_showdate_start, ns_exl_locname, ns_exl_exldate_start, ns_exl_exldate_end, ns_exl_museumkey)
(select el_exhibitionname, el_showstart, el_locationname, el_startdate, el_enddate, 'Ryan' from t_exhibitionlocations); 

--TRANSFERRING INTO EXHIBITION ITEMS
alter table t_exhibitionitems add column ei_showstart ns_exldate;
update t_exhibitionitems set ei_showstart = ex_exhibitionstartdate from t_exhibitions 
where ex_exhibitionname = ei_exhibitionname and (ex_exhibitionstartDate,ex_exhibitionenddate) OVERLAPS(ei_date_start, ei_date_start);

update t_exhibitionitems set ei_date_end = ex_exhibitionenddate from t_exhibitions
where ex_exhibitionname = ei_exhibitionname and (ex_exhibitionstartdate, ex_exhibitionenddate) overlaps (ei_date_start, ei_date_start) and ei_date_end is null;


insert into ns_t_exhibition_items
(ns_exi_inumkey, ns_exi_ialphakey, ns_exi_museumkey, ns_exi_ename, ns_exi_showdate_start, ns_exi_exidate_start, ns_exi_exidate_end)
(select ei_numkey, ei_alphakey, 'Ryan', ei_exhibitionname, ei_showstart, ei_date_start, ei_date_end from t_exhibitionItems);
