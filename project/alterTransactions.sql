BEGIN;

-- Add Recipient column to t_item_transactions
ALTER TABLE t_item_transactions ADD COLUMN it_clname_recipient clname;

-- Copy across date in current clname column into recipient
UPDATE t_item_transactions SET it_clname_recipient = it_clname;

-- Rename current clname column to proprietor
ALTER TABLE t_item_transactions RENAME it_clname TO it_clname_proprietor;

-- Make recipient a FK to client
ALTER TABLE t_item_transactions ADD CONSTRAINT it_clname_recipient_cl_clname FOREIGN KEY (it_clname_recipient) REFERENCES t_clients(cl_clname);

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
	OR
        (it_inumkey = 74511787 AND it_ialphakey = 'CFT')
	OR
	(it_inumkey = 17190241 AND it_ialphakey = 'CMM')
	OR
	(it_inumkey = 20002641 AND it_ialphakey = 'JBC')
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
	OR
	(it_inumkey = 195298 AND it_ialphakey = 'FebBazoitesScorpion')
	OR
	(it_inumkey = 20004 AND it_ialphakey = 'JanYoungbloodGorrila')
	OR
	(it_inumkey = 195816 AND it_ialphakey = 'FebFangMask')
	OR
	(it_inumkey = 2005321 AND it_ialphakey = 'DecEjaghanCrest')
	OR
	(it_inumkey = 20061 AND  it_ialphakey = 'AprMendeHelmet')
	OR
	(it_inumkey = 19739 AND it_ialphakey = 'MaySenufoHeaddress')
	OR
	(it_inumkey = 196455 AND it_ialphakey = 'NovTemneInititation')
	OR
	(it_inumkey = 19473 AND it_ialphakey = 'FebUnkownNecklace')
	OR
	(it_inumkey = 19705 AND it_ialphakey = 'OctHofmannNight')
	OR
	(it_inumkey = 19757 AND it_ialphakey = 'JunEddyJewlery')
	OR
	(it_inumkey = 19991 AND it_ialphakey = 'DecSmithMose')
	OR
	(it_inumkey = 19994 AND it_ialphakey = 'AprFouquetBrooch')
	OR
	(it_inumkey = 20001 AND it_ialphakey = 'FebMunozBrok')
	OR
	(it_inumkey = 192333 AND it_ialphakey = 'JunUnkownUnguent')
	OR
	(it_inumkey = 193549 AND it_ialphakey = 'SepHopperTwo')
	OR
	(it_inumkey = 193992 AND it_ialphakey = 'JulHashWom')
	OR
	(it_inumkey = 194325 AND it_ialphakey = 'MarWyethHunter')
	OR
	(it_inumkey = 195663 AND it_ialphakey = 'JanAltenstetterCovered')
	OR
	(it_inumkey = 196026 AND it_ialphakey = 'NovMorrisThe')
	OR
	(it_inumkey = 200125 AND it_ialphakey = 'SepMcKiePolar')
	OR
	(it_inumkey = 197852 AND it_ialphakey = 'OctChantreyGeorge')
	OR
	(it_inumkey = 199423 AND it_ialphakey = 'MarAkanKuduo')
	OR
	(it_inumkey = 197731 AND it_ialphakey LIKE 'JanPorterO%')
	OR
	(it_inumkey = 2009385 AND it_ialphakey = 'MarLibbeyCooler')
	OR
	(it_inumkey = 1933169 AND it_ialphakey = 'AugUnkownEnamel')
	OR
	(it_inumkey = 1925108 AND it_ialphakey = 'FebAntoninAntonin')
	OR
	(it_inumkey = 1984881 AND it_ialphakey = 'FebPableMetamorphoses')
	OR
	(it_inumkey = 1965176 AND it_ialphakey = 'MayMochiCardinal')
	OR
	(it_inumkey = 200453 AND it_ialphakey = 'JanRollinsTemptation')
	OR
	(it_inumkey = 197051 AND it_ialphakey = 'MarSongyeNkisi')
	OR
	(it_inumkey = 200352 AND it_ialphakey = 'AprDineColumn')
	OR
	(it_inumkey = 201212 AND it_ialphakey = 'NovRinggoldBen')
	OR
	(it_inumkey = 1906227 AND it_ialphakey = 'MayUnkownFragment')
	OR
	(it_inumkey = 197744 AND it_ialphakey = 'MayBolotowskyEllipse')
	OR
	(it_inumkey = 196456 AND it_ialphakey = 'MayChauncyWilliam')
	OR
	(it_inumkey = 199511 AND it_ialphakey = 'JulCattaneoPortrait')
	OR
	(it_inumkey = 200044 AND it_ialphakey = 'MarJapaneseNetsuke')
	OR
	(it_inumkey = 198287 AND it_ialphakey = 'AprPearlsteinSphynx')
	OR
	(it_inumkey = 199422 AND it_ialphakey = 'MarKieferAthanor')
	OR
	(it_inumkey = 200052 AND it_ialphakey = 'OctGardnerGardner')
	OR
	(it_inumkey = 199613 AND it_ialphakey = 'OctPaleyContinuum')
	OR
	(it_inumkey = 190747 AND it_ialphakey = 'JulNiniMedal')
	OR
	(it_inumkey = 190746 AND it_ialphakey = 'AugVivierMedal')
	OR
	(it_inumkey = 190749 AND it_ialphakey = 'JulCaunoisMedal')
);

