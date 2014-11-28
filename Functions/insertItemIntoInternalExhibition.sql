create or replace function insertItemIntoInternalExhibition(numkey inumkey, alphakey ialphakey, exhibitionname ename, exstartdate showdate, iteminexhibitionstart exidate, iteminexhibitionend exidate, location locname, clientlocationkey clname) returns void as $$
DECLARE
exhibitionstartdate date;
exhibitionenddate date;
begin
exhibitionstartdate:= exstartdate;
exhibitionenddate:= (select ex_showdate_end from t_exhibitions where ex_showdate_start = exstartdate and ex_ename = exhibitionname limit 1);
if (iteminexhibitionstart > exhibitionenddate) then
raise exception 'The item cannot be in that exhibition after the exhibitions end date';

elseif (iteminexhibitionstart < exhibitionstartdate) then
raise exception 'The item cannot be in that exhibition before its start date';

elseif (iteminexhibitionstart > iteminexhibitionend) then
raise exception 'the time that the item starts in an exhibition is after its end date';

elseif (iteminexhibitionend > exhibitionenddate) then
raise exception 'An item cannot be in an exhibition after its end date';

elseif (iteminexhibitionstart < exhibitionstartdate) then
raise exception 'cannot insert an item into an exhibition before that exhibition starts';

elseif (select location not in (select exl_locname from t_exhibition_locations where exl_ename = exhibitionname and (exhibitionstartdate, exhibitionenddate) OVERLAPS (exl_exldate_start, exl_exldate_end))) then
raise exception 'Cannot insert into a location if that exhibition is not displaying in that location.';

end if;

insert into t_exhibition_items(exi_inumkey, exi_ialphakey, exi_clientkey, exi_ename, exi_showdate_start, exi_exidate_start, exi_exidate_end)
VALUES(
numkey, alphakey, (select i_clientkey from t_items where i_inumkey = numkey limit 1), exhibitionname, exstartdate, iteminexhibitionstart, iteminexhibitionend);

insert into t_item_locations(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES(numkey, alphakey, (select i_clientkey from t_items where i_inumkey = numkey limit 1), location, clientlocationkey, iteminexhibitionstart, iteminexhibitionend);
end;
$$ language plpgsql;