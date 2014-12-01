CREATE OR REPLACE FUNCTION update_loc_on_outermove() RETURNS TRIGGER AS $loc_outer_move$
DECLARE
	current_owner clname;
BEGIN

	-- Get the current owner of the item
	current_owner = NEW.it_clname_proprietor;

	-----------------------------------
	-- Sale
	-----------------------------------
	IF(new.it_ittype = 'Sale') THEN
	
		RAISE NOTICE 'New.it_itdatetime_start is %', NEW.it_itdatetime_start;	
		-- Remove from all future planned exhibitions
		DELETE FROM v_exhibition_items
        	WHERE
	        (
			exi_inumkey = NEW.it_inumkey
			AND
			exi_ialphakey = NEW.it_ialphakey
			AND
			exi_clientkey = current_owner
			AND
			exi_exidate_start > CAST(NEW.it_itdatetime_start AS exidate)
		);

        	-- Update the end date if the item is currently in an exhibition at the sale date
        	UPDATE v_exhibition_items
	        SET
		exi_exidate_end = CAST(NEW.it_itdatetime_start AS exidate)
		WHERE
		(
			exi_inumkey = NEW.it_inumkey 
			AND
			exi_ialphakey = NEW.it_ialphakey
		        AND
			exi_clientkey = current_owner
			AND
			(
				exi_exidate_start < CAST(NEW.it_itdatetime_start AS exidate)
				AND
				(exi_exidate_end > CAST(NEW.it_itdatetime_start AS exidate) OR exi_exidate_end IS NULL)
			)
		);

        	-- Remove from planned locations which the item is in after the sale date
       		DELETE FROM v_item_locations
        	WHERE
        	(
			ilo_inumkey = NEW.it_inumkey  
			AND 
			ilo_ialphakey = NEW.it_ialphakey
		        AND
			ilo_clientkey_item = current_owner	
			AND 
			ilo_ilodatetime_start > CAST(NEW.it_itdatetime_start AS ilodatetime)
		);	

		-- Move the item to the 'Sold' location
		INSERT INTO v_item_locations 
		(
			ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end
		)
		VALUES 
		(
			new.it_inumkey, new.it_ialphakey, current_owner, 'Sold', 'Transactions', NEW.it_itdatetime_start, NULL
		);
		
		-- Update the owner of the item to be the new owner
                UPDATE v_items SET i_clientkey = NEW.it_clname_recipient WHERE (i_inumkey = NEW.it_inumkey AND i_ialphakey = NEW.it_ialphakey AND i_clientkey = NEW.it_clname_proprietor);
		

	--------------------------------------
	-- Purchase
	--------------------------------------
	ELSEIF(new.it_ittype = 'Purchase') THEN
		
		-- Check if the item is not currently in a location
        	IF NOT
		(SELECT EXISTS 
			(SELECT 1 FROM t_item_locations 
				WHERE 
				ilo_inumkey = NEW.it_inumkey 
				AND 
				ilo_ialphakey = NEW.it_ialphakey
			        AND
				ilo_clientkey_item = current_owner	
				AND 
				(
					ilo_ilodatetime_start < CAST(NEW.it_itdatetime_start AS ilodatetime) 
					AND
					(
						ilo_ilodatetime_end > CAST(NEW.it_itdatetime_start AS ilodatetime) 
						OR 
						ilo_ilodatetime_end IS NULL
					)
				)
			)
		) THEN
	       		-- If it isn't in a location at the moment, add it to storage 	
			INSERT INTO v_item_locations 
				(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start) 
				VALUES
				(NEW.it_inumkey, new.it_ialphakey, new.it_clientkey, 'Storage', NEW.it_clname_recipient, CAST(NEW.it_itdatetime_start AS ilodatetime));
		END IF;
                
		-- Update the owner of the item to the recipient and the acquisition date to be the sale date
                UPDATE v_items SET i_clientkey = NEW.it_clname_recipient, i_iacquisitiondate = CAST(NEW.it_itdatetime_start AS iacquisitiondate) WHERE i_inumkey = NEW.it_inumkey AND i_ialphakey = NEW.it_ialphakey AND i_clientkey = NEW.it_clname_recipient;

	----------------------------------
	-- Borrow
	----------------------------------
	ELSEIF(new.it_ittype = 'Borrow') THEN
		-- Put the borrowed item into storage
		INSERT INTO v_item_locations 
			(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
		VALUES 
			(new.it_inumkey, new.it_ialphakey, current_owner, 'Storage', new.it_clname_recipient, CAST(new.it_itdatetime_start AS ilodatetime), NULL);

	----------------------------------
	-- Loan
	----------------------------------
	ELSEIF(new.it_ittype = 'Loan') THEN
		
	        -- Remove from all future planned exhibitions
                DELETE FROM v_exhibition_items 
		WHERE
		(
			exi_inumkey = NEW.it_inumkey
		       	AND
		       	exi_ialphakey = NEW.it_ialphakey
		       	AND
		       	exi_clientkey = current_owner
		       	AND
		       	exi_exidate_start > CAST(NEW.it_itdatetime_start AS exidate)
		);

		-- Update the end date if the item is currently in an exhibition at the loan date
		UPDATE v_exhibition_items
		SET
			exi_exidate_end = CAST(NEW.it_itdatetime_start AS exidate)
		WHERE
		(
			exi_inumkey = NEW.it_inumkey
			AND
			exi_ialphakey = NEW.it_ialphakey
			AND
			exi_clientkey = current_owner
			AND
			(				
				exi_exidate_start < CAST(NEW.it_itdatetime_start AS exidate)
				AND
				(exi_exidate_end > CAST(NEW.it_itdatetime_start AS exidate) OR exi_exidate_end IS NULL) 
			)
		);

		-- Remove from future planned locations after the loan date
		DELETE FROM v_item_locations
		WHERE
		(
			ilo_inumkey = NEW.it_inumkey
			AND
			ilo_ialphakey = NEW.it_ialphakey 
			AND
			ilo_clientkey_item = current_owner
			AND
			ilo_ilodatetime_start > CAST(NEW.it_itdatetime_start AS ilodatetime)
		);

		-- Update the end date of the location the item is currently in
		UPDATE v_item_locations
		SET
		ilo_ilodatetime_end = CAST(NEW.it_itdatetime_start AS ilodatetime)
		WHERE
		(
			ilo_inumkey = NEW.it_inumkey
			AND
			ilo_ialphakey = NEW.it_ialphakey
			AND
			ilo_clientkey_item = current_owner
			AND
			(
				ilo_ilodatetime_start < CAST(NEW.it_itdatetime_start AS ilodatetime)
				AND
				(ilo_ilodatetime_end > CAST(NEW.it_itdatetime_start AS ilodatetime) OR ilo_ilodatetime_end IS NULL)
			)
		);

		-- Put the loaned item into the 'Loan' location
                INSERT INTO v_item_locations
			(ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_locname, ilo_clientkey_location, ilo_ilodatetime_start, ilo_ilodatetime_end)
			VALUES 
			(new.it_inumkey, new.it_ialphakey, current_owner, 'Loan', 'Transactions', new.it_itdatetime_start, NULL);
	END IF;

	RETURN NEW;

END;
$loc_outer_move$ LANGUAGE plpgsql;

DROP TRIGGER loc_outer_move ON t_item_transactions;
CREATE TRIGGER loc_outer_move AFTER INSERT ON
t_item_transactions FOR EACH ROW EXECUTE PROCEDURE update_loc_on_outermove();
