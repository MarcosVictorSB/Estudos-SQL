select * from [TABELA DE CLIENTES]

CREATE FUNCTION ListaNotasCliente (@CPF AS VARCHAR(12)) RETURNS TABLE
AS
RETURN SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF

SELECT * FROM ListaNotasCliente('1471156710')

SELECT A.CPF, A.NUM_NOTA, B.TOTAL_FATURAMENTO
FROM
(SELECT CPF, (SELECT COUNT(*) FROM ListaNotasCliente(CPF)) AS NUM_NOTA
FROM [TABELA DE CLIENTES]) A 
INNER JOIN
(SELECT CPF, SUM([dbo].[FATURAMENTO_NOTA](NUMERO)) AS TOTAL_FATURAMENTO
FROM [NOTAS FISCAIS] GROUP BY CPF) B
ON A.CPF = B.CPF