CREATE FUNCTION ins_item_loc() RETURNS TRIGGER AS $item_loc_ensure$
BEGIN
INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start) VALUES (new.i_inumkey, new.i_ialphakey, new.i_clientkey, 'Storage', new.i_clientkey, now());
RETURN NEW;
END;
$item_loc_ensure$ LANGUAGE plpgsql;

CREATE TRIGGER item_loc_ensure AFTER INSERT ON 
t_items FOR EACH ROW EXECUTE PROCEDURE ins_item_loc();