CREATE FUNCTION ins_oppo_door() RETURNS TRIGGER AS $oppo_door$
BEGIN
IF((SELECT COUNT(*) FROM t_location_doors WHERE  lodor_locname_entrance = new.lodor_locname_exit and lodor_locname_exit = new.lodor_locname_entrance) = 0) THEN
INSERT INTO t_location_doors (lodor_locname_entrance, lodor_clientkey_entrance, lodor_locname_exit, lodor_clientkey_exit) VALUES (new.lodor_locname_exit, new.lodor_clientkey_entrance, new.lodor_locname_entrance, new.lodor_clientkey_exit);
END IF;
RETURN NEW;
END;
$oppo_door$ LANGUAGE plpgsql;

CREATE TRIGGER oppo_door AFTER INSERT ON 
t_location_doors FOR EACH ROW EXECUTE PROCEDURE ins_oppo_door();