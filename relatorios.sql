# -- Relatório de Vendas Válidas -- #

SELECT X.CPF, X.NOME, X.MES, X.TOTAL, X.MAXIMO, 

CASE WHEN (X.TOTAL > X.MAXIMO) THEN 
	'Inválido'
ELSE 
	'Válido' 
END AS CONSULTA,

CASE WHEN (X.TOTAL > X.MAXIMO) THEN
	ROUND((1 - (X.MAXIMO/X.TOTAL)) * 100, 2)
ELSE 
	'-'
END AS PORCENTAGEM

FROM (
	SELECT nf.CPF, tc.NOME, DATE_FORMAT(nf.DATA_VENDA, '%Y-%m') AS MES, 
	SUM(inf.QUANTIDADE) AS TOTAL, MAX(tc.VOLUME_DE_COMPRA) AS MAXIMO
    
	FROM 
		notas_fiscais nf
		INNER JOIN itens_notas_fiscais inf
		ON nf.NUMERO = inf.NUMERO
		INNER JOIN tabela_de_clientes tc
		ON tc.CPF = nf.CPF 
        
	GROUP BY nf.CPF, DATE_FORMAT(nf.DATA_VENDA, '%Y-%m')
	ORDER BY nf.CPF
) X;

# -- Relatório de Vendas por Sabor -- #
SELECT venda_sabor.SABOR, venda_sabor.ANO, venda_sabor.QUANTIDADE,
ROUND((venda_sabor.QUANTIDADE / venda_total.QUANTIDADE) * 100, 2) AS PARTICIPACAO

FROM

(SELECT tp.SABOR, YEAR(nf.DATA_VENDA) AS ANO, SUM(inf.QUANTIDADE) AS QUANTIDADE

FROM 
	tabela_de_produtos tp
	INNER JOIN itens_notas_fiscais inf
	ON tp.CODIGO_DO_PRODUTO = inf.CODIGO_DO_PRODUTO
	INNER JOIN notas_fiscais nf
	ON inf.NUMERO = nf.NUMERO

WHERE YEAR(nf.DATA_VENDA) = 2016

GROUP BY tp.SABOR, YEAR(nf.DATA_VENDA)) AS venda_sabor

INNER JOIN

(SELECT YEAR(nf.DATA_VENDA) AS ANO, SUM(inf.QUANTIDADE) AS QUANTIDADE

FROM
	itens_notas_fiscais inf
	INNER JOIN notas_fiscais nf
	ON inf.NUMERO = nf.NUMERO

WHERE YEAR(nf.DATA_VENDA) = 2016

GROUP BY YEAR(nf.DATA_VENDA)) AS venda_total

ON venda_total.ANO = venda_sabor.ANO # Opcional neste caso

ORDER BY venda_sabor.QUANTIDADE DESC;

# -- Relatório de Vendas por Tamanho -- #

SELECT venda_tamanho.TAMANHO, venda_tamanho.ANO, venda_tamanho.QUANTIDADE,
ROUND((venda_tamanho.QUANTIDADE / venda_total.QUANTIDADE) * 100, 2) AS PARTICIPACAO

FROM

(SELECT tp.TAMANHO, YEAR(nf.DATA_VENDA) AS ANO, SUM(inf.QUANTIDADE) AS QUANTIDADE

FROM 
	tabela_de_produtos tp
	INNER JOIN itens_notas_fiscais inf
	ON tp.CODIGO_DO_PRODUTO = inf.CODIGO_DO_PRODUTO
	INNER JOIN notas_fiscais nf
	ON inf.NUMERO = nf.NUMERO

WHERE YEAR(nf.DATA_VENDA) = 2016

GROUP BY tp.TAMANHO, YEAR(nf.DATA_VENDA)) AS venda_tamanho

INNER JOIN

(SELECT YEAR(nf.DATA_VENDA) AS ANO, SUM(inf.QUANTIDADE) AS QUANTIDADE

FROM
	itens_notas_fiscais inf
	INNER JOIN notas_fiscais nf
	ON inf.NUMERO = nf.NUMERO

WHERE YEAR(nf.DATA_VENDA) = 2016

GROUP BY YEAR(nf.DATA_VENDA)) AS venda_total

ON venda_total.ANO = venda_tamanho.ANO # Opcional neste caso

ORDER BY venda_tamanho.QUANTIDADE DESC;