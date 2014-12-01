create or replace function update_t_exhibition_locations_future_dates() returns trigger as $update_t_exhibition_locations_future_dates$
DECLARE 
dateChangeStart INTERVAL;
dateChangeEnd INTERVAL;

begin
if (OLD.exl_exldate_start <> NEW.exl_exldate_start or OLD.exl_exldate_end <> NEW.exl_exldate_end) then
dateChangeStart:= (NEW.exl_exldate_start - OLD.exl_exldate_start||' days')::INTERVAL;
dateChangeEnd:= (NEW.exl_exldate_end - OLD.exl_exldate_end||' days')::INTERVAL;
-----------------------------This occurs in the future-----------------------------------
	if (OLD.exl_Exldate_start > now() and NEW.exl_exldate_start > now()) then
		-----------------If the location was already claimed by an exhibition inform the user-------
		if ((select count(*) from t_Exhibition_locations where exl_clientkey = NEW.exl_clientkey and exl_ename <> NEW.exl_ename and exl_locname = NEW.exl_locname and (exl_exldate_start, exl_exldate_end) OVERLAPS (NEW.exl_exldate_start, NEW.exl_exldate_end)) > 0)  then
			RAISE NOTICE 'This exhibition location record is now in conflict with another exhibition that was scheduled to be there in the future.';
		END IF;
		
		--update the item_locations start date------
		update t_item_locations set ilo_ilodatetime_start = ilo_ilodatetime_start + dateChangeStart
			where ilo_inumkey in (select exi_inumkey from t_Exhibition_items where exi_ename = NEW.exl_ename and exi_exidate_start <= OLD.exl_exldate_start and exi_exidate_end >= OLD.exl_exldate_end);
			
			--update the item locaitons end date------
		update t_item_locations set ilo_ilodatetime_end = ilo_ilodatetime_end + dateChangeEnd
			where ilo_inumkey in (select exi_inumkey from t_Exhibition_items where exi_ename = OLD.exl_ename and exi_exidate_start <=  OLD.exl_exldate_start and exi_exidate_end >= OLD.exl_exldate_end);
			
		IF ((select count(*) from v_item_conflicts where numkey in (select exi_inumkey from t_Exhibition_items where exi_ename = OLD.exl_ename and exi_exidate_start <= OLD.exl_exldate_start and exi_exidate_end >= OLD.exl_exldate_end)) > 0) then
				RAISE NOTICE 'Items in this exhibition are now in conflict with future planned locations for those items';
		END IF;
		
		----------------Update the exhibitions time accordingly---------
		IF (OLD.exl_exldate_start = (select ex_showdate_start from t_Exhibitions where ex_ename = OLD.exl_ename and ex_showdate_start <= OLD.exl_exldate_start)) then
			update t_exhibitions set ex_showdate_start = ex_Showdate_start + dateChangeStart;
		END IF;
		update t_exhibitions set ex_showdate_end = ex_Showdate_start + dateChangeEnd;
		RAISE NOTICE 'The length of the future exhibition was changed accordingly.';	
	END IF;
END IF;
return new;
end;
$update_t_exhibition_locations_future_dates$ LANGUAGE PLPGSQL;

drop trigger if exists update_t_exhibition_locations_future_dates on t_exhibition_locations;
create trigger t_exhibition_locations_future_dates after update on t_exhibition_locations for each row execute procedure update_t_exhibition_locations_future_dates();
