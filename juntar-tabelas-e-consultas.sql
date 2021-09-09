# -- JOIN --

# INNER JOIN - Junta as tabelas com os valores que se coincidem
SELECT * FROM tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA;

SELECT A.MATRICULA, A.NOME, COUNT(*) FROM
tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

SELECT YEAR(DATA_VENDA) AS ANO, SUM(QUANTIDADE * PRECO) AS TOTAL FROM
itens_notas_fiscais INF
INNER JOIN notas_fiscais NF
ON INF.NUMERO = NF.NUMERO
GROUP BY ANO;

# LEFT JOIN - Tudo da esquerda + equivalentes da direita
SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A 
LEFT JOIN notas_fiscais B ON A.CPF = B.CPF;

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A 
LEFT JOIN notas_fiscais B ON A.CPF = B.CPF
WHERE B.CPF IS NULL;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME,
tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

# RIGHT JOIN - Tudo da direita + equivalentes da esquerda
SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM notas_fiscais B
LEFT JOIN tabela_de_clientes A ON A.CPF = B.CPF
WHERE YEAR(B.DATA_VENDA) = '2015';

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME,
tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
ORDER BY tabela_de_vendedores.BAIRRO;

# FULL JOIN - Mistura o LEFT JOIN com RIGHT JOIN 
# * No MySQL não existe um comando específico pra este JOIN *
SELECT 
	tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME,
	tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
	FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes
	ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
UNION # O tópico sobre union está logo abaixo de CROSS JOIN
SELECT 
	tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME,
	tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
	FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes
	ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
	ORDER BY tabela_de_vendedores.BAIRRO;

# CROSS JOIN - Cria uma análise combinatória dos dados
SELECT tabela_de_vendedores.NOME, tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME, tabela_de_clientes.BAIRRO
FROM tabela_de_vendedores, tabela_de_clientes
ORDER BY tabela_de_vendedores.NOME;

# -- UNION --

# UNION - Une consultas diferentes
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores
UNION ALL
SELECT DISTINCT BAIRRO FROM tabela_de_clientes;

SELECT BAIRRO, NOME, 'CLIENTE' AS TIPO, CPF AS IDENTIFICADOR FROM tabela_de_clientes
UNION
SELECT BAIRRO, NOME, 'VENDEDOR', MATRICULA FROM tabela_de_vendedores;

# -- SUBCONSULTAS --
SELECT * FROM tabela_de_clientes WHERE BAIRRO
IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);

SELECT X.EMBALAGEM, X.MAIOR_PRECO FROM
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM) X
WHERE X.MAIOR_PRECO >= 10;

# -- VIEWS --
SELECT X.EMBALAGEM, MAIOR_PRECO FROM
vw_embalagens_caras X WHERE X.MAIOR_PRECO >= 10;

SELECT A.NOME_DO_PRODUTO, A.EMBALAGEM, A.PRECO_DE_LISTA, MAIOR_PRECO
FROM tabela_de_produtos A INNER JOIN vw_embalagens_caras X
ON A.EMBALAGEM = X.EMBALAGEM;

SELECT A.NOME_DO_PRODUTO, A.EMBALAGEM, MAIOR_PRECO
FROM tabela_de_produtos A INNER JOIN vw_embalagens_caras X
ON A.EMBALAGEM = X.EMBALAGEM
WHERE X.MAIOR_PRECO = A.PRECO_DE_LISTA;
