-- This trigger doesn't work, and isn't really feasible. Keeping this here for reference

/*
create or replace function updateLocationOnItemRemovedFromExhibition() returns trigger as $updateLocOnRemoveFromExhibit$
DECLARE
previous_location locname;
next_location locname;
previous_enddate ilodatetime;
next_startdate ilodatetime;
begin
	-- Get the last location enddate prior to this
	SELECT into previous_enddate max(ilo_ilodatetime_end) FROM t_item_locations
	WHERE
	(
		ilo_inumkey = OLD.exi_inumkey
		AND
		ilo_ialphakey = OLD.exi_ialphakey
		AND
		ilo_clientkey_item = OLD.exi_clientkey
		AND
		ilo_ilodatetime_end < OLD.exi_exidate_start
	);	

	-- Get the start time in the location after this
	SELECT into next_startdate min(ilo_ilodatetime_start) FROM t_item_locations
	WHERE
	(
		ilo_inumkey = OLD.exi_inumkey
		AND
		ilo_ialphakey = OLD.exi_ialphakey
		AND
		ilo_clientkey_item = OLD.exi_clientkey
		AND
		ilo_ilodatetime_start > OLD.exi_exidate_end
	);

	-- Get the previous location this item was in before being moved for this exhibition
	SELECT into previous_location ilo_locname FROM t_item_locations
	WHERE
	(
		ilo_inumkey = OLD.exi_inumkey
		AND
		ilo_ialphakey = OLD.exi_ialphakey
		AND
		ilo_clientkey_item = OLD.exi_clientkey
		AND
		ilo_ilodatetime_end = previous_enddate 
	);
	RAISE NOTICE 'numkey = % alpha = %, clientkey = %, enddate = %', OLD.exi_inumkey, OLD.exi_ialphakey, OLD.exi_clientkey, OLD.exi_exidate_end;
	RAISE NOTICE 'prev_location = %', previous_location;
	
	-- Get the next location where this item will be after this exhibition
	SELECT into next_location ilo_locname FROM t_item_locations
	WHERE
	(
		ilo_inumkey = OLD.exi_inumkey
		AND
		ilo_ialphakey = OLD.exi_ialphakey
		AND
		ilo_clientkey_item = OLD.exi_clientkey
		AND
		ilo_ilodatetime_start = next_startdate
	);
	RAISE NOTICE 'Next location = %', next_location;

	-- Remove item location record for this entry in the exhibition
	DELETE FROM t_item_locations
	WHERE
	(
		ilo_ilodatetime_start = OLD.exi_exidate_start
		AND
		ilo_ilodatetime_end = OLD.exi_exidate_end
	);

	-- Check if item is in a location after this
	IF(next_location IS NOT NULL ) THEN
		-- If it is we need to check if it was in storage before this
		RAISE NOTICE 'In a location after this';
		IF(previous_location = 'Storage') THEN
			RAISE NOTICE 'Was in storage before this';
			-- If it is we need to update the storage date end to the next time it's moved somewhere
			UPDATE t_item_locations SET ilo_ilodatetime_end = next_startdate
			WHERE
			(
				ilo_inumkey = OLD.exi_inumkey
				AND
				ilo_ialphakey = OLD.exi_ialphakey
				AND
				ilo_clientkey_item = OLD.exi_clientkey
				AND
				ilo_ilodatetime_end = OLD.exi_exidate_start
			);
		ELSE
			RAISE NOTICE 'Was not in storage before this';
			-- If it wasn't we need to add it to storage for the time it was in the location
			INSERT INTO t_item_locations
			(
				ilo_inumkey,
				ilo_ialphakey,
				ilo_clientkey_item,
				ilo_locname,
				ilo_clientkey_location,
				ilo_ilodatetime_start,
				ilo_ilodatetime_end
			) 
			VALUES
			(
				OLD.exi_inumkey,
				OLD.exi_ialphakey,
				OLD.exi_clientkey,
				'Storage',
				OLD.exi_clientkey,
				OLD.exi_exidate_start,
				OLD.exi_exidate_end
			);
		END IF;
	ELSE
		-- If it isn't then we need to check if it was in storage before
		RAISE NOTICE 'Not in a location after this';
		IF(previous_location = 'Storage') THEN
			RAISE NOTICE 'Was in storage before';
			-- If it was we can just extend this to indefinite by nulling the end date
			UPDATE t_item_locations SET ilo_ilodatetime_end = NULL
			WHERE
			(
				ilo_inumkey = OLD.exi_inumkey
				AND
				ilo_ialphakey = OLD.exi_ialphakey
				AND
				ilo_clientkey_item = OLD.exi_clientkey
				AND
				ilo_ilodatetime_end = OLD.exi_exidatetime_start
			);
		ELSE 
			RAISE NOTICE 'Was not in storage before';
			-- Otherwise we need to add a storage record to replace the time we've removed from its location
			INSERT INTO t_item_locations
			(
				ilo_inumkey,
				ilo_ialphakey,
				ilo_clientkey_item,
				ilo_locname,
				ilo_clientkey_location,
				ilo_ilodatetime_start,
				ilo_ilodatetime_end
			)
			VALUES
			(
				OLD.exi_inumkey,
				OLD.exi_ialphakey,
				OLD.exi_clientkey,
				'Storage',
				OLD.exi_clientkey,
				OLD.exi_exidate_start,
				NULL
			);
		END IF;
	END IF;

RETURN OLD;
END;
$updateLocOnRemoveFromExhibit$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS update_location_on_removed_from_exhibition ON t_exhibition_items;
CREATE TRIGGER update_location_on_removed_from_exhibition AFTER DELETE ON
t_exhibition_items FOR EACH ROW WHEN (OLD.exi_exidate_start > current_date) EXECUTE PROCEDURE updateLocationOnItemRemovedFromExhibition();
*/
