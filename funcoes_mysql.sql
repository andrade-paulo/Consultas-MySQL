# -- Funções Para Strings -- #

SELECT LTRIM('    OLÁ  ') AS RESULTADO; # Remove espaços da esquerda

SELECT RTRIM('  OLÁ     ') AS RESULTADO; # Remove espaços da direita

SELECT TRIM('    OLÁ    ') AS RESULTADO; # Remove espaços de ambos os lados

SELECT CONCAT('OLÁ', ' ', 'TUDO BEM','?') AS RESULTADO; # Junta as frases

SELECT CONCAT(NOME, ' (', CPF, ') ') AS RESULTADO FROM TABELA_DE_CLIENTES;

SELECT UPPER('olá, tudo bem?') AS RESULTADO; # Torna todas as letras maiúsculas

SELECT LOWER('OLÁ, TUDO BEM?') AS RESULTADO; # Torna todas as letras minúsculas

SELECT SUBSTRING('OLÁ, TUDO BEM?', 6) AS RESULTADO; # Corta a string a partir da sexta posição (começa do 1)

SELECT SUBSTRING('OLÁ, TUDO BEM?', 6, 4) AS RESULTADO; # Pega 4 caracteres a partir da sexta posição (--)

SELECT NOME, CONCAT(ENDERECO_1, ', ', BAIRRO, ' - ', CIDADE, ' - ', ESTADO) AS ENDERECO 
FROM tabela_de_clientes;

# -- Funções Para Datas -- #

SELECT CURDATE(); # Data atual

SELECT CURRENT_TIME(); # Hora atual

SELECT CURRENT_TIMESTAMP(); # Data e hora atuais

SELECT YEAR(CURRENT_TIMESTAMP()); # Apenas o ano

SELECT DAY(CURRENT_TIMESTAMP()); # Apenas o dia

SELECT MONTH(CURRENT_TIMESTAMP()); # Apenas o mês

SELECT MONTHNAME(CURRENT_TIMESTAMP()); # Nome do mês

SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2004-01-24') AS RESULTADO; # Espaço de dias entre as datas

SELECT CURRENT_TIMESTAMP() AS DIA_HOJE, 
DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 DAY) AS RESULTADO; # Subtrai da data o INTERVAL de 5 dias

SELECT DISTINCT DATA_VENDA,
DAYNAME(DATA_VENDA) AS DIA, MONTHNAME(DATA_VENDA) AS MES, 
YEAR(DATA_VENDA) AS ANO FROM NOTAS_FISCAIS;

SELECT NOME, TIMESTAMPDIFF(YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS IDADE
FROM tabela_de_clientes;

# -- Funções Para Matemática -- #

SELECT (23+((25-2)/2)*45) AS RESULTADO; # Expressão matemática

SELECT CEILING(3.14159) AS RESULTADO; # Arredonda para cima

SELECT ROUND(2.71828) AS RESULTADO; # Arredonda para o inteiro mais próximo

SELECT FLOOR(9.806) AS RESULTADO; # Arredonda para baixo

SELECT RAND() AS RESULTADO; # Gera um número aleatório

SELECT NUMERO, QUANTIDADE, PRECO, QUANTIDADE * PRECO AS FATURAMENTO
FROM ITENS_NOTAS_FISCAIS;
 
SELECT NUMERO, QUANTIDADE, PRECO, ROUND(QUANTIDADE * PRECO, 2) AS FATURAMENTO
FROM ITENS_NOTAS_FISCAIS;

SELECT YEAR(DATA_VENDA) AS ANO, FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) AS TOTAL
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016 
GROUP BY YEAR(DATA_VENDA);

# -- Funções Para Conversão de Dados -- #
 
SELECT CONCAT('O dia de hoje é : ', 
DATE_FORMAT(CURRENT_TIMESTAMP(),'%W, %d/%m/%Y - %U') ) AS RESULTADO; # Personaliza o output da data

SELECT SUBSTRING(CONVERT(23.3, CHAR),1,1) AS RESULTADO; # Converte o tipo de dado

# Por algum motivo não funciona:

SELECT CONCAT('O cliente ', tc.NOME, 
' faturou R$', ROUND(SUM(inf.QUANTIDADE * inf.PRECO), 2), 
' em ', YEAR(nf.DATA_VENDA)) AS RESULTADO 
FROM notas_fiscais nf
INNER JOIN tabela_de_clientes tc ON nf.CPF = tc.CPF
INNER JOIN itens_notas_fiscais inf ON nf.NUMERO = inf.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY tc.NOME, YEAR(nf.DATA_VENDA);
