#import "cs_template.typ": set_page
#show: set_page.with("SQL Chear Sheet", columns: 3)
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

#let svg = bytes(
```
<svg width="900" height="700" xmlns="http://www.w3.org/2000/svg" font-family="Arial">

  <!-- TITLE -->
  <text x="450" y="30" font-size="22" text-anchor="middle">Tipos de JOIN em SQL</text>

  <!-- INNER JOIN -->
  <circle cx="200" cy="120" r="60" fill="lightblue"/>
  <circle cx="260" cy="120" r="60" fill="lightgreen"/>
  <clipPath id="innerClip">
    <circle cx="200" cy="120" r="60"/>
  </clipPath>
  <circle cx="260" cy="120" r="60" fill="green" clip-path="url(#innerClip)"/>
  <text x="230" y="200" text-anchor="middle">INNER JOIN</text>

  <!-- LEFT JOIN -->
  <circle cx="200" cy="300" r="60" fill="blue"/>
  <circle cx="260" cy="300" r="60" fill="lightgray"/>
  <text x="230" y="380" text-anchor="middle">LEFT JOIN</text>

  <!-- RIGHT JOIN -->
  <circle cx="500" cy="300" r="60" fill="lightgray"/>
  <circle cx="560" cy="300" r="60" fill="green"/>
  <text x="530" y="380" text-anchor="middle">RIGHT JOIN</text>

  <!-- FULL JOIN -->
  <circle cx="200" cy="500" r="60" fill="blue"/>
  <circle cx="260" cy="500" r="60" fill="green"/>
  <text x="230" y="580" text-anchor="middle">FULL JOIN</text>

  <!-- CROSS JOIN -->
  <rect x="450" y="460" width="80" height="80" fill="blue"/>
  <rect x="550" y="460" width="80" height="80" fill="green"/>
  <text x="540" y="580" text-anchor="middle">CROSS JOIN</text>
</svg>```.text)

#let svg2 = bytes(
```
<svg width="1000" height="820" xmlns="http://www.w3.org/2000/svg" font-family="Segoe UI, Arial">

  <style>
    .title { font-size: 26px; font-weight: bold; fill: #1f2937; }
    .subtitle { font-size: 14px; fill: #6b7280; }
    .label { font-size: 13px; font-weight: bold; fill: #111827; }
    .code { font-family: monospace; font-size: 12px; fill: #065f46; }
    .box { fill: #f9fafb; stroke: #e5e7eb; stroke-width: 1; rx: 10; }
  </style>

  <!-- TITLE -->
  <text x="500" y="40" text-anchor="middle" class="title">SQL JOINs Visual + Exemplos</text>
  <text x="500" y="65" text-anchor="middle" class="subtitle">Representação gráfica + código</text>

  <!-- INNER JOIN -->
  <g>
    <rect x="40" y="100" width="420" height="200" class="box"/>
    <text x="250" y="120" text-anchor="middle" class="label">INNER JOIN</text>

    <!-- Diagram -->
    <circle cx="170" cy="170" r="50" fill="#60a5fa"/>
    <circle cx="230" cy="170" r="50" fill="#34d399"/>
    <clipPath id="clipInner">
      <circle cx="170" cy="170" r="50"/>
    </clipPath>
    <circle cx="230" cy="170" r="50" fill="#059669" clip-path="url(#clipInner)"/>

    <!-- SQL -->
    <text x="60" y="230" class="code">
SELECT c.nome, p.produto
    </text>
    <text x="60" y="245" class="code">
FROM clientes c
    </text>
    <text x="60" y="260" class="code">
INNER JOIN pedidos p
    </text>
    <text x="60" y="275" class="code">
ON c.id = p.cliente_id;
    </text>
  </g>

  <!-- LEFT JOIN -->
  <g>
    <rect x="520" y="100" width="420" height="200" class="box"/>
    <text x="730" y="120" text-anchor="middle" class="label">LEFT JOIN</text>

    <circle cx="650" cy="170" r="50" fill="#2563eb"/>
    <circle cx="710" cy="170" r="50" fill="#d1d5db"/>

    <text x="540" y="230" class="code">
SELECT c.nome, p.produto
    </text>
    <text x="540" y="245" class="code">
FROM clientes c
    </text>
    <text x="540" y="260" class="code">
LEFT JOIN pedidos p
    </text>
    <text x="540" y="275" class="code">
ON c.id = p.cliente_id;
    </text>
  </g>

  <!-- RIGHT JOIN -->
  <g>
    <rect x="40" y="340" width="420" height="200" class="box"/>
    <text x="250" y="360" text-anchor="middle" class="label">RIGHT JOIN</text>

    <circle cx="170" cy="410" r="50" fill="#d1d5db"/>
    <circle cx="230" cy="410" r="50" fill="#059669"/>

    <text x="60" y="470" class="code">
SELECT c.nome, p.produto
    </text>
    <text x="60" y="485" class="code">
FROM clientes c
    </text>
    <text x="60" y="500" class="code">
RIGHT JOIN pedidos p
    </text>
    <text x="60" y="515" class="code">
ON c.id = p.cliente_id;
    </text>
  </g>

  <!-- FULL JOIN -->
  <g>
    <rect x="520" y="340" width="420" height="200" class="box"/>
    <text x="730" y="360" text-anchor="middle" class="label">FULL JOIN</text>

    <circle cx="650" cy="410" r="50" fill="#2563eb"/>
    <circle cx="710" cy="410" r="50" fill="#059669"/>

    <text x="540" y="470" class="code">
SELECT c.nome, p.produto
    </text>
    <text x="540" y="485" class="code">
FROM clientes c
    </text>
    <text x="540" y="500" class="code">
FULL OUTER JOIN pedidos p
    </text>
    <text x="540" y="515" class="code">
ON c.id = p.cliente_id;
    </text>
  </g>

  <!-- CROSS JOIN -->
  <g>
    <rect x="280" y="580" width="420" height="200" class="box"/>
    <text x="490" y="600" text-anchor="middle" class="label">CROSS JOIN</text>

    <rect x="420" y="630" width="50" height="50" fill="#2563eb"/>
    <rect x="500" y="630" width="50" height="50" fill="#059669"/>

    <text x="300" y="700" class="code">
SELECT c.nome, p.produto
    </text>
    <text x="300" y="715" class="code">
FROM clientes c
    </text>
    <text x="300" y="730" class="code">
CROSS JOIN pedidos p;
    </text>
  </g>

</svg>
```.text)


//#image(svg)
//#image(svg2)
#image("sql.svg")
