quick summary of what exactly has been changed, names of attributes and whatnot:

	- any attribute previously called ns_xxxx_museumkey_xxxx or similar has been renamed to ns_xxxx_clientkey_xxxx
		- the data-type of all these attributes has been changed to ns_clname
		
	- ns_loc_numitems_min,
   	  ns_loc_numitems_max,
	  ns_loc_locdimensionmeters_height,
	  ns_loc_locdimensionmeters_width,
	  ns_loc_locdimensionmeters_length,
	  ns_loc_loccreationdate,
	  ns_loc_elocdate_start,
	  ns_loc_elocdate_end,
	  ns_loc_iinsurance_total
	  HAVE ALL BEEN ADDED TO THE LOCATIONS TABLE
	  
	- RECORDS have been added to the clients table corrosponding to sponsors in the old external locations table to be used as clientkeys for locations
     (if the location didnt have a sponsor the record in the clients corrosponding to individual museums was used, 'Ryans Museum', 'Andrew Museum', etc )
	
	- ns_i_clname_owner was DROPPED from the items table
	
	- external and internal locations tables were DROPPED
	
	- ADDED ns_t_item_colors TABLE
	
	- moved ns_i_icolor to colors table and DROPPED ns_i_icolor
	
	- ADDED ns_exl_security to exhibition locations
	
	
	  