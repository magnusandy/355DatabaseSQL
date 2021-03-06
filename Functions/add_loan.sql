create or replace function add_loan(numkey inumkey, alphakey ialphakey, recipient clname, loan_datetime itdatetime, due_dateTime itdatetime) returns void as $$
declare
itemOwner clname;

begin
itemOwner:= (select i_clientkey from t_items where i_inumkey = numkey);
 
if (numkey is null or alphakey is null) then
raise exception 'You must specify both a numkey and an alphakey for the item.';

elseif ((select count(*) from t_items where i_inumkey = numkey and i_ialphakey = alphakey) <= 0) then
raise exception 'The alphakey does not match the numkey.';

elseif(select itemOwner not in (select cl_clname from v_us)) then
raise exception ' We cannot lend an item that we dont own.';


elseif (itemOwner = recipient) then
raise exception ' The owner of this item cannot borrow it';

elseif (loan_datetime > due_datetime) then
raise exception ' Cannot have a return date before the item was borrowed';

	
end if;
----ensure item is not a borrowed work or on loan----------
IF ((select count(*) from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and it_itdatetime_end is null and it_ittype in ('Borrow', 'Loan')) > 0) then
		RAISE EXCEPTION 'That item is either currently lent out';
	END IF;
	
-- Warn the user when an item is sold at midnight (they probably didn't specify a full date and time)
	IF ((SELECT EXTRACT(HOUR FROM CAST(loan_datetime AS timestamp)) = 0) 
		AND (SELECT EXTRACT(MINUTE FROM CAST(loan_datetime AS timestamp)) = 0) 
		AND (SELECT EXTRACT(SECOND FROM CAST(loan_datetime AS timestamp)) = 0)) THEN
		RAISE NOTICE 'Warning: Lending item  at midnight, are you sure you specified a date and time?';
	
end if;

insert into t_item_transactions(it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_ittype, it_itdatetime_start, it_itdatetime_returnby, it_clname_recipient, it_itgross)
VALUES(
numkey,
alphakey,
(select i_clientkey from t_items where i_inumkey = numkey),
itemOwner,
'Loan',
loan_datetime,
due_dateTime,
recipient,
0
);

end;
$$ language plpgsql;