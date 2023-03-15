/* Exercicio 3.1 - Qual o nome do retalhista (ou retalhistas) responsaveis pela reposicao do maior numero de categorias? */
 
 with counts_cat as
(
SELECT tin, COUNT(tin) AS num_cat
FROM responsavel_por
GROUP BY tin
)

SELECT DISTINCT name_
FROM retalhista NATURAL JOIN counts_cat
WHERE num_cat = (SELECT MAX(num_cat) FROM counts_cat);

/* Exercicio 3.2 - Qual o nome do retalhista ou dos retalhistas que sao responsaveis por todas as categorias simples? */

with os AS (
    SELECT tin
    FROM (responsavel_por INNER JOIN categoria_simples ON responsavel_por.nome_cat = categoria_simples.nome)
)
SELECT DISTINCT name_
FROM retalhista NATURAL JOIN os;

/* Exercicio 3.3 - Quais os produtos (ean) que nunca foram repostos? */ 

SELECT DISTINCT ean
FROM produto
WHERE ean NOT IN (SELECT ean FROM evento_reposicao AS repostos);

/* Exercicio 3.4 - Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista? */

CREATE OR REPLACE FUNCTION	num_retalhista_repor(ean_aux INTEGER)
RETURNS INTEGER AS
$$
DECLARE	total INTEGER;
BEGIN	 	
		SELECT COUNT(*)	INTO total
			FROM evento_reposicao
			WHERE ean = ean_aux
			GROUP BY tin;
		RETURN	total;
END
$$	LANGUAGE	plpgsql;

SELECT DISTINCT ean
FROM produto
WHERE num_retalhista_repor(ean) = 1;
