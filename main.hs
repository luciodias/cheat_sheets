
data Categoria = Livro | Brinquedo | Escritorio deriving (Eq, Show)

data Produto = Produto{ nome :: String
    , valor :: Double
    , categoria :: Categoria
} deriving (Show)

produtos = [Produto "P1" 10.0 Livro, Produto "P2" 20.0 Brinquedo, Produto "P3" 30.0 Escritorio]

extrair :: [Produto] -> [Double] --que retorna uma lista com todos os preços de produto;
extrair [] = []
extrair (Produto _ valor _:xs) = valor : extrair xs

minValor :: [Produto] -> Double --que retorna o preço do produto de valor mínimo;
minValor [Produto _ valor _] = valor
minValor (Produto _ valor _:xs) = min valor (minValor xs)

livrEscr :: [Produto] -> [Produto] --que retorna os produtos que não sejam brinquedos;
livrEscr [] = []
livrEscr (Produto n v c:xs)
    | c /= Brinquedo = Produto n v c : livrEscr xs
    | otherwise = livrEscr xs

avgLivrEscr :: [Produto] -> Double --que retorna a média dos produtos que não são brinquedos;
avgLivrEscr [Produto _ valor _] = valor
avgLivrEscr

-- maxMinLivr :: [Produto] -> (Double,Double) --que retorna o maior e o menor preço dos livros;

scountBrinq :: [Produto] -> Int --que retorna a quantidade de itens de brinquedo.
scountBrinq [] = 0
scountBrinq (Produto _ _ c:xs)
    | c == Brinquedo = 1 + (scountBrinq xs)
    | otherwise = scountBrinq xs