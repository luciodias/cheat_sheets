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
    Produto "Livro A" 50.0 Livro,
    Produto "Carrinho" 30.0 Brinquedo,
    Produto "Caderno" 20.0 Escritorio,
    Produto "Livro B" 40.0 Livro,
    Produto "Boneca" 25.0 Brinquedo
    ]

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