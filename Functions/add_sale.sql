CREATE OR REPLACE FUNCTION sell_item(item_number inumkey, item_code ialphakey, client clname, sale_date itdatetime) RETURNS VOID AS $f_sellitem$
DECLARE
current_owner clname;
BEGIN
	-- Ensure passed variables are not null
        IF(item_number IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell an item with an unknown item_number';
	END IF;

	IF(item_code IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell an item with an unknown item_code';
	END IF;

	IF(client IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell item % % to an unknown client', item_number, item_code;
	END IF;

	IF(sale_date IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell item % % to % on an unknown date', item_number, item_code, client;
	END IF;

	-- Ensure the item specified actually exists
	IF NOT(SELECT EXISTS (SELECT 1 FROM t_items WHERE i_inumkey = item_number AND i_ialphakey = item_code)) THEN
		RAISE EXCEPTION 'Cannot sell item % % because it does not exists', item_number, item_code;
	END IF;

	-- Ensure the specified client actually exists
	IF NOT(SELECT EXISTS (SELECT 1 FROM t_clients WHERE cl_clname = client)) THEN
		RAISE EXCEPTION 'Cannot sell item % % to client % because no client with that name exists', item_number, item_code, client;
	END IF;

	-- Ensure one of us is the owner
        SELECT INTO current_owner i_clientkey FROM t_items WHERE (i_inumkey = item_number AND i_ialphakey = item_code);

	IF NOT(SELECT EXISTS (SELECT 1 FROM v_us WHERE cl_clname = current_owner LIMIT 1)) THEN
		RAISE EXCEPTION 'Cannot sell item % % because it belongs to %, not one of our museums', item_number, item_code, current_owner;
	END IF;

	-- Ensure that current owner and seller are not the same
	IF (client = current_owner) THEN
		RAISE EXCEPTION 'Cannot sell item % % because the client already owns it', item_number, item_code;
	END IF;

	-- Warn the user when an item is sold at midnight (they probably didn't specify a full date and time)
	IF ((SELECT EXTRACT(HOUR FROM CAST(sale_date AS timestamp)) = 0) 
		AND (SELECT EXTRACT(MINUTE FROM CAST(sale_date AS timestamp)) = 0) 
		AND (SELECT EXTRACT(SECOND FROM CAST(sale_date AS timestamp)) = 0)) THEN
		RAISE NOTICE 'Warning: selling item % % at midnight, are you sure you specified a date and time?', item_number, item_code;
	END IF;

END;
$f_sellitem$ LANGUAGE plpgsql;
