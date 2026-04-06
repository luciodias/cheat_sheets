#set page(
    paper:"a4", 
    flipped: true,
    margin: (rest: 0.5cm),
    columns: 3,
    footer: grid(columns:(1fr, auto, auto),
        [Haskell Cheat Sheet],
        align(center)[P1],
        align(right)[Lúcio Dia da Silva],
    )
)
#let borda = 0.6pt + silver //none or 1pt + black
#let hs(body) = raw(body,lang: "haskell") 

=== List Comprehensions
#hs("squares = [x \* x | x \<- [1..]]")

=== Declarando Types e Classes

#table(
  stroke: borda, columns:(1fr, 3fr,),align: horizon,
  "type synonym type",
  hs("MyType = Type
  type PairList a b = [(a,b)]
  type String = [Char] -- from Prelude"),
  "data (single constructor)",
  hs("data MyData = MyData Type Type
  deriving (Class, Class)"),
  "data (multi constructor)",
  hs("data MyData = Simple Type
  | Duple Type Type
  | Nople"),
  "data (record syntax)",
  hs("data MDt = MDt { fieldA
  , fieldB:: TyAB
  , fieldC:: TyC }"),
  "newtype",
  hs("newtype MyType = MyType Type
  (single constr./field) deriving (Class,Class)"),
  "typeclass",
  hs("class MyClass a where
  foo:: a -> a -> b
  goo:: a -> a"),
  "typeclass instance",
  hs("instance MyClass MyType where
  foo x y = ...
  goo x = ..."),
)

=== Misc
#table(
  stroke: borda, columns:(auto,auto,auto,),align: horizon,
  "id",hs(":: a -> a"), "id x ≡ x -- identity",
  "const",hs(":: a -> b -> a"), "(const x) y ≡ xc",
  "undefined",hs(":: a"),"undefined ≡ ⊥ (lifts error)",
  "error",hs(":: [Char] -> a"),"error cs ≡ ⊥ (lifts error cs)",
  "not",hs(":: Bool -> Bool"),"not True ≡ False",
  "flip",hs("::(a->b->c)->b->a->c"),"flip f $ x y ≡ f y x",
)

=== Listas
#table(
  stroke: borda, columns:(6fr,9fr,10fr),align: horizon,
  "null",hs(":: [a] -> Bool"),"null [] ≡ True -- ∅?",
  "length",hs(":: [a] -> Int"),"length [x,y,z ] ≡ 3",
  "elem",hs(":: a -> [a] -> Bool"),"y ‘elem‘ [x,y ] ≡ True -- ∈?",
  "head",hs(":: [a] -> a"),"head [x,y,z,w ] ≡ x",
  "last",hs(":: [a] -> a"),"last [x,y,z,w ] ≡ w",
  "tail",hs(":: [a] -> [a]"),"tail [x,y,z,w ] ≡ [y,z,w ]",
  "init",hs(":: [a] -> [a]"),"init [x,y,z,w ] ≡ [x,y,z ]",
  "reverse",hs(":: [a] -> [a]"),"reverse [x,y,z ] ≡ [z,y,x ]",
  "take",hs(":: Int -> [a] -> [a]"),"take 2 [x,y,z ] ≡ [x,y ]",
  "drop",hs(":: Int -> [a] -> [a]"),"drop 2 [x,y,z ] ≡ [z ]",
  "takeWhile, dropWhile",hs(":: (a -> Bool) -> [a] -> [a]"),
  "takeWhile (/= z ) [x,y,z,w ] ≡ [x,y ]",
  "zip",hs(":: [a] -> [b] -> [(a, b)]"),
  "zip [x,y,z ] [a,b ] ≡ [(x,a ),(y,b )]",
  "repeat",hs(":: a -> [a]"),"repeat x ≡ [x,x,x,x,x,x,...]",
  "cycle",hs(":: [a] -> [a]"),"cycle xs ≡ xs ++xs ++xs ++... 
  cycle [x,y ] ≡ [x,y,x,y,x,y,...]",
  "iterate",hs(":: (a -> a) -> a -> [a]"),
  "iterate f x ≡ [x,f x,f (f x ),...]",
)

=== Higher-order / Functors
#table(
  stroke: borda, columns:(auto,9fr),align: horizon,
  "map",hs("::(a->b) -> [a] -> [b]"),
  "map",hs("f [x,y,z ] ≡ [f x, f y, f z ]"),
  "zipWith",hs(":: (a -> b -> c) -> [a] -> [b] -> [c]"),
  "zipWith",hs("f [x,y,z ] [a,b ] ≡ [f x a, f y b ]"),
  "filter",hs(":: (a -> Bool) -> [a] -> [a]"),
  "filter",hs("(/=y) [x,y,z ] ≡ [x,z ]"),
  "foldr",hs(":: (a -> b -> b) -> b -> [a] -> b"),
  "foldr",hs("f z [x,y ] ≡ x ‘f ‘ (y ‘f ‘ z )"),
  "foldl",hs(":: (a -> b -> a) -> a -> [b] -> a"),
  "foldl",hs("f x [y,z ] ≡ (x ‘f ‘ y ) ‘f ‘ z"),
)

=== Special folds
#table(
  stroke: borda, columns:(auto,9fr),align: horizon,
  "and",hs(":: [Bool] -> Bool and [p,q,r ] ≡ p && q && r"),
  "or",hs(":: [Bool] -> Bool or [p,q,r ] ≡ p || q || r"),
  "sum",hs(":: Num a => [a] -> a sum [i,j,k ] ≡ i +j +k"),
  "product",hs(":: Num a => [a] -> a product [i,j,k ] ≡ i *j *k"),
  "maximum",hs(":: Ord a => [a] -> a maximum [9,0,5] ≡ 9"),
  "minimum",hs(":: Ord a => [a] -> a minimum [9,0,5] ≡ 0"),
  "concat",hs(":: [[a]] ->[a] concat [xs,ys,zs ] ≡ xs ++ys ++zs"),
)

#hs(
"
-- Tipo Categoria
data Categoria = Livro | Brinquedo | Escritorio
  deriving (Show, Eq)

-- Tipo Produto
data Produto = Produto {
    nome :: String,
    valor :: Double,
    categoria :: Categoria
} deriving (Show, Eq)

-- Lista de exemplos
produtos :: [Produto]
produtos = [
    Produto \"Livro A\" 50.0 Livro,
    Produto \"Carrinho\" 30.0 Brinquedo,
    Produto \"Caderno\" 20.0 Escritorio,
    Produto \"Livro B\" 40.0 Livro,
    Produto \"Boneca\" 25.0 Brinquedo
    ]

-- 1. extrair: retorna lista de preços
extrair :: [Produto] -> [Double]
extrair ps = [valor p | p <- ps]

-- 2. minValor: menor preço
minValor :: [Produto] -> Double
minValor ps = minimum (extrair ps)

-- 3. livrEscr: remove brinquedos
livrEscr :: [Produto] -> [Produto]
livrEscr ps = [p | p <- ps, categoria p /= Brinquedo]

-- 4. avgLivrEscr: média dos não brinquedos
avgLivrEscr :: [Produto] -> Double
avgLivrEscr ps =
    let lista = extrair (livrEscr ps)
    in sum lista / fromIntegral (length lista)

-- 5. maxMinLivr: maior e menor preço dos livros
maxMinLivr :: [Produto] -> (Double, Double)
maxMinLivr ps =
    let livros = [valor p | p <- ps, categoria p == Livro]
    in (maximum livros, minimum livros)

-- 6. countBrinq: quantidade de brinquedos
countBrinq :: [Produto] -> Int
countBrinq ps = length [p | p <- ps, categoria p == Brinquedo]
"
)

