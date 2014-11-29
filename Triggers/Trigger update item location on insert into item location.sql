create function insertIntoItemLocationsUpdate() returns trigger as $updateItemLocationsOnInsert$
begin
update t_itemLocations set ilo_ilodatetime_end = new.ilo_ilodatetime_start
where 
        ilo_inumkey = new.ilo_inumkey and ilo_ilodatetime_end is null
        and ilo_ilodatetime_start = 
                (select ilo_ilodatetime_start from t_item_locations where ilo_inumkey = new.ilo_inumkey order by ilo_ilodatetime_start desc));
                --This subquery selects only the latest record for this item to update.