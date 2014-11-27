BEGIN;

-- Add Recipient column to t_item_transactions
ALTER TABLE t_item_transactions ADD COLUMN it_clname_recipient clname;

-- Copy across date in current clname column into recipient
UPDATE t_item_transactions SET it_clname_recipient = it_clname;

-- Rename current clname column to proprietor
ALTER TABLE t_item_transactions RENAME it_clname TO it_clname_proprietor;

-- Make recipient a FK to client
ALTER TABLE t_item_transactions ADD CONSTRAINT it_clname_recipient_cl_clname FOREIGN KEY (it_clname_recipient) REFERENCES t_clients(cl_clname);

-- Create a temporary view that can be used to easily view the effects
CREATE VIEW v_temptransactions AS SELECT it_inumkey, it_ialphakey, it_clientkey, it_clname_recipient, it_clname_proprietor, it_ittype FROM t_item_transactions;

-- Assume that the proprietor of a loan is the owner of the work
UPDATE t_item_transactions
	SET it_clname_proprietor = it_clientkey
WHERE
(
	it_ittype = 'Loan'
);

-- Evans
UPDATE t_item_transactions
	SET it_clname_recipient = 'Evan Closson'
WHERE
(
	(it_inumkey = 92619 AND it_ialphakey = 'armo')
	OR
	(it_inumkey = 95516 AND it_ialphakey = 'bone')
	OR
	(it_inumkey = 41967 AND it_ialphakey = 'crys')
	OR
	(it_inumkey = 30745 AND it_ialphakey = 'neph')
	OR
	(it_inumkey = 12693 AND it_ialphakey = 'crys')
	OR
	(it_inumkey = 48105 AND it_ialphakey = 'crys')
	OR
	(it_inumkey = 16749 AND it_ialphakey = 'crys')
	OR
	(it_inumkey = 50577 AND it_ialphakey = 'plag')
	OR
	(it_inumkey = 98119 AND it_ialphakey = 'silv')
	OR
	(it_inumkey = 32920 AND it_ialphakey = 'copp')
	OR
	(it_inumkey = 41312 AND it_ialphakey = 'crys')
	OR
	(it_inumkey = 97139 AND it_ialphakey = 'coin')
	OR
	(it_inumkey = 26895 AND it_ialphakey = 'spea')
	OR
	(it_inumkey = 40853 AND it_ialphakey = 'scra')
	OR
	(it_inumkey = 93931 AND it_ialphakey = 'axes')
	OR
	(it_inumkey = 93815 AND it_ialphakey = 'carr')
	OR
	(it_inumkey = 99423 AND it_ialphakey = 'cont')
	OR
	(it_inumkey = 10760 AND it_ialphakey = 'mirr')
	OR
	(it_inumkey = 47427 AND it_ialphakey = 'sedi')
	OR
	(it_inumkey = 22256 AND it_ialphakey = 'meta')
	OR
	(it_inumkey = 92719 AND it_ialphakey = 'ring')
	OR
	(it_inumkey = 92220 AND it_ialphakey = 'silv')
	OR
	(it_inumkey = 92215 AND it_ialphakey = 'neck')
	OR
	(it_inumkey = 93917 AND it_ialphakey = 'figu')
	OR
	(it_inumkey = 95228 AND it_ialphakey = 'vess')
	OR
	(it_inumkey = 93835 AND it_ialphakey = 'weap')
	OR
	(it_inumkey = 91113 AND it_ialphakey = 'armo')
	OR
	(it_inumkey = 97499 AND it_ialphakey = 'weap')
	OR
	(it_inumkey = 95521 AND it_ialphakey = 'meda')
	OR
	(it_inumkey = 93034 AND it_ialphakey = 'weap')
	OR
	(it_inumkey = 93149 AND it_ialphakey = 'armo')
	OR
	(it_inumkey = 93911 AND it_ialphakey = 'insc')
	OR
	(it_inumkey = 99223 AND it_ialphakey = 'weap')
	OR
	(it_inumkey = 91430 AND it_ialphakey = 'kniv')
	OR
	(it_inumkey = 44500 AND it_ialphakey = 'bask')
	OR
	(it_inumkey = 93780 AND it_ialphakey = 'tabl')
	OR
	(it_inumkey = 94363 AND it_ialphakey = 'horn')
	OR
	(it_inumkey = 95946 AND it_ialphakey = 'wars')
	OR
	(it_inumkey = 97713 AND it_ialphakey = 'wars')
	

);

