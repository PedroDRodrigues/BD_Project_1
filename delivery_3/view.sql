DROP VIEW IF EXISTS Vendas;
CREATE VIEW Vendas (ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades)
As
Select e.ean, cat, extract (YEAR From instante) as ano, extract (QUARTER From instante) as trimestre, extract (MONTH From instante) as mes,
 extract(DAY From instante) as dia_mes, extract(DOW From instante) as dia_semana, distrito, concelho, unidades
From evento_reposicao AS e NATURAL JOIN produto INNER JOIN 
instalada_em
ON e.num_serie = instalada_em.num_serie AND e.fabricante = instalada_em.fabricante  INNER JOIN 
ponto_de_retalho
ON instalada_em.local_ = ponto_de_retalho.nome