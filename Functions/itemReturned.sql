create or replace function itemReturned(numkey inumkey, alphakey ialphakey, dateReturned itDateTime) returns void as $$
DECLARE
dueDate timestamp; --the date that the item was supposed to be returned.
itType ittype;   --The type of transaction the item is involved in.

begin
IF ((select count(*) from t_items where i_inumkey = numkey and i_ialphakey = alphakey) <= 0) then
	RAISE EXCEPTION 'The combination numkey: %, alphakey % do not map to an item in the database', numkey, alphakey;

----------------------------------Ensure the item is actually lent out or borrowed----------------
ELSEIF ((select count(*) from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and  (it_ittype = 'Loan' or it_ittype = 'Borrow') and it_itdatetime_end is null) <= 0) then
	raise exception 'That item is not currently lent out or borrowed.';
	
ELSEIF ((dateReturned > now())) then
	RAISE EXCEPTION 'You cannot claim an item will be returned in the future! Given Date: %', dateReturned;
END IF;

----------If the given return date was null, assume it was meant to be now.------------
IF (dateReturned is null) then
	dateReturned:= now();
END IF;

itType:= (select it_ittype from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and  (it_ittype = 'Loan' or it_ittype = 'Borrow'));
dueDate:= (select it_itdatetime_returnby from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and  (it_ittype = 'Loan' or it_ittype = 'Borrow') and it_itdatetime_end is null);

------------Inform the user if the item was returned late--------------------------
IF (dateReturned > dueDate) then
	RAISE NOTICE 'This item was returned % days late',  (EXTRACT(day from dateReturned)  - EXTRACT(day from dueDate));
END IF;

------------If the item was borrowed put it with the lender----------------------
IF (itType = 'Borrow') then
	insert into t_item_locations(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location,ilo_ilodatetime_start)
	VALUES(numkey, 
	alphakey, 
	(select i_clientkey from t_items where i_inumkey = numkey), 
	'Possessed By Lender', 
	'Ryans Museum', 
	dateReturned);
	RAISE NOTICE 'Item put into location Posessed By Lender';
-----------------if the item was loaned, put it back into storage--------------
ELSEIF (itType = 'Loan') then
	insert into t_item_locations(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start)
	VALUES(numkey, 
	alphakey, 
	(select i_clientkey from t_items where i_inumkey = numkey), 
	'Storage', 
	(select it_clientkey from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and  (it_ittype = 'Loan' or it_ittype = 'Borrow') and it_itdatetime_end is null), 
	dateReturned);
	RAISE NOTICE 'Item put into Storage';
END IF;

--------------update the item transaction record with the new return date------------
update t_item_transactions set it_itdatetime_end = dateReturned where it_inumkey = numkey and it_ialphakey = alphakey and  (it_ittype = 'Loan' or it_ittype = 'Borrow') and it_itdatetime_end is null;

---------------------if the item was borrowed, it may have to be pulled out of some exhibition(s)-------------------
IF (itType = 'Borrow') then
	if ((select count(*) from t_exhibition_items where exi_exidate_start <= dateReturned  and exi_exidate_end >= dateReturned and exi_inumkey = numkey) > 0) then
		RAISE NOTICE 'Item pulled out of exhibition: %', (select exi_ename from t_exhibition_items where exi_exidate_start <= dateReturned  and exi_exidate_end >= dateReturned and exi_inumkey = numkey limit 1);
		IF ((select exi_exidate_start from t_exhibition_items where exi_exidate_start <= dateReturned  and exi_exidate_end >= dateReturned and exi_inumkey = numkey) > now()) then
			delete from t_exhibition_items  where exi_exidate_start <= dateReturned  and exi_exidate_end >= dateReturned and exi_inumkey = numkey;
		ELSE
			update t_exhibition_items set exi_exidate_end = dateReturned where exi_exidate_start <= dateReturned  and exi_exidate_end >= dateReturned and exi_inumkey = numkey;
		END IF;
	END IF;
END IF;
end;
$$ LANGUAGE PLPGSQL;

