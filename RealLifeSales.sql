INSERT INTO t_clients (cl_clname) VALUES ('Transactions');
INSERT INTO t_locations (loc_locname, loc_clientkey, loc_loctype) VALUES ('Sold', 'Transactions', 'External');
INSERT INTO t_locations (loc_locname, loc_clientkey, loc_loctype) VALUES ('Loan', 'Transactions', 'External');