create or replace function insertIntoItemLocationsUpdate() returns trigger as $updateItemLocationsOnInsert$
begin
update t_item_locations set ilo_ilodatetime_end = new.ilo_ilodatetime_start
where 
        ilo_inumkey = new.ilo_inumkey
        AND
        ilo_ialphakey = new.ilo_ialphakey
        AND
        ilo_clientkey_item = new.ilo_clientkey_item
        AND
        ilo_ilodatetime_start = 
                (
			select 
			MAX(ilo_ilodatetime_start)
			from t_item_locations 
			where 
				ilo_inumkey = new.ilo_inumkey 
				AND 
				ilo_ialphakey = NEW.ilo_ialphakey 
				AND 
				ilo_clientkey_item = NEW.ilo_clientkey_item 
		)
	AND
	ilo_ilodatetime_start < new.ilo_ilodatetime_start;
                --This subquery selects only the latest record for this item to update.
RETURN NEW;
END;
$updateItemLocationsOnInsert$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_item_location ON t_item_locations;
CREATE TRIGGER update_item_location BEFORE INSERT ON
t_item_locations FOR EACH ROW EXECUTE PROCEDURE insertIntoItemLocationsUpdate();
                
