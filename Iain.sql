BEGIN;

-- Create ns tables/domains
\i Group1DatabaseCreation.sql 

-- Convenience changes to ns tables/domains
ALTER DOMAIN ns_museumkey SET DEFAULT 'Iain';


-- Move data into ns_t_clients
INSERT INTO ns_t_clients
(
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
)
SELECT
	it_iname,
	it_email,
	it_telephone,
	it_buildingnumber,
	it_buildingname,
	it_streetname,
	it_city,
	it_country,
	it_region,
	it_postalcode
FROM
	t_institution;

INSERT INTO ns_t_clients
(
	ns_cl_clname
)
SELECT
	ot_oname
FROM
	t_owner;

-- Add ourselves to the clients table :/
INSERT INTO ns_t_clients
(
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
)
VALUES
(
	'Iain',
	'iain@gallery.com',
	'0000000000',
	'15',
	NULL,
	'Gallery Way',
	'Saskatoon',
	'Canada',
	'Saskatchewan',
	'S7S 1A1'
);

-- Move data into ns_t_items
INSERT INTO ns_t_items
(
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_icolor,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription,
	ns_i_itsvector
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_wkname,
	NULL,
	wt_wktype,
	'In the Round',
	wt_wksubtype,
	NULL,
	NULL,
	wt_sterlingvalue_insurance * 1.7686,
	wt_wkacquisitiondate,
	wt_wkcreationyear,
	'Iain',
	wt_wkdescription,
	wt_wktsvectordescription
FROM 
	t_work
WHERE
(
	wt_wktype = 'Sculpture'
);

INSERT INTO ns_t_items
(
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_icolor,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription,
	ns_i_itsvector
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_wkname,
	NULL,
	'Sculpture',
	wt_wktype,
	wt_wksubtype,
	NULL,
	NULL,
	wt_sterlingvalue_insurance * 1.7686,
	wt_wkacquisitiondate,
	wt_wkcreationyear,
	'Iain',
	wt_wkdescription,
	wt_wktsvectordescription
FROM
	t_work
WHERE
(
	wt_wktype = 'Bust'
	OR
	wt_wktype = 'Relief'
);

INSERT INTO ns_t_items
(
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_icolor,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription,
	ns_i_itsvector
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_wkname,
	NULL,
	wt_wktype,
	NULL,
	wt_wksubtype,
	NULL,
	NULL,
	wt_sterlingvalue_insurance * 1.7686,
	wt_wkacquisitiondate,
	wt_wkcreationyear,
	'Iain',
	wt_wkdescription,
	wt_wktsvectordescription
FROM
	t_work
WHERE
(
	wt_wktype = 'Painting'
);

INSERT INTO ns_t_items
(
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_icolor,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription,
	ns_i_itsvector
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_wkname,
	NULL,
	'Print',
	NULL,
	wt_wksubtype,
	NULL,
	NULL,
	wt_sterlingvalue_insurance * 1.7686,
	wt_wkacquisitiondate,
	wt_wkcreationyear,
	'Iain',
	wt_wkdescription,
	wt_wktsvectordescription
FROM
	t_work
WHERE
(
	wt_wktype = 'On Paper, Print'
);

INSERT INTO ns_t_items
(
	ns_i_inumkey,
	ns_i_ialphakey,
	ns_i_iname,
	ns_i_iorigin,
	ns_i_iformat,
	ns_i_isubformat,
	ns_i_ischool,
	ns_i_isubject,
	ns_i_icolor,
	ns_i_iinsurance,
	ns_i_iacquisitiondate,
	ns_i_icreationyear,
	ns_i_clname_owner,
	ns_i_idescription,
	ns_i_itsvector
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_wkname,
	NULL,
	'Drawings',
	NULL,
	wt_wksubtype,
	NULL,
	NULL,
	wt_sterlingvalue_insurance * 1.7686,
	wt_wkacquisitiondate,
	wt_wkcreationyear,
	'Iain',
	wt_wkdescription,
	wt_wktsvectordescription
FROM
	t_work
WHERE
(
	wt_wktype = 'On Paper, Unique'
);

SELECT count(wt_wknumericid || wt_wkalphaid) AS originalworktable FROM t_work;
SELECT count(ns_i_inumkey || ns_i_ialphakey) AS newworktable FROM ns_t_items;
-- Update ownership of items to reflect borrowed works

UPDATE ns_t_items
SET
	ns_i_clname_owner = 'Danger Mouse'
WHERE
	(ns_i_inumkey || ns_i_ialphakey) IN
	(
		SELECT wt_wknumericid || wt_wkalphaid
		FROM t_work
		WHERE
			wt_oname = 'Danger Mouse'
	)
;

UPDATE ns_t_items
SET
	ns_i_clname_owner = 'Mickey Mouse'
WHERE
	(ns_i_inumkey || ns_i_ialphakey) IN
	(
		SELECT wt_wknumericid || wt_wkalphaid
		FROM t_work
		WHERE
			wt_oname = 'Mickey Mouse'
	)
;

UPDATE ns_t_items
SET
	ns_i_clname_owner = 'Mighty Mouse'
WHERE
	(ns_i_inumkey || ns_i_ialphakey) IN
	(
		SELECT wt_wknumericid || wt_wkalphaid
		FROM t_work
		WHERE
			wt_oname = 'Mighty Mouse'
	)
;

UPDATE ns_t_items
SET
	ns_i_clname_owner = 'Jerry'
WHERE
	(ns_i_inumkey || ns_i_ialphakey) IN
	(
		SELECT wt_wknumericid || wt_wkalphaid
		FROM t_work
		WHERE
			wt_oname = 'Jerry'
	)
;

-- Insert into creators
INSERT INTO ns_t_item_creators
(
	ns_cr_inumkey,
	ns_cr_ialphakey,
	ns_cr_crname
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_personname_author
FROM t_work;

SELECT COUNT(wt_wknumericid || wt_wkalphaid) AS workcount FROM t_work;
SELECT COUNT(ns_cr_inumkey || ns_cr_ialphakey) AS authorcount FROM ns_t_item_creators;

--Insert into master materials table
INSERT INTO ns_t_materials
(
	ns_mat_matname
)
SELECT DISTINCT
	mt_mname
FROM t_material;

-- Insert into item materials table
INSERT INTO ns_t_item_materials
(
	ns_imat_inumkey,
	ns_imat_ialphakey,
	ns_imat_matname
)
SELECT
	mt_wknumericid,
	mt_wkalphaid,
	mt_mname
FROM
	t_material;
	
-- Insert into transactions table
-- Loans
INSERT INTO ns_t_item_transactions
(
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross
)
SELECT
	wlnt_wknumericid,
	wlnt_wkalphaid,
	wlnt_iname,
	'Loan',
	wlnt_wkloantimestamp_start,
	NULL,
	wlnt_wkloantimestamp_end,
       0
FROM
	t_workloan;

-- Borrowings
DELETE FROM t_worklocation
WHERE
	wlt_wltimeinlocation_end IS NULL
	AND
	wlt_wknumericid || wlt_wkalphaid IN
	(
		SELECT wt_wknumericid || wt_wkalphaid
		FROM t_work
		WHERE wt_wkownedstate = 'Borrowed'
	);

INSERT INTO ns_t_item_transactions
(
	ns_it_inumkey,
	ns_it_ialphakey,
	ns_it_clname,
	ns_it_ittype,
	ns_it_itdatetime_start,
	ns_it_itdatetime_end,
	ns_it_itdatetime_returnby,
	ns_it_itgross
)
SELECT
	wt_wknumericid,
	wt_wkalphaid,
	wt_oname,
	'Borrow',
	min(wlt_wltimeinlocation_start),
	NULL,
	max(wlt_wltimeinlocation_end),
	0
FROM
	t_work, t_worklocation
WHERE
(
	wt_wknumericid = wlt_wknumericid
	AND
	wt_wkalphaid = wlt_wkalphaid
	AND
	wt_wkownedstate = 'Borrowed'
)
GROUP BY
	wt_wknumericid,
	wt_wkalphaid,
	wt_oname
;

-- Insert into locations table
INSERT INTO ns_t_locations
(
	ns_loc_locname,
	ns_loc_loctype
)
SELECT
	lt_lcname,
	'Internal'
FROM
	t_location
WHERE
	lt_lcname NOT IN
	(
		SELECT tlt_lcname
		FROM
			t_travelinglocation
	);

INSERT INTO ns_t_locations
(
	ns_loc_locname,
	ns_loc_loctype
)
SELECT
	lt_lcname,
	'External'
FROM
	t_location
WHERE
	lt_lcname IN
	(
		SELECT tlt_lcname
		FROM
			t_travelinglocation
	);

-- Insert into the internal locations table
INSERT INTO ns_t_internal_locations
(
	ns_iloc_locname,
	ns_iloc_numitems_min,
	ns_iloc_numitems_max,
	ns_iloc_locdimensionmetres_height,
	ns_iloc_locdimensionmetres_length,
	ns_iloc_locdimensionmetres_width,
	ns_iloc_loccreationdate
)
SELECT
	lt_lcname,
	lt_capacity_suggestedmin,
	lt_capacity_suggestedmax,
	lt_dimensionmetres_height,
	lt_dimensionmetres_length,
	lt_dimensionmetres_width,
	lt_lcavailabledate
FROM
	t_location
WHERE
	lt_lcname NOT IN
	(
		SELECT tlt_lcname
		FROM
			t_travelinglocation
	)
AND
	lt_lcname <> 'on loan'
;

-- Insert into the external locations table
INSERT INTO ns_t_external_locations
(
	ns_eloc_locname,
	ns_eloc_sponsor,
	ns_eloc_security,
	ns_eloc_elocdate_start,
	ns_eloc_elocdate_end,
	ns_eloc_iinsurance_total,
	ns_eloc_buildingnum,
	ns_eloc_buildingname,
	ns_eloc_streetname,
	ns_eloc_city,
	ns_eloc_country,
	ns_eloc_region,
	ns_eloc_postalcode
)
SELECT
	tlt_lcname,
	telt_tesponsor,
	telt_personname_security,
	elt_exlctimestamp_start,
	elt_exlctimestamp_end,
	telt_sterlingvalue_insurance * 1.7686,
	tlt_buildingnumber,
	tlt_buildingname,
	tlt_streetname,
	tlt_city,
	tlt_country,
	tlt_region,
	tlt_postalcode
FROM
	t_travelinglocation, t_travelingexhibitlocation, t_exhibitlocation
WHERE
(
	tlt_lcname = telt_lcname
	AND
	tlt_lcname = elt_lcname
);

-- Insert into the item locations table
DELETE FROM t_worklocation
WHERE
(
	wlt_wknumericid = 548
	AND
	wlt_wkalphaid = 'PA'
	AND
	wlt_lcname = 'storage'
	AND
	wlt_wltimeinlocation_start = '2014-11-17 00:00:00'
);

DELETE FROM t_worklocation
WHERE
(
	wlt_wknumericid = 733
	AND
	wlt_wkalphaid = 'PA'
	AND
	wlt_lcname = 'storage'
	AND
	wlt_wltimeinlocation_start = '2014-11-17 00:00:00'
);

DELETE FROM t_worklocation
WHERE
(
	wlt_wknumericid = 4171
	AND
	wlt_wkalphaid = 'PU'
	AND
	wlt_lcname = 'storage'
	AND
	wlt_wltimeinlocation_start = '2014-11-17 00:00:00'
);

INSERT INTO ns_t_item_locations
(
	ns_ilo_inumkey,
	ns_ilo_ialphakey,
	ns_ilo_locname,
	ns_ilo_ilodatetime_start,
	ns_ilo_ilodatetime_end
)
SELECT
	 wlt_wknumericid,
	 wlt_wkalphaid,
	 wlt_lcname,
	 wlt_wltimeinlocation_start,
	 wlt_wltimeinlocation_end
FROM
	t_worklocation;

-- Insert into the location doors table
INSERT INTO ns_t_location_doors
(
	ns_lodor_locname_entrance,
	ns_lodor_locname_exit
)
SELECT
	lct_lcname_from,
	lct_lcname_to
FROM
	t_locationconnection;

-- Insert into the exhibition table
INSERT INTO ns_t_exhibitions
(
	ns_ex_ename,
	ns_ex_showdate_start,
	ns_ex_showdate_end,
	ns_ex_edescription
)
SELECT
	et_exname,
	et_exrunningtimestamp_start,
	et_exrunningtimestamp_end,
	et_exdescription
FROM
	t_exhibit;

-- Insert into the exhibition items table
INSERT INTO ns_t_exhibition_items
(
	ns_exi_inumkey,
	ns_exi_ialphakey,
	ns_exi_ename,
	ns_exi_showdate_start,
	ns_exi_exidate_start,
	ns_exi_exidate_end
)
SELECT
	ewt_wknumericid,
	ewt_wkalphaid,
	ewt_exname,
	et_exrunningtimestamp_start,
	ewt_ewtimestamp_start,
	ewt_ewtimestamp_end
FROM
	t_exhibitwork, t_exhibit
WHERE
	ewt_exname = et_exname;

-- Insert into the exhibition locations table
INSERT INTO ns_t_exhibition_locations
(
	ns_exl_ename,
	ns_exl_showdate_start,
	ns_exl_locname,
	ns_exl_exldate_start,
	ns_exl_exldate_end
)
SELECT
	elt_exname,
	et_exrunningtimestamp_start,
	elt_lcname,
	elt_exlctimestamp_start,
	elt_exlctimestamp_end
FROM t_exhibitlocation, t_exhibit
WHERE
(
	elt_exname = et_exname
);