UPDATE t_item_transactions
	SET it_clname_proprietor = 'Ryans Museum'
WHERE
(
	(it_inumkey = 1989116 AND it_ialphakey = 'FebBosmanChicago')
	OR
	(it_inumkey = 2005290 AND it_ialphakey = 'OctWileySaint')
	OR
	(it_inumkey = 200648 AND it_ialphakey = 'JulRosenPasswords')
);
--Kens
UPDATE t_item_transactions
	SET it_clname_recipient = 'Walker Art Center'
WHERE
(
	(it_inumkey = 2004.1 AND it_ialphakey = 'DLI')
	OR
	(it_inumkey = 2004.9 AND it_ialphakey = 'DLI')
	OR
	(it_inumkey = 2001.66 AND it_ialphakey = 'DLI')
	OR
	(it_inumkey = 1996.61 AND it_ialphakey = 'DWI')
	OR
	(it_inumkey = 2008.34 AND it_ialphakey = 'PWM')
	OR
	(it_inumkey = 1996.7 AND it_ialphakey = 'DWI')
	OR
	(it_inumkey = 1996.172 AND it_ialphakey = 'DWP')
	OR
	(it_inumkey = 2002.11 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 002.12 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2003.9 AND it_ialphakey = 'MLE')
	OR
	(it_inumkey = 1988.14 AND it_ialphakey = 'DAP')
	OR
	(it_inumkey = 2005.24 AND it_ialphakey = 'DAP')
	OR
	(it_inumkey = 2008.54 AND it_ialphakey = 'DAC')
	OR
	(it_inumkey = 2011.232 AND it_ialphakey = 'PAM')
	OR
	(it_inumkey = 2011.233 AND it_ialphakey = 'PAM')
	OR
	(it_inumkey = 1998.76 AND it_ialphakey = 'DAI')
	OR
	(it_inumkey = 2010.28 AND it_ialphakey = 'DAI')
	OR
	(it_inumkey = 2005.74 AND it_ialphakey = 'PAO')
	OR
	(it_inumkey = 1998.1 AND it_ialphakey = 'GAGO')
	OR
	(it_inumkey = 1994.127 AND it_ialphakey = 'MAS')
	OR
	(it_inumkey = 2002.16 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.17 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.13 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.14 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.18 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.19 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.2 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 2002.15 AND it_ialphakey = 'PMP')
	OR
	(it_inumkey = 1949.3 AND it_ialphakey = 'WHI')
	OR
	(it_inumkey = 1962.1 AND it_ialphakey = 'WBI')
	OR
	(it_inumkey = 1998.77 AND it_ialphakey = 'DAI')
	OR
	(it_inumkey = 1997.83 AND it_ialphakey = 'DAA')
	OR
	(it_inumkey = 2011.231 AND it_ialphakey = 'PAM')
	OR
	(it_inumkey = 2002.12 AND it_ialphakey = 'PMP')
);
--Iains

UPDATE t_item_transactions
	SET it_clname_recipient = 'Iain'
WHERE
(
	(it_ialphakey = 'PA' OR it_ialphakey = 'PU' OR it_ialphakey = 'SC' OR it_ialphakey = 'BU')
	AND
	(it_clientkey = 'Mickey Mouse' OR it_clientkey = 'Danger Mouse' OR it_clientkey = 'Mighty Mouse')
	AND
	(it_ittype = 'Borrow')
);

-- View the transactions which are still problems
/*
SELECT it_inumkey, it_ialphakey, it_clientkey, it_clname_recipient, it_clname_proprietor, it_ittype FROM t_item_transactions
WHERE
(
	(
		it_clname_recipient <> 'Iain'
		AND
		it_clname_recipient <> 'Evan Closson'
		AND
		it_clname_recipient <> 'Ryans Museum'
		AND
		it_clname_recipient <> 'Walker Art Center'
		AND
		it_clname_recipient <> 'Andrew Museum'
		AND
		(
			it_ittype = 'Purchase'
			OR
			it_ittype = 'Borrow'
		)
	)
	OR
	(
		it_clname_proprietor <> 'Iain'
		AND
		it_clname_proprietor <> 'Evan Closson'
		AND
		it_clname_proprietor <> 'Ryans Museum'
		AND
		it_clname_proprietor <> 'Walker Art Center'
		AND
		it_clname_proprietor <> 'Andrew Museum'
		AND
		(
			it_ittype = 'Sale'
			OR
			it_ittype = 'Loan'
		)
	)
	OR
	(it_clname_proprietor = it_clname_recipient)
);
