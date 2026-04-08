#import "cs_template.typ": set_page
#show: set_page.with("SQL Chear Sheet")
#let sql(code) = raw(code,lang: "SQL") 

= Prefixos
```
cd Código
ds Descrição
dt Data
  dd Dia
  mm Mês
  aa Ano
hr Hora
ic Indicador
nm Nome
qt Quantidade (valores não monetários)
sg Sigla
pc Indica uma Porcentagem
vl Valor monetário
```
= Categoria de instruções
- DML - manipulação #sql("update, insert, delete")
- DDL - definição #sql("create, alter, drop")
- TCL - transação #sql("commit, rollback, savepoint")
- DCL - controle #sql("grant, revoke")
- DQL - consulta #sql("select")

= Sintaxe
#sql("
SELECT <colunas>
  FROM <nome-da-tabela>
  WHERE <condição>
  GROUP BY <colunas>
  HAVING <condição>
  ORDER BY <colunas>
")

= Funções de Agregação

#sql("
SUM()     A somatória de valores na expressão numérica
AVG()     A média de valores na expressão numérica
COUNT(*)  O número de linhas selecionadas
MAX()     O maior valor computado para a expressão
MIN()     O menor valor computado para a expressão
")

= Group By
- Computa funções em grupos sumarizados.
- Qualquer coluna da seleção, que não for uma função agregada, deverá constar da claúsula *GROUP BY*.

#sql("
SELECT cd_Depto, AVG(vl_Salario) as Media
  FROM Empregado
  GROUP BY cd_Depto
")
= Having
- Especifica quais grupos serão exibidos.
- Deve ser colocada após um *GROUP BY.*
- É o *WHERE* dos grupos.

#sql("
SELECT cd_Depto, AVG(vl_Salario) as Media
  FROM Empregado
  GROUP BY cd_Depto
  HAVING COUNT(*) > 10
")

= Rollup
- Gera subtotais
#sql("
Select cd_Comprador, SUM(vl_Oferta) Soma
  From Oferta
  Group by cd_Comprador with ROLLUP
Resultado:
cd_Comprador  Soma
1             350000,00
3             160000,00
NULL          510000,00
")

= Distinct
- Remove linhas duplicadas

