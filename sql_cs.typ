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

= Join
#sql("
SELECT <colunas>
  FROM <nome-tabelaA> 
  INNER JOIN <nome-tabelaB>
  ON <chaveA> = <chaveB>
-- Equivale
SELECT <colunas>
  FROM <nome-tabelaA> , <nome-tabelaB>
  WHERE <chaveA> = <chaveB>
")
#table(
      stroke: none, inset:0.3em, align: (center+horizon,left+horizon,left+horizon),
      columns: (auto,auto,auto),
      table.header([*Join*],align(center)[*Registro da esquerda*],align(center)[*Registros da direita*]),
      table.hline(),
[INNER],[Somente com um registro correspondente na tabela direita],
[Somente com um registro correspondente na tabela esquerda],
[LEFT],[Todos os registros],[Somente com um registro correspondente na tabela esquerda],
[RIGHT],
[Somente um registro correspondente na tabela direita],[Todos os registros]
)

= Subquery
- Linha
#sql("
--Query
Select nm_Titulo, vl_Livro
  From Livro
  Where vl_Livro >
    --Subquery
    (Select AVG(vl_Livro) From Livro)
")
- Multi linha
#sql("
Select cd_Editora, cd_Livro, nm_Titulo, vl_Livro
  From Livro
  Where vl_Livro in
    (Select Min(vl_Livro)
      From Livro
      Group by cd_Editora)
")
- Mult colunas
#sql("
Select A.nm_Titulo, A.vl_Livro, B.vl_Medio
  From Livros as A,
    (Select cd_Editora,
      Avg(vl_Livro) as vl_Medio
      From Livro
      Group by cd_Editora) as B
  Where A.cd_Editora = B.cd_Editora
    and A.vl_Livro > B.vl_Medio
")