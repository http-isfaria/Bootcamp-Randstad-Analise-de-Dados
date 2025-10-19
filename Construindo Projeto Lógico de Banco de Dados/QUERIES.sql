-- ----------------------------------------------------------------------
-- PERSISTÊNCIA DE DADOS (DML)
-- ----------------------------------------------------------------------
USE ecommerce;

-- 1. Clientes (3 PF e 2 PJ)
INSERT INTO Cliente (Email, Endereco, TipoCliente) VALUES 
('joao.silva@email.com', 'Rua A, 100', 'PF'),      -- idCliente = 1
('maria.santos@email.com', 'Av. B, 50', 'PF'),     -- idCliente = 2
('alpha.corp@email.com', 'Rua C, 300', 'PJ'),     -- idCliente = 3
('beta.tech@email.com', 'Av. D, 120', 'PJ'),      -- idCliente = 4
('carlos.melo@email.com', 'Travessa E, 88', 'PF'); -- idCliente = 5

-- Detalhes PF
INSERT INTO Cliente_PF (idCliente, Nome, CPF, DataNascimento) VALUES
(1, 'João Silva', '11122233344', '1990-05-15'),
(2, 'Maria Santos', '22233344455', '1985-11-20'),
(5, 'Carlos Melo', '33344455566', '2000-01-01');

-- Detalhes PJ
INSERT INTO Cliente_PJ (idCliente, RazaoSocial, CNPJ, NomeFantasia) VALUES
(3, 'Alpha Corp Serviços Digitais S.A.', '00000000000000', 'Alpha Corp'),
(4, 'Beta Tech Soluções em Informática Ltda.', '11111111111111', 'Beta Tech');

-- 2. Pagamento (formas cadastradas por clientes)
INSERT INTO Pagamento (idCliente, TipoPagamento, Detalhes, LimiteDisponivel) VALUES
(1, 'Cartão', '****1234', 5000.00),
(1, 'Pix', 'joao.pix@email.com', 0.00),
(3, 'Boleto', 'Vencimento 3 dias', 0.00),
(4, 'Cartão', '****9999', 10000.00);

-- 3. Produtos
INSERT INTO Produto (Nome, Descricao, Categoria) VALUES
('Smartphone X', 'Celular avançado com 128GB', 'Eletrônicos'), -- idProduto = 1
('Camiseta Algodão', 'Camiseta básica de algodão, cor preta', 'Vestuário'), -- idProduto = 2
('Livro SQL Avançado', 'Guia completo de SQL', 'Livros'), -- idProduto = 3
('Drone FPV', 'Drone para voo em primeira pessoa', 'Eletrônicos'), -- idProduto = 4
('Chocolate Premium', 'Barra de chocolate 70% cacau', 'Alimentos'); -- idProduto = 5

-- 4. Fornecedores
INSERT INTO Fornecedor (RazaoSocial, CNPJ) VALUES
('Tech Supplies Ltda', '22222222222222'), -- idFornecedor = 1
('Mundo Textil S.A.', '33333333333333'); -- idFornecedor = 2

-- 5. Vendedores Terceiros (Marketplace)
INSERT INTO VendedorTerceiro (RazaoSocial, NomeFantasia, CNPJ) VALUES
('Eletronica Geral Eireli', 'EG Vendas', '44444444444444'), -- idVendedor = 1
('Livraria Conhecer', 'LC Livros', '55555555555555'); -- idVendedor = 2

-- 6. Estoques
INSERT INTO Estoque (Local) VALUES
('SP - Galpão Central'), -- idEstoque = 1
('MG - Filial Leste');   -- idEstoque = 2

-- 7. Relação Produto-Fornecedor (Quem fornece o quê)
INSERT INTO Produtos_Fornecedor (idProduto, idFornecedor) VALUES
(1, 1), -- Smartphone (Tech Supplies)
(2, 2), -- Camiseta (Mundo Textil)
(4, 1); -- Drone (Tech Supplies)