UPDATE t_item_transactions
	SET it_clname_proprietor = 'Evan Closson'
WHERE
(
	(it_inumkey = 93131 AND it_ialphakey = 'disc')
	OR
	(it_inumkey = 91444 AND it_ialphakey =  'vess')
	OR
	(it_inumkey = 84700 AND it_ialphakey = 'wars')

);
-- Andrews

UPDATE t_item_transactions
	SET it_clname_recipient = 'Andrew Museum'
WHERE
(
	(it_inumkey = 10125166 AND it_ialphakey = 'FTD')
	OR
	(it_inumkey = 19761933 AND it_ialphakey = 'FCA')
	OR
	(it_inumkey = 10125391 AND it_ialphakey = 'FCL')
	OR
	(it_inumkey = 19826091 AND it_ialphakey = 'BFS')
	OR
	(it_inumkey = 19845072 AND it_ialphakey = 'CIO')
	OR
	(it_inumkey = 19921732 AND it_ialphakey = 'FCS')
	OR
	(it_inumkey = 20006625 AND it_ialphakey = 'CFC')
	OR
	(it_inumkey = 20006628 AND it_ialphakey = 'CFG')
	OR
	(it_inumkey = 20074982 AND it_ialphakey = 'JBB')
	OR
	(it_inumkey = 41160409 AND it_ialphakey = 'BDB')
	OR
	(it_inumkey = 74513367 AND it_ialphakey = 'JEG')
	OR
	(it_inumkey = 19812321 AND it_ialphakey = 'JAT')
	OR
	(it_inumkey = 18110027 AND it_ialphakey = 'FTM')
	OR
	(it_inumkey = 19826072 AND it_ialphakey = 'FSS')
	OR
	(it_inumkey = 20004562 AND it_ialphakey = 'JEE')
	OR
	(it_inumkey = 20043615 AND it_ialphakey = 'CVT')
	OR
	(it_inumkey = 40170201 AND it_ialphakey = 'JAR')
);

UPDATE t_item_transactions
	SET it_clname_proprietor = 'Andrew Museum'
WHERE
(
	(it_inumkey = 15240 AND it_ialphakey = 'CMF')
	OR
	(it_inumkey = 25228 AND it_ialphakey = 'CFW')
	OR
	(it_inumkey = 44144 AND it_ialphakey = 'CDB')
	OR
	(it_inumkey = 200257 AND it_ialphakey = 'CDP')
	OR
	(it_inumkey = 200069 AND it_ialphakey = 'BFS')
	OR
	(it_inumkey = 2012443 AND it_ialphakey = 'FCC')
	OR
	(it_inumkey = 3012019 AND it_ialphakey = 'FCL')
	OR
	(it_inumkey = 5960 AND it_ialphakey = 'CDB')
	OR
	(it_inumkey = 2004538 AND it_ialphakey = 'FTC')
	OR
	(it_inumkey = 9515127 AND it_ialphakey = 'JEE') 
);

-- Ryans
UPDATE t_item_transactions
	SET it_clname_recipient = 'Ryans Museum'
WHERE
(
	(it_inumkey = 19761 AND it_ialphakey = 'JunLaliqueChalice')
	OR
	(it_inumkey = 192554 AND it_ialphakey = 'JanBoehmJames')
);
/*
--Kens
UPDATE t_item_transactions
	SET it_clname_recipient = 'Walker Art Center'
WHERE
(

);
--Iains
UPDATE t_item_transactions
	SET it_clname_recipient = 'Iain'
WHERE
(

);
*/
-- View the effects
SELECT * FROM v_temptransactions;

--ROLLBACK;
