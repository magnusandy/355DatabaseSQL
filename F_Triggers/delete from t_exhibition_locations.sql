


create or replace function delete_t_exhibition_locations() returns trigger as $delete_t_exhibition_locations$
begin
IF (OLD.exl_exldate_end < now()) then 
raise exception 'You should not delete from a past record! The exhibition was already recorded to be in that location';

ELSEIF (OLD.exl_exldate_end > now()) then
 delete from t_item_locations where 
 ilo_locname = OLD.exl_locname 
 --item location is between the two dates for this location.
 and cast(ilo_ilodatetime_start as date) >= OLD.exl_exldate_start and (cast(ilo_ilodatetime_end as date) <= OLD.exl_exldate_end or ilo_ilodatetime_end is null)
 --the item is actually part of that exhibition during those dates.
 and ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = OLD.exl_ename and (OLD.exl_exldate_start, OLD.exl_exldate_end) OVERLAPS (exi_exidate_start, exi_exidate_end)  );
 
 RAISE NOTICE  'You have made gaps in the future plans for these exhibition locations and for the items planned locations. You should probably fix this.';
 return OLD;  --perform the deletion now.
 
 ELSEIF (OLD.exl_exldate_start <= now() and OLD.exl_exldate_end >= now()) then
	OLD.exl_exldate_end:= null;
	update t_item_locations set ilo_ilodatetime_end = now() where 
	ilo_locname = OLD.exl_locname 
 --item location is between the two dates for this location.
 and cast(ilo_ilodatetime_start as date) >= OLD.exl_exldate_start and (cast(ilo_ilodatetime_end as date) <= OLD.exl_exldate_end or ilo_ilodatetime_end is null)
 --the item is actually part of that exhibition during those dates.
 and ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = OLD.exl_ename and (OLD.exl_exldate_start, OLD.exl_exldate_end) OVERLAPS (exi_exidate_start, exi_exidate_end));
 
 RAISE NOTICE  'You have made gaps in the exhibitions planned locations and the items current locations have been set to null. These items should be scheduled to be moved immediately. Please be aware that you should insert the items and the exhibitions next locations now.';
 
 return null;
 
 END IF;
 
end;
$delete_t_exhibition_locations$ LANGUAGE PLPGSQL;

drop trigger if exists delete_t_exhibition_locations on t_exhibition_locations;
create trigger delete_t_exhibition_locations before delete on t_exhibition_locations for each row execute procedure delete_t_exhibition_locations();


