BEGIN;
CREATE FUNCTION sell_item(item_number real, item_code varchar(50), client varhcar(50)) RETURNS VOID AS $f_sellitem$
DECLARE
current_owner clname;
BEGIN
	-- Check if passed variables are not null
        IF(item_number IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell an item with no item_number';
	END IF;

	IF(item_code IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell an item with no item_code';
	END IF;

	IF(client IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell and item with no client';
	END IF;

	-- Ensure the item specified actually exists
	IF NOT(SELECT EXISTS (SELECT 1 FROM t_items WHERE i_inumkey = item_number AND i_ialphakey = item_code)) THEN
		RAISE EXCEPTION 'Cannot sell item % % because it does not exists', item_number, item_code;
	END IF;

	-- Check if one of us is the owner
        SELECT INTO current_owner i_clientkey FROM t_items WHERE (i_inumkey = item_number AND i_alphakey = item_code);

	IF NOT(SELECT EXISTS (SELECT 1 FROM v_us WHERE cl_name = current_owner LIMIT 1)) THEN
		RAISE EXCEPTION 'Cannot sell item % % because it belongs to %', item_number, item_code, current_owner;
	END IF;

END;
$f_sellitem$ LANGUAGE plpgsql;
