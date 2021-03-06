create or replace function add_purchase(numkey inumkey, alphakey ialphakey, buyer clname, timeOfTransaction itdatetime, cost itgross) returns void as $$
begin
if (numkey is null or alphakey is null) then
raise exception 'Error: You must have given both the numkey and the alphakey.';

elseif (buyer is null) then
raise exception 'Error: You must have specified a buyer.';

elseif (select buyer not in (select cl_clname from v_us)) then
raise Exception 'Error: The buyer must be one of our museums: Iain, Ryans Museum, Evan Closson, Andrew Museum, Walker Art Center';

elseif (cost is null) then
raise exception ' Error: You must have specified a cost for the transactions. If the transactions has a cost of 0, specify 0';

elseif NOT (select exists (select 1 FROM t_items WHERE i_inumkey = numkey AND i_ialphakey = alphakey)) then
raise exception 'Error: The given keys do not map to an item in the database. Please insert the item first.';

elseif (select buyer in (select i_clientkey from t_items where i_inumkey = numkey limit 1)) then
raise exception 'The buyer cannot buy from himself.';

end if;

if (timeOfTransaction is null) then
raise warning 'Warning: You have not specified the date that the transaction occurred, the default is set to the current time';

insert into t_item_transactions(it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_clname_recipient, it_ittype, it_itdatetime_start, it_itgross)
VALUES(
numkey, 
alphakey, 
(select i_clientkey from t_items where i_inumkey = numkey limit 1), 
(select i_clientkey from t_items where i_inumkey = numkey limit 1),
buyer, 
'Purchase', 
now(), --default if time was not entered
cost);

else
insert into t_item_transactions(it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_clname_recipient, it_ittype, it_itdatetime_start, it_itgross)
VALUES(numkey, 
alphakey, 
(select i_clientkey from t_items where i_inumkey = numkey limit 1),
(select i_clientkey from t_items where i_inumkey = numkey limit 1),
buyer, 
'Purchase', 
timeOfTransaction, 
cost);
end if;

end;
$$ language plpgsql;
