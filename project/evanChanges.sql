UPDATE t_item_transaction
	SET it_clname_recipient = 'Owner';
WHERE 
(
	(it_inumkey = 90944 AND it_ialphakey = 'weap')
	OR 
	(it_inumkey = 92759 AND it_ialphakey = 'weap')
	OR 
	(it_inumkey = 27400 AND it_ialphakey = 'armo')
	OR 
	(it_inumkey = 58190 AND it_ialphakey = 'weap')
);

--Hopefully this will set borrowing right!
