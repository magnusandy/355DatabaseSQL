create or replace function insertIntoItemLocationsUpdate() returns trigger as $updateItemLocationsOnInsert$
begin
update t_itemLocations set ilo_ilodatetime_end = new.ilo_ilodatetime_start
where 
        ilo_inumkey = new.ilo_inumkey
        AND
        ilo_ialphakey = new.ilo_ialphakey
        AND
        ilo_iclientkey_item = new.ilo_iclientkey_item
        AND
        ilo_ilodatetime_start = 
                (select ilo_ilodatetime_start from t_item_locations where ilo_inumkey = new.ilo_inumkey order by ilo_ilodatetime_start desc));
                --This subquery selects only the latest record for this item to update.
END;
$updateItemLocationsOnInsert$ LANGUAGE plpgsql;

DROP TRIGGER update_item_location ON t_item_locations;
CREATE TRIGGER update_item_location AFTER INSERT ON
t_item_location FOR EACH ROW EXECUTE PROCEDURE updateItemLocationsOnInsert();
                
