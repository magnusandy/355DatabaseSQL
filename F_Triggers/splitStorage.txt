create or replace function splitStorage() returns trigger as $splitStorage$
declare
storageStartDate ilodatetime;
storageEndDate ilodatetime;
location locname;
itemClientKey clname;
locationClientKey clname;

begin
if ((select count(*) from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey and ilo_ilodatetime_end is not null) = 1) then
--Grab all of the information on the storage location we are inserting into before we finish.
		if ((select ilo_locname from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey) = 'Storage') then
			storageStartDate:= ((select ilo_ilodatetime_start from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey));
			storageEndDate:= ((select ilo_ilodatetime_End from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey));
			location:= (select ilo_locname from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey);
			itemClientKey:= (select ilo_clientkey_item from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey);
			locationClientKey:= (select ilo_clientkey_location from t_item_locations where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey);
			
			--make a gap for the new record to be inserted into.
			update t_item_locations set ilo_ilodatetime_end = NEW.ilo_ilodatetime_start where (ilo_ilodatetime_start, ilo_ilodatetime_end) OVERLAPS (NEW.ilo_ilodatetime_start, NEW.ilo_ilodatetime_end) and NEW.ilo_inumkey = ilo_inumkey and NEW.ilo_ialphakey = ilo_ialphakey;
		
			insert into t_item_locations(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
			VALUES(NEW.ilo_inumkey, NEW.ilo_ialphakey, itemClientKey, location, locationClientKey, new.ilo_ilodatetime_end, storageEndDate);
			
		ELSE
			raise exception 'That item is already promised to a prior location.';
		END IF;
END IF;
return NEW; --the new record is automatically inserted into the new space.
END;
$splitStorage$ language plpgsql;

create trigger splitStorage before insert on t_item_locations for each row execute procedure splitStorage();	