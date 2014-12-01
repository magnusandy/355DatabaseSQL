CREATE OR REPLACE FUNCTION add_sale(item_number inumkey, item_code ialphakey, client clname, sale_date itdatetime, value itgross) RETURNS VOID AS $f_sellitem$
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

	IF(value IS NULL) THEN
		RAISE EXCEPTION 'Unable to sell item % % to % with an unknown transaction value', item_number, item_code, client;
	END IF;

	-- Ensure date date is not in the past (We shouldn't really be using standard day-to-day transactions to alter historical information)
	IF(sale_date < current_timestamp) THEN
		RAISE EXCEPTION 'Unable to sell item % % to % if the sale date has already passed. Please speak with the database administrator if this was not an input error', item_number, item_code, client;
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
	
	-------ensure the item is not loaned out or borrowed.------
	IF ((select count(*) from t_item_transactions where it_inumkey = numkey and it_ialphakey = alphakey and it_itdatetime_end is null and it_ittype in ('Borrow', 'Loan')) > 0) then
		RAISE EXCEPTION 'That item is either currently lent out or is a borrowed work.';
	END IF;
	
	-- Add the sale transaction
	INSERT INTO t_item_transactions
	(
		it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_clname_recipient, it_ittype, it_itdatetime_start, it_itgross
	)
	VALUES
	(
		item_number, item_code, current_owner, current_owner, client, 'Sale', sale_date, value 
	);
END;
$f_sellitem$ LANGUAGE plpgsql;
