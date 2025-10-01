-- curiosa -> idade < 7
-- fiel -> recência < 7 e recência anterior < 15
-- turista -> 7 <= recência <= 14
-- desencantado -> recência <= 28
-- zumbi -> recência > 28
-- reconquistado -> recência < 7 e 14 <= recência anterior <= 28
-- reborn -> recência < 7 e recência anterior > 28

WITH tb_daily AS (
    SELECT  
        DISTINCT
        idCliente,
        substr(DtCriacao,0,11) AS dtDia

    FROM transacoes
),

tb_idade AS (
    SELECT IdCliente,
            cast(max(julianday('now') - julianday(dtDia)) as int) AS qtdeDiasPrimTransacao,
            cast(min(julianday('now') - julianday(dtDia)) as int) AS qtdeDiasUltTransacao
    FROM tb_daily
    GROUP BY IdCliente
),

tb_rn AS (

    SELECT *,
            row_number() OVER(PARTITION BY IdCliente ORDER BY dtDia DESC) AS rnDia
    FROM tb_daily

),

tb_penultima_ativacao AS (

SELECT *,
        CAST(julianday('now') - julianday(dtDia) AS INT)AS qtdeDiasPenultimaTransacao
FROM tb_rn
WHERE rnDia = 2
),

tb_life_cycle AS (

    SELECT t1.*,
            t2.qtdeDiasPenultimaTransacao,
            CASE
                WHEN qtdeDiasPrimTransacao <= 7 THEN '01 - CURIOSO'
                WHEN qtdeDiasUltTransacao <= 7 AND qtdeDiasPenultimaTransacao - qtdeDiasUltTransacao <= 14 THEN '02 - FIEL'
                WHEN qtdeDiasUltTransacao BETWEEN 8 AND 14 THEN '03 - TURISTA'
                WHEN qtdeDiasUltTransacao BETWEEN 15 AND 28 THEN '04 - DESENCANTADA'
                WHEN qtdeDiasUltTransacao > 28 THEN '05 - ZUMBI'
                WHEN qtdeDiasUltTransacao <= 7 AND qtdeDiasPenultimaTransacao - qtdeDiasUltTransacao BETWEEN 15 AND 28 THEN '02 - RECONQUISTADO'
                WHEN qtdeDiasUltTransacao <= 7 AND qtdeDiasPenultimaTransacao - qtdeDiasUltTransacao > 28 THEN '02 - REBORN'

            END AS descLifeCycle       
    FROM tb_idade AS t1

    LEFT JOIN tb_penultima_ativacao AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT descLifeCycle, count(*)
FROM tb_life_cycle
GROUP BY descLifeCycle
