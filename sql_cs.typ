#import "cs_template.typ": set_page
#show: set_page.with("SQL Cheat Sheet",
  fonte:9.6pt,
  columns: 3,
  espacamento: 0.48em
)
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
#block(include "venn_sql.typ")
#sql("                        
/*1. Faça uma busca que mostre cd_Imovel, vl_Imovel e nm_Bairro, cujo código do vendedor seja 3.*/
SELECT I.cd_Imovel, I.vl_Imovel, B.nm_Bairro
	FROM Imovel as I INNER JOIN Bairro as B
		ON I.cd_Bairro = B.cd_Bairro and
		   I.cd_Cidade = B.cd_Cidade and
		   I.sg_Estado = B.sg_Estado
	WHERE cd_Vendedor = 3
/*2. Faça uma busca que mostre todos os imóveis que tenham ofertas cadastradas.*/
SELECT I.* 
	FROM Imovel as I INNER JOIN Oferta as O
		ON I.cd_Imovel = O.cd_Imovel 
/*3. Faça uma busca que mostre todos os imóveis e ofertas mesmo que não haja ofertas cadastradas para o imóvel.*/
SELECT I.* 
	FROM Imovel as I LEFT JOIN Oferta as O
		ON I.cd_Imovel = O.cd_Imovel 
/*4. Faça uma busca que mostre todos os compradores e as respectivas ofertas realizadas por eles.*/
SELECT C.nm_Comprador, O.vl_Oferta 
	FROM Comprador as C INNER JOIN Oferta as O
		ON C.cd_Comprador = O.cd_Comprador
/*5. Faça a mesma busca, porém acrescentando os compradores que ainda não fizeram ofertas para os imóveis.*/
SELECT C.nm_Comprador, O.vl_Oferta 
	FROM Comprador as C LEFT JOIN Oferta as O
		ON C.cd_Comprador = O.cd_Comprador
	WHERE O.vl_Oferta is null
/*6. Faça uma busca que mostre o endereço do imóvel, o bairro e nível de preço do imóvel.*/
SELECT I.ds_Endereco, B.nm_Bairro, I.vl_Imovel, F.nm_Faixa
	FROM Imovel as I, Bairro as B, Faixa_Imovel as F
	WHERE (I.vl_Imovel between F.vl_Maximo and F.vl_Minimo) and 
              I.cd_Bairro = B.cd_Bairro and 
              I.cd_Cidade = B.cd_Cidade and 
              I.sg_Estado=B.sg_Estado		 
--7. Verifique a diferença de preços entre o maior e o menor imóvel da tabela.
select max(vl_imovel) as maior, min(vl_imovel) as menor, 
       (max(vl_imovel) - min(vl_imovel)) as diferenca
   from imovel
--8. Mostre o código do vendedor e o menor preço de imóvel dele no cadastro. Exclua da busca os valores de imóveis inferiores a 100 mil.
select cd_vendedor, min(vl_imovel) as minimo 
   from imovel 
   where vl_imovel > 100000
   group by cd_vendedor
--9. Mostre o código e o nome do comprador e a média do valor das ofertas e o número de ofertas deste comprador.
Select C.cd_comprador, C.nm_comprador, 
       AVG(O.vl_oferta) media, count(*) qtde_oferta 
   From Comprador C inner join Oferta O
        on C.cd_comprador = O.cd_comprador
   group by C.cd_comprador, C.nm_comprador
-- 1. Faça uma lista de imóveis da mesma cidade do imóvel 2. Exclua o imóvel 2 da sua busca.
Select cd_Imovel, cd_Cidade
From Imovel
Where cd_Cidade = (Select cd_Cidade From Imovel Where cd_Imovel = 2) and
sg_Estado = (Select sg_Estado From Imovel Where cd_Imovel = 2) and
cd_Imovel <> 2
--2. Faça uma lista que mostre todos os imóveis que custam mais que 50% do menor de preço dos imóveis.
Select cd_Imovel, vl_Imovel
From Imovel
Where vl_Imovel > (Select Min(vl_Imovel) From Imovel) * 1.50
--3. Faça uma lista com o código e nome dos compradores que tenham ofertas cadastradas com valor superior a R$ 150 mil
Select nm_Comprador
From Comprador
Where cd_Comprador in (Select cd_comprador From Oferta Where vl_Oferta >
150000)
--4. Faça uma lista dos os imóveis com oferta superior à média das ofertas do imóvel
Select cd_Imovel, vl_Oferta
From Oferta
Where vl_Oferta > (Select AVG(vl_Oferta) From Oferta
Where cd_Imovel=2)
--5. Faça uma lista dos imóveis com preço superior à média de preço dos imóveis do mesmo bairro.
Select cd_Imovel, vl_Imovel
From Imovel as I
Where vl_Imovel > (Select Avg(vl_Imovel)
From Imovel
Where cd_bairro = I.cd_bairro and
cd_cidade = I.cd_cidade and
sg_estado = I.sg_estado)
-- 6. Faça uma lista dos imóveis com o maior preço agrupado por bairro, cujo maior preço seja superior à média de preços dos imóveis.
Select cd_Bairro, cd_Cidade, sg_Estado, Max(vl_Imovel) MaiorValor
From Imovel
Group by cd_Bairro, cd_Cidade, sg_Estado
Having Max(vl_Imovel) > (Select avg(vl_Imovel) from Imovel)
--7. Faça uma lista dos imóveis que tem o menor preço igual a oferta.
Select cd_Imovel ,cd_Vendedor, vl_Imovel
From Imovel as I
Where vl_Imovel IN (Select vl_oferta From oferta)
--8. Faça uma lista com os imóveis que têm o preço igual ao menor preço de todos os vendedores, exceto os imóveis do próprio vendedor.
Select cd_Imovel, nm_Endereco, vl_Imovel
From Imovel as I
Where vl_Imovel = (Select min(vl_Imovel)
From Imovel
Where cd_Vendedor <> I.cd_Vendedor)
--9. Faça uma lista com as ofertas menores que todas as ofertas do comprador 2,exceto os imóveis do próprio comparador.
Select cd_Imovel, cd_Comprador, vl_Oferta
From Oferta
Where vl_Oferta < (Select max(vl_Oferta)
From Oferta
Where cd_Comprador = 2)
And cd_Comprador <> 2
--10. Faça uma lista de todos os imóveis cujo Estado e Cidade sejam os mesmos do vendedor 3, exceto os imóveis do vendedor 3.
Select cd_Imovel, sg_Estado, cd_Cidade, cd_Vendedor
From Imovel
Where sg_Estado = (Select sg_Estado From Imovel Where cd_Vendedor = 3) and
cd_Cidade = (Select cd_Cidade From Imovel Where cd_Vendedor = 3) and
cd_Vendedor <> 3
--11. Faça uma lista com os nomes de vendedores cujos imóveis sejam do mesmo estado do imóvel 1.
Select nm_Vendedor, cd_Imovel
From Vendedor as V, (Select cd_Vendedor, cd_Imovel From Imovel
Where sg_Estado = (Select sg_Estado From Imovel
Where cd_Imovel = 1)) as I
Where V.cd_Vendedor = I.cd_Vendedor
")