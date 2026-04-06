#set page(
    paper:"a4", 
    flipped: true,
    margin: (rest: 0.5cm),
    columns: 3,
    footer: grid(columns:(1fr, 1fr, 1fr),
        [Haskell Cheat Sheet],
        align(center)[P1],
        align(right)[Lúcio Dia da Silva],
    )
)

1. (2.5 pontos) Considere o tipo Produto contendo os campos nome, valor e categoria. Os campos nome e valor são String e Double, respectivamente, ao passo que categoria é um tipo Categoria que possui os valores Livro, Brinquedo e Escritorio. Crie os dois tipos com instâncias necessárias para a solução deste exercício e implemente as funções:
\
- extrair :: [Produto] -> [Double] que retorna uma lista com todos os preços de produto;
- minValor :: [Produto] -> Double que retorna o preço do produto de valor mínimo;
- livrEscr :: [Produto] -> [Produto] que retorna os produtos que não sejam brinquedos;
- avgLivrEscr :: [Produto] -> Double que retorna a média dos produtos que não são brinquedos;
- maxMinLivr :: [Produto] -> (Double,Double) que retorna o maior e o menor preço dos livros;
- countBrinq :: [Produto] -> Int que retorna a quantidade de itens de brinquedo.

\
```haskell
data Produto = Produto{
    nome :: String
    , valor :: Double
    , categoria :: Categoria
} deriving (Show)
data Categoria = Livro ⌋ Brinquedo ⌋ Escritorio
```
\

2. (2.5 pontos) Sobre monóides:
- Considere o tipo data Sozinho = Sozinho, crie uma instância de Monoid para este tipo.
- Considere o operador binário:
```haskell
ign :: String -> String -> String
ign l m = m
```
O tipo String com esta operação ign e o elemento neutro [] formam um monóide? Justifique sua resposta.

\
\

3. (2.5 pontos) Considere o tipo data Dupla a = Dupla a [Int]
- Qual o kind de Dupla Bool?
- Crie uma instância de Functor para Dupla.
- Qual o tipo da expressão Dupla ’5’ [0,1]?
- Qual o tipo da expressão Dupla?
- Crie uma instância de Show que mostre na tela uma dupla em formato de tuplas do Haskell. Por exemplo,
Dupla ’k’ [1,2,3] deverá ser mostrado (k,[1,2,3]).
- Faça uma função mostra :: Dupla a -> Either [Int] a que mostra a lista de inteiros caso o seu tamanho seja maior que zero ou o campo de tipo a caso contrário

\
\

4. (2.5 pontos) Dê o tipo das expressões abaixo da maneira mais genérica possível:
(a) \x -> x \
(b) id . tail \$ "HELLO" \
(c) 4*9 \
(d) ("FATEC", False, 'K') \
(e) [(False,False),(True,False),(False,True),(True,True)] \
(f) filter id \

\
\
#let char = "_____"
5. (2.5 pontos) Considere data () = () e complete:
f1 :: (a,b) -> (b,a,a) \
f1 #char = #char \
f2 :: a -> (a,a,a,()) \
f2 a = #char \
f3 :: Either a () -> Maybe a \
f3 #char = #char \
f3 #char = #char \
f4 :: (a -> b) -> (b -> z) -> (a -> z) \
f4 #char #char = #char \
f5 :: (a -> b) -> (c,a) -> (c,b) \
f5 g = #char \