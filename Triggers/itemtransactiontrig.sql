CREATE FUNCTION update_loc_on_outermove() RETURNS TRIGGER AS $loc_outer_move$
BEGIN
IF(SELECT ilo_locname from t_item_locations = 'on loan' OR 
t_item_locations = 'On Loan' OR t_item_locations = 'Possessed By Lender') THEN
INSERT INTO t_item_transactions (it_inumkey, it_ialphakey, it_clientkey, it_clname, it_ittype, it_itdatetime_start,it_itdatetime_end, it_itdatetime_returnby, it_itgross)
VALUES (new.it_inumkey, new.it_ialphakey, new.it_clientkey, new.it_clname, 'Loan', new.it_itdatetime_start, new.it_itdatetime_end, new.it_itdatetime_returnby, new.it_itgross);
ELSEIF(SELECT ilo_locname from t_item_locations = 'Sold')THEN
UPDATE t_item_locations set ilo_ilodatetime_end = new.it_itdatetime_start WHERE (ilo_ilodatetime_start = ilo_ilodatetime_end and ilo_inumkey = new.it_itnumkey and ilo_ialphakey = new.it_ialphakey);