CREATE FUNCTION update_loc_on_outermove() RETURNS TRIGGER AS $loc_outer_move$
BEGIN
IF(new.it_ittype = 'Sale') THEN
INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where (i_inumkey = new.it_inumkey and i_ialphakey = new.it_ialphakey)), 'Sold', 'Transactions', new.it_itdatetime_start, NULL);

ELSEIF(new.it_ittype = 'Purchase') THEN
INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where (i_inumkey = new.it_inumkey and i_ialphakey = new.it_ialphakey)), 'Storage', new.it_clname_recipient, new.it_itdatetime_start, NULL);

ELSEIF(new.it_ittype = 'Borrow') THEN
INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where (i_inumkey = new.it_inumkey and i_ialphakey = new.it_ialphakey)), 'Storage', new.it_clname_recipient, new.it_itdatetime_start, NULL);


ELSEIF(new.it_ittype = 'Loan') THEN
INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where (i_inumkey = new.it_inumkey and i_ialphakey = new.it_ialphakey)), 'Loan', 'Transactions', new.it_itdatetime_start, NULL);

END IF;
RETURN NEW;

END;
$loc_outer_move$ LANGUAGE plpgsql;

CREATE TRIGGER loc_outer_move AFTER INSERT ON
t_item_transactions FOR EACH ROW EXECUTE PROCEDURE update_loc_on_outermove();
