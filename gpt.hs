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