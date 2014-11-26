begin;

CREATE TABLE mainMaterial (
mmat_mainmat materialdesc,
PRIMARY KEY (mmat_mainmat)
);

INSERT INTO mainMaterial (mmat_mainmat)
SELECT DISTINCT mt_material from works_materials;

CREATE TABLE subMaterial (
smt_mainmat materialdesc NOT NULL,
smt_submat materialdesc, 
PRIMARY KEY (smt_submat, smt_mainmat),
FOREIGN KEY (smt_mainmat) REFERENCES mainMaterial(mmat_mainmat)
);

INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Aragonite', 'Calcium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Amazonite', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Amazonite', 'Potassium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Azurite', 'Copper');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Corundum', 'Iron');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Corundum', 'Titanium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Topaz', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Topaz', 'Fluorine');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Corundum', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Corundum', 'Magnesium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Morganite', 'Cyclosilicate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Morganite', 'Beryllium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Morganite', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Spodumene', 'Lithium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Spodumene', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Spodumene', 'Inosilicate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Tourmaline', 'Lithium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Tourmaline', 'Boro-Silicate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Tourmaline', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Tourmaline', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Nephrite', 'Calcium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Foresterite', 'Magnesium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Pyroelectric', 'Aluminum');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Pyroelectric', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Pyroelectric', 'Lithium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Pyroelectric', 'Boro-Silicate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Apatite', 'Lead');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Apatite', 'Chlorophosphate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Calcium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Vanadium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Silicate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Gypsum', 'Sulfate');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Gypsum', 'Calcium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Zirconium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Hydrated');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Tin');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Crystal', 'Oxide');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Lechatelierite', 'Silica Glass');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Amphiabole', 'Magnesium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Halite', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Halite', 'Fluoride');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Wollastonite', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Wollastonite', 'Magnesium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Plagioclase', 'Sodium');
INSERT INTO subMaterial (smt_mainmat, smt_submat) VALUES ('Plagioclase', 'Aluminum');

DELETE FROM works_materials WHERE 
	((mt_numid = 12174 and mt_material = 'Calcium')
	or (mt_numid = 17563 and (mt_material = 'Aluminum' or mt_material = 'Potassium'))
	or (mt_numid = 21614 and mt_material = 'Copper')
	or (mt_numid = 22286 and (mt_material = 'Aluminum' or mt_material = 'Magnesium'))
	or (mt_numid = 23148 and (mt_material = 'Aluminum' or mt_material = 'Fluorine'))
	or (mt_numid = 23479 and (mt_material = 'Aluminum' or mt_material = 'Magnesium'))
	or (mt_numid = 25049 and (mt_material = 'Cyclosilicate' or mt_material = 'Beryllium' or mt_material = 'Aluminum'))
	or (mt_numid = 25071 and (mt_material = 'Lithium' or mt_material = 'Aluminum' or mt_material = 'Inosilicate'))
	or (mt_numid = 28156 and (mt_material = 'Lithium' or mt_material = 'Boro-Silicate' or mt_material = 'Sodium' or mt_material = 'Aluminum'))
	or (mt_numid = 30745 and mt_material = 'Calcium')
	or (mt_numid = 34200 and mt_material = 'Magnesium')
	or (mt_numid = 42675 and (mt_material = 'Aluminum' or mt_material = 'Sodium' or mt_material = 'Lithium' or mt_material = 'Boro-Silicate'))
	or (mt_numid = 46015 and (mt_material = 'Lead' or mt_material = 'Chlorophosphate'))
	or (mt_numid = 47100 and (mt_material = 'Calcium' or mt_material = 'Vanadium' or mt_material = 'Silicate'))
	or (mt_numid = 47395 and (mt_material = 'Sulfate' or mt_material = 'Calcium'))
	or (mt_numid = 47426 and (mt_material = 'Zirconium' or mt_material = 'Sodium' or mt_material = 'Hydrated'))
	or (mt_numid = 47993 and mt_material = 'Silica Glass')
	or (mt_numid = 48689 and mt_material = 'Magnesium')
	or (mt_numid = 48720 and (mt_material = 'Sodium' or mt_material = 'Fluoride'))
	or (mt_numid = 50566 and (mt_material = 'Sodium' or mt_material = 'Magnesium'))
	or (mt_numid = 51957 and (mt_material = 'Tin' or mt_material = 'Oxide'))
	or (mt_numid = 50577 and (mt_material = 'Sodium' or mt_material = 'Aluminum')));
	
select * from works_materials;
select * from subMaterial;
commit;