-- 8. Relação Produto-Vendedor (Quem vende o quê)
INSERT INTO Produtos_Vendedor (idProduto, idVendedor) VALUES
(1, 1), -- Smartphone (EG Vendas)
(3, 2); -- Livro (LC Livros)

-- 9. Relação Produto-Estoque (Onde está e quanto há)
INSERT INTO Produtos_Estoque (idProduto, idEstoque, Quantidade) VALUES
(1, 1, 50),
(1, 2, 30), -- Produto 1 está em 2 estoques (para teste de HAVING)
(2, 1, 100),
(3, 2, 20),
(4, 1, 15);

-- 10. Pedidos (4 pedidos)
INSERT INTO Pedido (idCliente, DescricaoPedido) VALUES
(1, 'Primeira compra de Eletrônicos'), -- idPedido = 1 (João)
(3, 'Compra corporativa de livros'),     -- idPedido = 2 (Alpha Corp)
(2, 'Vestuário e Alimentos'),            -- idPedido = 3 (Maria)
(1, 'Segunda compra, Drone'),            -- idPedido = 4 (João)
(5, 'Produto de baixo custo');           -- idPedido = 5 (Carlos)

-- 11. Produtos do Pedido (Itens do carrinho)
INSERT INTO Produtos_Pedido (idPedido, idProduto, Quantidade, ValorUnitario) VALUES
(1, 1, 1, 1999.99),
(2, 3, 10, 89.50),
(3, 2, 3, 49.90),
(3, 5, 2, 12.00),
(4, 4, 1, 4500.00),
(5, 5, 1, 12.00);

-- 12. Entregas
INSERT INTO Entrega (idPedido, StatusEntrega, CodigoRastreio, ValorFrete, DataPrevista) VALUES
(1, 'Entregue', 'BR123456789BR', 15.50, '2025-11-01'),
(2, 'Em Transporte', 'BR987654321BR', 45.00, '2025-10-25'),
(3, 'Pendente', 'BR111222333BR', 10.00, '2025-11-10'),
(4, 'Enviado', 'BR444555666BR', 30.00, '2025-10-28'),
(5, 'Pendente', 'BR777888999BR', 8.00, '2025-11-15');

-- ----------------------------------------------------------------------
-- CONSULTAS SQL (DQL)
-- ----------------------------------------------------------------------

-- Pergunta 1: Quantos pedidos foram feitos por cada cliente?
-- Cláusulas: SELECT, JOIN, GROUP BY, Expressão de Agregação (COUNT)
SELECT
    -- COALESCE é usado para exibir o nome correto, pois nem todo cliente tem NomeFantasia (PF/PJ)
    COALESCE(PF.Nome, PJ.NomeFantasia) AS Nome_Cliente, 
    C.TipoCliente,
    COUNT(P.idPedido) AS Total_Pedidos
FROM 
    Cliente C
LEFT JOIN 
    Cliente_PF PF ON C.idCliente = PF.idCliente
LEFT JOIN 
    Cliente_PJ PJ ON C.idCliente = PJ.idCliente
INNER JOIN 
    Pedido P ON C.idCliente = P.idCliente
GROUP BY 
    C.idCliente
ORDER BY
    Total_Pedidos DESC;


-- Pergunta 2: Qual o valor total de cada pedido, incluindo frete, e qual foi o mais caro?
-- Cláusulas: SELECT, JOIN, Expressões Derivadas, ORDER BY
SELECT
    PP.idPedido,
    P.DescricaoPedido,
    E.ValorFrete AS Frete,
    -- Expressão para gerar atributo derivado: (Soma do valor dos produtos) + Frete
    ROUND(SUM(PP.Quantidade * PP.ValorUnitario), 2) AS Subtotal_Produtos,
    ROUND(SUM(PP.Quantidade * PP.ValorUnitario) + E.ValorFrete, 2) AS Valor_Total_Pedido
