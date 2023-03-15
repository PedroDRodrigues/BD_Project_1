/* Exercicio 6.1. */
/* Numero total de artigos vendidos num dado periodo (i.e. entre duas datas), por dia da semana, por concelho e no total */

SELECT concelho, dia_semana, SUM(unidades) as total
                                        From Vendas
                                        WHERE ano BETWEEN 2014 AND 2018
                                        GROUP BY CUBE (dia_semana, concelho);

/* Exercicio 6.2. */
/* Numero total de artigos vendidos num dado distrito, por concelho, categoria, dia da semana e no total */



SELECT cat AS categoria, dia_semana, concelho, SUM(unidades) AS vendidos
FROM Vendas 
    WHERE distrito = 'Wola' 
GROUP BY CUBE (concelho, cat, dia_semana);
