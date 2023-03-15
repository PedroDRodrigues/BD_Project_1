INSERT INTO categoria VALUES ('Frutas');
INSERT INTO categoria VALUES ('Horta');
INSERT INTO categoria VALUES ('Legumes');
INSERT INTO categoria VALUES ('Frango');
INSERT INTO categoria VALUES ('Peru');
INSERT INTO categoria VALUES ('Carnes');

INSERT INTO categoria_simples VALUES ('Frutas');
INSERT INTO categoria_simples VALUES ('Legumes');
INSERT INTO categoria_simples VALUES ('Frango');
INSERT INTO categoria_simples VALUES ('Peru');

INSERT INTO super_categoria VALUES ('Horta');
INSERT INTO super_categoria VALUES ('Carnes');

INSERT INTO tem_outra VALUES ('Horta','Frutas');
INSERT INTO tem_outra VALUES ('Horta','Legumes');
INSERT INTO tem_outra VALUES ('Carnes','Peru');
INSERT INTO tem_outra VALUES ('Carnes','Frango');

INSERT INTO produto VALUES (1,'Horta','Batata doce');
INSERT INTO produto VALUES (2,'Legumes','Alface');
INSERT INTO produto VALUES (3,'Frutas','Cereja');
INSERT INTO produto VALUES (4,'Peru','Bifes de Peru');
INSERT INTO produto VALUES (5,'Peru','Coxa de Peru');
INSERT INTO produto VALUES (6,'Frango','Pernas de Frango');
INSERT INTO produto VALUES (7,'Frutas','Pera');
INSERT INTO produto VALUES (8,'Legumes','Pepino');

INSERT INTO tem_categoria VALUES (1,'Horta');
INSERT INTO tem_categoria VALUES (2,'Legumes');
INSERT INTO tem_categoria VALUES (3,'Frutas');
INSERT INTO tem_categoria VALUES (6,'Frango');

INSERT INTO IVM VALUES (1,'Marques');
INSERT INTO IVM VALUES (2,'Viveiros');

INSERT INTO ponto_de_retalho VALUES ('Loja1','Wola','Wroclaw');
INSERT INTO ponto_de_retalho VALUES ('Loja2','Porto','Vila Nova de Gaia');

INSERT INTO instalada_em VALUES (1,'Marques','Loja1');
INSERT INTO instalada_em VALUES (2,'Viveiros','Loja2');

INSERT INTO prateleira VALUES (1,1,'Marques',124,'Legumes');
INSERT INTO prateleira VALUES (2,1,'Marques',124,'Frutas');
INSERT INTO prateleira VALUES (3,1,'Marques',124,'Carnes');
INSERT INTO prateleira VALUES (4,2,'Viveiros',124,'Horta');
INSERT INTO prateleira VALUES (5,2,'Viveiros',124,'Frango');
INSERT INTO prateleira VALUES (6,2,'Viveiros',124,'Peru');

INSERT INTO retalhista VALUES (1,'Stas');
INSERT INTO retalhista VALUES (2,'Mano');

INSERT INTO planograma VALUES (1,4,2,'Viveiros',2,50,'Entrada');
INSERT INTO planograma VALUES (2,1,1,'Marques',2,5,'Zona 1');
INSERT INTO planograma VALUES (3,2,1,'Marques',2,500,'Zona 1');
INSERT INTO planograma VALUES (4,3,1,'Marques',2,25,'Zona 1');
INSERT INTO planograma VALUES (5,6,2,'Viveiros',2,12,'Entrada');
INSERT INTO planograma VALUES (6,5,2,'Viveiros',2,15,'Entrada');
INSERT INTO planograma VALUES (7,2,1,'Marques',2,50,'Zona 1');
INSERT INTO planograma VALUES (8,1,1,'Marques',2,30,'Zona 1');

INSERT INTO responsavel_por VALUES ('Frutas',1,1,'Marques');
INSERT INTO responsavel_por VALUES ('Peru',1,2,'Viveiros');

INSERT INTO evento_reposicao VALUES (1,4,2,'Viveiros','21/7/2013',10,2);
INSERT INTO evento_reposicao VALUES (2,1,1,'Marques','28/1/2017',2,2);
INSERT INTO evento_reposicao VALUES (3,2,1,'Marques','23/2/2011',100,1);
INSERT INTO evento_reposicao VALUES (4,3,1,'Marques','26/4/2015',5,1);
INSERT INTO evento_reposicao VALUES (5,6,2,'Viveiros','19/5/2011',3,1);
INSERT INTO evento_reposicao VALUES (6,5,2,'Viveiros','17/10/2012',3,2);
INSERT INTO evento_reposicao VALUES (7,2,1,'Marques','21/12/2014',5,1);
INSERT INTO evento_reposicao VALUES (8,1,1,'Marques','23/7/2014',6,2);
INSERT INTO evento_reposicao VALUES (1,4,2,'Viveiros','22/9/2013',8,2);
INSERT INTO evento_reposicao VALUES (6,5,2,'Viveiros','27/11/2014',6,2);

