DROP INDEX IF EXISTS nome_retalhista_index;
DROP INDEX IF EXISTS nome_retalhista_index2;
DROP INDEX IF EXISTS nome_cat_index;
DROP INDEX IF EXISTS count_ean_index;

/* Exercicio 7.1 */
CREATE INDEX nome_retalhista_index2 ON retalhista USING HASH(name_); 
CREATE INDEX nome_retalhista_index ON responsavel_por USING HASH(tin);

SELECT DISTINCT R.name_
FROM retalhista R, responsavel_por P
WHERE R.tin = P.tin and P.nome_cat = 'Peru';

/* Exercicio 7.2 */
CREATE INDEX nome_cat_index ON tem_categoria USING HASH(nome);
CREATE INDEX count_ean_index ON produto USING HASH(ean);

SELECT T.nome, count(T.ean)
FROM produto P, tem_categoria T
WHERE p.cat = T.nome and P.descr like 'P%'
GROUP BY T.nome;
