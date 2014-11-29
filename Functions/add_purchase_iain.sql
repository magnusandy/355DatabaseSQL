CREATE OR REPLACE FUNCTION buy_item(item_number inumkey, item_code ialphakey, recipient clname, purchase_date itdatetime, value itgross) RETURNS VOID AS $f_buyitem$
DECLARE
current_owner clname;
BEGIN
	-- Ensure passed variables are not null
	IF(item_number IS NULL) THEN
		RAISE EXCEPTION 'Unable to buy an item with an unknown item_number';
	END IF;

	IF(item_code IS NULL) THEN
		RAISE EXCEPTION 'Unable to buy an item with an unknown item_code';
	END IF;

	IF(client IS NULL) THEN
		RAISE EXCEPTION 'Unable to buy item % % with unknown client', item_number, item_code;
	END IF;
	
	IF(purchase_date IS NULL) THEN
		RAISE EXCEPTION 'Unable to buy item % % for % on an unknown date', item_number, item_code, client;
	END IF;

	IF(value IS NULL) THEN
		RAISE EXCEPTION 'Unable to buy item % % for % with an unknown transaction value', item_number, item_code, client;
	END IF;

	-- Ensure date date is not in the past (We shouldn't really be using standard day-to-day transactions to alter historical information)
	if(sale_date < current_timestamp) THEN
		RAISE EXCEPTION 'Unable to sell item % % to % if the sale date has already passed. Please speak with the database administrator if this was not an input error', item_number, item_code, client;
	END IF;

	-- Ensure the item specified actually exists
	IF NOT(SELECT EXISTS (SELECT 1 FROM t_items WHERE i_inumkey = item_number AND i_ialphakey = item_code)) THEN
		RAISE EXCEPTION 'Cannot buy item % % because it does not exists', item_number, item_code;
	END IF;
	
	-- Ensure one of is the recipeint
	IF NOT(SELECT EXISTS (SELECT 1 FROM v_us WHERE cl_clname = recipient LIMIT 1)) THEN
		RAISE EXCEPTION 'Cannot buy item % % because the purchaser % is not one of our museums', item_number, item_code, recipient;
	END IF;
        
	-- Get the current owner
        SELECT INTO current_owner i_clientkey FROM t_items WHERE (i_inumkey = item_number AND i_ialphakey = item_code);

	-- Ensure that current owner and purchaser are not the same
	IF (recipient = current_owner) THEN
		RAISE EXCEPTION 'Cannot buy item % % because the recipient already owns it', item_number, item_code;
	END IF;

	-- Warn the user when an item is sold at midnight (they probably didn't specify a full date and time)
	IF ((SELECT EXTRACT(HOUR FROM CAST(purchase_date AS timestamp)) = 0)
		AND (SELECT EXTRACT(MINUTE FROM CAST(purchase_date AS timestamp)) = 0)
		AND (SELECT EXTRACT(SECOND FROM CAST(purchase_date AS timestamp)) = 0)) THEN
			RAISE NOTICE 'Warning: buying item % % at midnight, are you sure you specified a date and time?', item_number, item_code;
	END IF;

	-- Add the sale transaction
	INSERT INTO v_item_transactions
	(
		it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_clname_recipient, it_ittype, it_itdatetime_start, it_itgross
	)
	VALUES
	(
		item_number, item_code, current_owner, current_owner, recipient, 'Purchase', purchase_date, value
	);

	-- Update the client key of the item to the new client
	UPDATE v_items SET i_clientkey = recipient WHERE i_inumkey = item_number AND i_ialphakey = item_code;

	-- Check if the item is not currently in a location
	IF NOT(SELECT EXISTS (SELECT 1 FROM t_item_locations WHERE
		ilo_inumkey = item_number AND ilo_ialphakey = item_code AND 
		(
			ilo_ilodatetime_start < CAST(purchase_date AS ilodatetime) AND
			(
				ilo_ilodatetime_end > CAST(purchase_date AS ilodatetime)
				OR
				ilo_ilodatetime_end IS NULL
			)
		)
		)) THEN
		
		INSERT INTO t_item_locations (ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start)
		VALUES
		(item_number, item_code, recipient, 'Storage', recipient, purchase_date);
	END IF;

	
END;
$f_buyitem$ LANGUAGE plpgsql;
