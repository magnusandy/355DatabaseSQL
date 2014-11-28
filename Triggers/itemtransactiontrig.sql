CREATE FUNCTION update_loc_on_outermove() RETURNS TRIGGER AS $loc_outer_move$
BEGIN
IF(SELECT new.it_ittype = 'Sale' FROM t_item_transactions)
INSERT INTO t_item_locations INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where i_inumkey = new.it_inumkey), 'Sold', new.it_clname_recipient, new.it_ilodatetime_start, NULL);

ELSEIF(SELECT it_ittype = 'Purchase' FROM t_item_transactions)
INSERT INTO t_item_locations INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where i_inumkey = new.it_inumkey), 'Storage', new.it_clname_recipient, new.it_ilodatetime_start, NULL);

ELSEIF(SELECT it_ittype = 'Borrow' FROM t_item_transactions)
INSERT INTO t_item_locations INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where i_inumkey = new.it_inumkey), 'Storage', new.it_clname_recipient, new.it_ilodatetime_start, NULL);


ELSEIF(SELECT it_ittype = 'Loan' FROM t_item_transactions)
INSERT INTO t_item_locations INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
VALUES (new.it_inumkey, new.it_ialphakey, (SELECT i_clientkey from t_items where i_inumkey = new.it_inumkey), 'On Loan', new.it_clname_recipient, new.it_ilodatetime_start, NULL);


CREATE TRIGGER loc_outer_move AFTER INSERT ON
t_item_locations FOR EACH ROW EXECUTE PROCEDURE update_loc_on_outermove();
