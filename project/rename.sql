

ALTER DOMAIN ns_buildingname RENAME TO buildingname;
ALTER DOMAIN ns_buildingnum RENAME TO buildingnum;
ALTER DOMAIN ns_city RENAME TO city;
ALTER DOMAIN ns_clname RENAME TO clname;
ALTER DOMAIN ns_country RENAME TO country;
ALTER DOMAIN ns_crname RENAME TO crname;
ALTER DOMAIN ns_edescription RENAME TO edescription;
ALTER DOMAIN ns_elocdate RENAME TO elocdate;
ALTER DOMAIN ns_email RENAME TO email;
ALTER DOMAIN ns_ename RENAME TO ename;
ALTER DOMAIN ns_exidate RENAME TO exidate;
ALTER DOMAIN ns_exldate RENAME TO exldate;
ALTER DOMAIN ns_iacquisitiondate RENAME TO iacquisitiondate;
ALTER DOMAIN ns_ialphakey RENAME TO ialphakey;
ALTER DOMAIN ns_icolor RENAME TO icolor;
ALTER DOMAIN ns_icreationyear RENAME TO icreationyear;
ALTER DOMAIN ns_idescription RENAME TO idescription;
ALTER DOMAIN ns_iformat RENAME TO iformat;
ALTER DOMAIN ns_iinsurance RENAME TO iinsurance;
ALTER DOMAIN ns_ilodatetime RENAME TO ilodatetime;
ALTER DOMAIN ns_iname RENAME TO iname;
ALTER DOMAIN ns_inumkey RENAME TO inumkey;
ALTER DOMAIN ns_iorigin RENAME TO iorigin;
ALTER DOMAIN ns_ischool RENAME TO ischool;
ALTER DOMAIN ns_isubformat RENAME TO isubformat;
ALTER DOMAIN ns_isubject RENAME TO isubject;
ALTER DOMAIN ns_itdatetime RENAME TO itdatetime;
ALTER DOMAIN ns_itgross RENAME TO itgross;
ALTER DOMAIN ns_itsvector RENAME TO itsvector;
ALTER DOMAIN ns_ittype RENAME TO ittype;
ALTER DOMAIN ns_loccreationdate RENAME TO loccreationdate;
ALTER DOMAIN ns_locdimensionmetres RENAME TO locdimensionmetres;
ALTER DOMAIN ns_locname RENAME TO locname;
ALTER DOMAIN ns_loctype RENAME TO loctype;
ALTER DOMAIN ns_matname RENAME TO matname;
ALTER DOMAIN ns_museumkey RENAME TO museumkey;
ALTER DOMAIN ns_numitems RENAME TO numitems;
ALTER DOMAIN ns_phonenum RENAME TO phonenum;
ALTER DOMAIN ns_postalcode RENAME TO postalcode;
ALTER DOMAIN ns_region RENAME TO region;
ALTER DOMAIN ns_security RENAME TO security;
ALTER DOMAIN ns_showdate RENAME TO showdate;
ALTER DOMAIN ns_sponsor RENAME TO sponsor;
ALTER DOMAIN ns_streetname RENAME TO streetname;
ALTER DOMAIN ns_subcomponent RENAME TO subcomponent;


ALTER TABLE ns_t_clients RENAME TO t_clients;
ALTER TABLE ns_t_exhibition_items RENAME TO t_exhibition_items;
ALTER TABLE ns_t_exhibition_locations RENAME TO t_exhibition_locations;
ALTER TABLE ns_t_exhibitions RENAME TO t_exhibitions;
ALTER TABLE ns_t_item_colors RENAME TO t_item_colors;
ALTER TABLE ns_t_item_creators RENAME TO t_item_creators;
ALTER TABLE ns_t_item_locations RENAME TO t_item_locations;
ALTER TABLE ns_t_item_materials RENAME TO t_item_materials;
ALTER TABLE ns_t_item_transactions RENAME TO t_item_transactions;
ALTER TABLE ns_t_items RENAME TO t_items;
ALTER TABLE ns_t_location_doors RENAME TO t_location_doors;
ALTER TABLE ns_t_locations RENAME TO t_locations;
ALTER TABLE ns_t_materials RENAME TO t_materials;
ALTER TABLE ns_t_materials_subcomponents RENAME TO t_materials_subcomponents;