FROM
    Produtos_Pedido PP
INNER JOIN
    Pedido P ON PP.idPedido = P.idPedido
INNER JOIN
    Entrega E ON P.idPedido = E.idPedido
GROUP BY
    PP.idPedido, E.ValorFrete -- Agrupa por pedido para somar os produtos
ORDER BY
    Valor_Total_Pedido DESC; -- Ordena para encontrar o mais caro

-- Pergunta 3: Quais produtos (com preço unitário > R$ 100,00) têm um estoque total combinado (soma de todos os locais) superior a 50 unidades?
-- Cláusulas: SELECT, WHERE, GROUP BY, HAVING, JOIN, Expressão de Agregação (SUM)
SELECT
    Prod.Nome AS Nome_Produto,
    Prod.Categoria,
    SUM(PE.Quantidade) AS Estoque_Total_Combinado
FROM
    Produto Prod
INNER JOIN
    Produtos_Estoque PE ON Prod.idProduto = PE.idProduto
-- Filtro WHERE para incluir apenas produtos que custam mais de R$ 100 (Assumindo um valor de custo ou preço de venda de referência)
WHERE
    Prod.idProduto IN (SELECT idProduto FROM Produtos_Pedido WHERE ValorUnitario > 100) -- Exemplo de subconsulta para obter o critério de preço
GROUP BY
    Prod.idProduto
-- Filtro HAVING para restringir os grupos (Estoque Total > 50)
HAVING
    Estoque_Total_Combinado > 50
ORDER BY
    Estoque_Total_Combinado DESC;


-- Pergunta 4: Algum vendedor (Terceiro) também é um fornecedor?
-- Cláusulas: SELECT, JOIN (Self-Join/Subquery), WHERE (Filtro simples para comparação)
SELECT
    VT.RazaoSocial AS Vendedor_RazaoSocial,
    F.RazaoSocial AS Fornecedor_RazaoSocial,
    VT.CNPJ
FROM
    VendedorTerceiro VT
INNER JOIN
    Fornecedor F ON VT.CNPJ = F.CNPJ; 
-- Resultado: Esta query retorna zero registros porque os dados de teste foram criados com CNPJs distintos, simulando que eles são entidades diferentes.
-- Se houvesse um match, indicaria que a mesma empresa CNPJ atua nas duas funções.


-- Pergunta 5: Relação de nomes dos fornecedores e nomes dos produtos que eles fornecem.
-- Cláusulas: SELECT, JOIN (Junções entre 3 tabelas)
SELECT
    F.RazaoSocial AS Nome_Fornecedor,
    P.Nome AS Nome_Produto,
    P.Categoria
FROM
    Fornecedor F
INNER JOIN
    Produtos_Fornecedor PF ON F.idFornecedor = PF.idFornecedor
INNER JOIN
    Produto P ON PF.idProduto = P.idProduto
ORDER BY
    Nome_Fornecedor, Nome_Produto;
    
-- Pergunta 6: Quais pedidos estão em transporte e quais são suas datas previstas de entrega?
-- Cláusulas: SELECT, JOIN, WHERE, ORDER BY
SELECT
    P.idPedido,
    COALESCE(PF.Nome, PJ.RazaoSocial) AS Cliente,
    P.DescricaoPedido,
    E.StatusEntrega,
    E.CodigoRastreio,
    E.DataPrevista
FROM 
    Pedido P
INNER JOIN 
    Entrega E ON P.idPedido = E.idPedido
LEFT JOIN 
    Cliente_PF PF ON P.idCliente = PF.idCliente
LEFT JOIN 
    Cliente_PJ PJ ON P.idCliente = PJ.idCliente
WHERE
    E.StatusEntrega = 'Em Transporte' -- Filtro WHERE
ORDER BY
    E.DataPrevista ASC; -- Ordenação
