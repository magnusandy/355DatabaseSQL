create or replace function insertItemWithClient(numkey inumkey, alphakey ialphakey, clientkey clname, nameOfItem iname, origin iorigin, format iformat, subformat isubformat, school ischool, subject isubject, insurance iinsurance, acquisition iacquisitiondate, creationyear icreationyear, description idescription,
												 email email, phonenumber phonenum, buildingname buildingname, buildingnum buildingnum, streetname streetname, city city, country country, region region, postalcode postalcode)
RETURNS VOID AS $$
begin

insert into t_clients(cl_clname, cl_email, cl_phonenum, cl_buildingnum, cl_buildingname, cl_streetname, cl_city, cl_country, cl_region, cl_postalcode)
VALUES(clientkey, email,phonenumber,buildingnum,buildingname, streetname, city, country, region, postalcode);


insert into t_items(i_inumkey, i_ialphakey, i_clientkey, i_iname, i_iorigin, i_iformat, i_isubformat, i_ischool, i_isubject, i_iinsurance, i_iacquisitiondate, i_icreationyear, i_idescription)
VALUES(numkey, alphakey, clientkey, nameOfItem, origin, format, subformat, school, subject, insurance, acquisition, creationyear, description);
end;
$$LANGUAGE PLPGSQL;