-- t_clients
ALTER TABLE t_clients RENAME COLUMN ns_cl_clname TO cl_clname;
ALTER TABLE t_clients RENAME COLUMN ns_cl_email TO cl_email; 
ALTER TABLE t_clients RENAME COLUMN ns_cl_phonenum TO cl_phonenum; 
ALTER TABLE t_clients RENAME COLUMN ns_cl_buildingnum TO cl_buildingnum;
ALTER TABLE t_clients RENAME COLUMN ns_cl_buildingname TO cl_buildingname;
ALTER TABLE t_clients RENAME COLUMN ns_cl_streetname TO cl_streetname;
ALTER TABLE t_clients RENAME COLUMN ns_cl_city TO cl_city;
ALTER TABLE t_clients RENAME COLUMN ns_cl_country TO cl_country;
ALTER TABLE t_clients RENAME COLUMN ns_cl_region TO cl_region;
ALTER TABLE t_clients RENAME COLUMN ns_cl_postalcode TO cl_postalcode;

-- t_exhibition_items
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_inumkey TO exi_inumkey;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_ialphakey TO exi_ialphakey;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_clientkey TO exi_clientkey;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_ename TO exi_ename;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_showdate_start TO exi_showdate_start;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_exidate_start TO exi_exidate_start;
ALTER TABLE t_exhibition_items RENAME COLUMN ns_exi_exidate_end TO exi_exidate_end;

-- t_exhibition_locations
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_ename TO exl_ename;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_showdate_start TO exl_showdate_start;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_locname TO exl_locname;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_clientkey TO exl_clientkey;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_exldate_start TO exl_exldate_start;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_exldate_end TO exl_exldate_end;
ALTER TABLE t_exhibition_locations RENAME COLUMN ns_exl_security TO exl_security;

-- t_exhibitions
ALTER TABLE t_exhibitions RENAME COLUMN ns_ex_ename TO ex_ename;
ALTER TABLE t_exhibitions RENAME COLUMN ns_ex_showdate_start TO ex_showdate_start;
ALTER TABLE t_exhibitions RENAME COLUMN ns_ex_showdate_end TO ex_showdate_end;
ALTER TABLE t_exhibitions RENAME COLUMN ns_ex_edescription TO ex_edescription;

-- t_item_colors
ALTER TABLE t_item_colors RENAME COLUMN ns_icol_inumkey TO icol_inumkey;
ALTER TABLE t_item_colors RENAME COLUMN ns_icol_ialphakey TO icol_ialphakey;
ALTER TABLE t_item_colors RENAME COLUMN ns_icol_clientkey TO icol_clientkey;
ALTER TABLE t_item_colors RENAME COLUMN ns_icol_icolor TO icol_icolor;

-- t_item_creators
ALTER TABLE t_item_creators RENAME COLUMN ns_cr_inumkey TO cr_inumkey;
ALTER TABLE t_item_creators RENAME COLUMN ns_cr_ialphakey TO cr_ialphakey;
ALTER TABLE t_item_creators RENAME COLUMN ns_cr_clientkey TO cr_clientkey;
ALTER TABLE t_item_creators RENAME COLUMN ns_cr_crname TO cr_crname;

-- t_item_locations
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_inumkey TO ilo_inumkey;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_ialphakey TO ilo_ialphakey;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_clientkey_item TO ilo_clientkey_item;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_locname TO ilo_locname;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_clientkey_location TO ilo_clientkey_location;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_ilodatetime_start TO ilo_ilodatetime_start;
ALTER TABLE t_item_locations RENAME COLUMN ns_ilo_ilodatetime_end TO ilo_ilodatetime_end;

-- t_item_materials
ALTER TABLE t_item_materials RENAME COLUMN ns_imat_inumkey TO imat_inumkey;
ALTER TABLE t_item_materials RENAME COLUMN ns_imat_ialphakey TO imat_ialphakey;
ALTER TABLE t_item_materials RENAME COLUMN ns_imat_clientkey TO imat_clientkey;
ALTER TABLE t_item_materials RENAME COLUMN ns_imat_matname TO imat_matname;