#hs(
"
-- 1. extrair: usando map
extrair :: [Produto] -> [Double]
extrair = map valor

-- 2. minValor: usando fold
minValor :: [Produto] -> Double
minValor ps = foldr1 min (map valor ps)

-- 3. livrEscr: usando filter
livrEscr :: [Produto] -> [Produto]
livrEscr = filter (\p -> categoria p /= Brinquedo)

-- 4. avgLivrEscr: usando map, filter e fold
avgLivrEscr :: [Produto] -> Double
avgLivrEscr ps =
    let lista = map valor (filter (\p -> categoria p /= Brinquedo) ps)
        (soma, qtd) = foldr (\x (s, c) -> (s + x, c + 1)) (0, 0) lista
    in soma / fromIntegral qtd

-- 5. maxMinLivr: usando filter, map e fold
maxMinLivr :: [Produto] -> (Double, Double)
maxMinLivr ps =
    let livros = map valor (filter (\p -> categoria p == Livro) ps)
    in foldr1 (\x (mx, mn) -> (max x mx, min x mn))
              (map (\v -> (v, v)) livros)

-- 6. countBrinq: usando filter
countBrinq :: [Produto] -> Int
countBrinq = foldr (\p acc -> if categoria p == Brinquedo then acc + 1 else acc) 0
"
)