-- t_item_transactions
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_inumkey TO it_inumkey;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_ialphakey TO it_ialphakey;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_clientkey TO it_clientkey;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_clname TO it_clname;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_ittype TO it_ittype;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_itdatetime_start TO it_itdatetime_start;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_itdatetime_end TO it_itdatetime_end;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_itdatetime_returnby TO it_itdatetime_returnby;
ALTER TABLE t_item_transactions RENAME COLUMN ns_it_itgross TO it_itgross;

-- t_tiems
ALTER TABLE t_items RENAME COLUMN ns_i_inumkey TO i_inumkey;
ALTER TABLE t_items RENAME COLUMN ns_i_ialphakey TO i_ialphakey;
ALTER TABLE t_items RENAME COLUMN ns_i_clientkey TO i_clientkey;
ALTER TABLE t_items RENAME COLUMN ns_i_iname TO i_iname;
ALTER TABLE t_items RENAME COLUMN ns_i_iorigin TO i_iorigin;
ALTER TABLE t_items RENAME COLUMN ns_i_iformat TO i_iformat;
ALTER TABLE t_items RENAME COLUMN ns_i_isubformat TO i_isubformat;
ALTER TABLE t_items RENAME COLUMN ns_i_ischool TO i_ischool;
ALTER TABLE t_items RENAME COLUMN ns_i_isubject TO i_isubject;
ALTER TABLE t_items RENAME COLUMN ns_i_iinsurance TO i_iinsurance;
ALTER TABLE t_items RENAME COLUMN ns_i_iacquisitiondate TO i_iacquisitiondate;
ALTER TABLE t_items RENAME COLUMN ns_i_icreationyear TO i_icreationyear;
ALTER TABLE t_items RENAME COLUMN ns_i_idescription TO i_idescription;
ALTER TABLE t_items RENAME COLUMN ns_i_itsvector TO i_itsvector;

-- t_location_doors
ALTER TABLE t_location_doors RENAME COLUMN ns_lodor_locname_entrance TO lodor_locname_entrance;
ALTER TABLE t_location_doors RENAME COLUMN ns_lodor_clientkey_entrance TO lodor_clientkey_entrance;
ALTER TABLE t_location_doors RENAME COLUMN ns_lodor_locname_exit TO lodor_locname_exit;
ALTER TABLE t_location_doors RENAME COLUMN ns_lodor_clientkey_exit TO lodor_clientkey_exit;

-- t_locations
ALTER TABLE t_locations RENAME COLUMN ns_loc_locname TO loc_locname;
ALTER TABLE t_locations RENAME COLUMN ns_loc_clientkey TO loc_clientkey;
ALTER TABLE t_locations RENAME COLUMN ns_loc_loctype TO loc_loctype;
ALTER TABLE t_locations RENAME COLUMN ns_loc_numitems_min TO loc_numitems_min;
ALTER TABLE t_locations RENAME COLUMN ns_loc_numitems_max TO loc_numitems_max;
ALTER TABLE t_locations RENAME COLUMN ns_loc_locdimensionmetres_height TO loc_locdimensionmetres_height;
ALTER TABLE t_locations RENAME COLUMN ns_loc_locdimensionmetres_length TO loc_locdimensionmetres_length;
ALTER TABLE t_locations RENAME COLUMN ns_loc_locdimensionmetres_width TO loc_locdimensionmetres_width;
ALTER TABLE t_locations RENAME COLUMN ns_loc_loccreationdate TO loc_loccreationdate;
ALTER TABLE t_locations RENAME COLUMN ns_loc_elocdate_start TO loc_elocdate_start;
ALTER TABLE t_locations RENAME COLUMN ns_loc_elocdate_end TO loc_elocdate_end;
ALTER TABLE t_locations RENAME COLUMN ns_loc_iinsurance_total TO loc_iinsurance_total;

-- t_materials
ALTER TABLE t_materials RENAME COLUMN ns_mat_matname TO mat_matname;

-- t_materials_subcomponents
ALTER TABLE t_materials_subcomponents RENAME COLUMN ns_matsub_matname TO matsub_matname;
ALTER TABLE t_materials_subcomponents RENAME COLUMN ns_matsub_subcomponent TO matsub_subcomponent;
