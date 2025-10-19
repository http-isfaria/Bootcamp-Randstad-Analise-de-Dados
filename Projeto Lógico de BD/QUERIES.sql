-- ----------------------------------------------------------------------
-- PERSISTÊNCIA DE DADOS (DML)
-- ----------------------------------------------------------------------
USE oficina;

-- 1. Clientes (3 PF e 2 PJ)
INSERT INTO Cliente (Telefone, Email, Endereco, TipoCliente) VALUES 
('11987654321', 'ana.souza@email.com', 'Rua das Flores, 10', 'PF'),      -- idCliente = 1
('21999998888', 'banca.com@email.com', 'Av. Central, 500', 'PJ'),        -- idCliente = 2
('31988887777', 'carlos.moraes@email.com', 'Rua B, 25', 'PF'),           -- idCliente = 3
('41977776666', 'deltalog@email.com', 'Rodovia 101, Km 5', 'PJ'),        -- idCliente = 4
('51966665555', 'eduardo.ferr@email.com', 'Av. Mar, 33', 'PF');          -- idCliente = 5

-- Detalhes PF
INSERT INTO Cliente_PF (idCliente, Nome, CPF) VALUES
(1, 'Ana Souza', '11111111111'),
(3, 'Carlos Moraes', '22222222222'),
(5, 'Eduardo Ferraz', '33333333333');

-- Detalhes PJ
INSERT INTO Cliente_PJ (idCliente, RazaoSocial, CNPJ, NomeContato) VALUES
(2, 'Banca Soluções S.A.', '00000000000000', 'João Gerente'),
(4, 'Delta Logística Ltda.', '11111111111111', 'Maria Suprimentos');

-- 2. Veículos
INSERT INTO Veiculo (idCliente, Placa, Marca, Modelo, AnoFabricacao, Cor) VALUES
(1, 'ABC1234', 'Ford', 'Ka', 2018, 'Prata'), -- idVeiculo = 1 (Ana)
(3, 'DEF5678', 'VW', 'Gol', 2010, 'Branco'), -- idVeiculo = 2 (Carlos)
(2, 'GHI9012', 'Fiat', 'Ducato', 2022, 'Azul'), -- idVeiculo = 3 (Banca Soluções - Frota)
(4, 'JKL3456', 'Volvo', 'FH540', 2021, 'Vermelho'), -- idVeiculo = 4 (Delta Logística - Caminhão)
(5, 'MNO7890', 'Honda', 'Civic', 2015, 'Preto'); -- idVeiculo = 5 (Eduardo)

-- 3. Equipes
INSERT INTO Equipe (DescricaoEquipe, Especialidade) VALUES
('Equipe Alpha', 'Mecânica Geral'), -- idEquipe = 1
('Equipe Beta', 'Elétrica e Eletrônica'), -- idEquipe = 2
('Equipe Gamma', 'Pesados e Suspensão'); -- idEquipe = 3

-- 4. Mecânicos
INSERT INTO Mecanico (idEquipe, Nome, CPF, Salario, DataContratacao) VALUES
(1, 'Pedro Silva', '44444444444', 2500.00, '2022-01-10'), -- idMecanico = 1
(1, 'Lucas Rocha', '55555555555', 2800.00, '2021-05-15'), -- idMecanico = 2
(2, 'Renata Souza', '66666666666', 3200.00, '2023-03-20'), -- idMecanico = 3
(3, 'Felipe Alves', '77777777777', 3500.00, '2020-08-01'); -- idMecanico = 4

-- 5. Tabela de Serviços Padrão
INSERT INTO TabelaServico (Descricao, ValorPadrao) VALUES
('Troca de Óleo e Filtro', 150.00), -- idServicoBase = 1
('Revisão de Freios', 200.00),       -- idServicoBase = 2
('Diagnóstico Elétrico', 120.00),    -- idServicoBase = 3
('Alinhamento e Balanceamento', 80.00); -- idServicoBase = 4

-- 6. Ordem de Serviço (OS)
INSERT INTO Servico (idVeiculo, idEquipe, StatusServico, DescricaoDefeito) VALUES
(1, 1, 'Em Execução', 'Troca de óleo de rotina'),     -- idServico = 1 (Ka - Equipe Alpha)
(2, 2, 'Aguardando Aprovação', 'Farol queimado e falha intermitente'), -- idServico = 2 (Gol - Equipe Beta)
(4, 3, 'Concluído', 'Manutenção preventiva da suspensão'),  -- idServico = 3 (Caminhão - Equipe Gamma)
(5, 1, 'Em Avaliação', 'Barulho no motor'); -- idServico = 4 (Civic - Equipe Alpha)

-- 7. Itens da OS (Serviços Executados)
INSERT INTO ItensServico (idServico, idServicoBase, CustoMaoObra) VALUES
(1, 1, 80.00), -- OS 1: Troca de Óleo (Mão de obra)
(2, 3, 120.00), -- OS 2: Diagnóstico Elétrico (Mão de obra)
(3, 2, 150.00), -- OS 3: Revisão de Freios (Mão de obra)
(3, 4, 60.00);  -- OS 3: Alinhamento (Mão de obra)

-- 8. Peças
INSERT INTO Peca (NomePeca, Fabricante, ValorCusto) VALUES
('Filtro de Óleo', 'Fram', 15.00),    -- idPeca = 1
('Pastilha de Freio', 'Bosh', 80.00),  -- idPeca = 2
('Lâmpada H4', 'Osram', 12.00),        -- idPeca = 3
('Amortecedor Dianteiro', 'Cofap', 350.00); -- idPeca = 4

-- 9. Estoque
INSERT INTO EstoquePeca (Localizacao) VALUES
('Prateleira A'), -- idEstoque = 1
('Armário B');    -- idEstoque = 2

-- 10. Peças em Estoque
INSERT INTO Pecas_Estoque (idPeca, idEstoque, Quantidade) VALUES
(1, 1, 50),
(2, 2, 20),
(3, 1, 100),
(4, 2, 5);

-- 11. Peças Usadas no Serviço
INSERT INTO Pecas_Servico (idServico, idPeca, QuantidadeUtilizada, PrecoVendaUnitario) VALUES
(1, 1, 1, 30.00), -- OS 1: 1 Filtro de Óleo
(2, 3, 1, 25.00), -- OS 2: 1 Lâmpada H4
(3, 2, 4, 120.00), -- OS 3: 4 Pastilhas de Freio
(3, 4, 2, 450.00); -- OS 3: 2 Amortecedores

-- 12. Pagamento (Apenas a OS 3 está concluída e paga)
INSERT INTO PagamentoServico (idServico, TipoPagamento, ValorTotalPago, StatusPagamento) VALUES
(3, 'Cartão Crédito', 1615.00, 'Concluído');
-- Cálculo OS 3: Mão de obra (150+60) + Peças (4*120 + 2*450) = 210 + 480 + 900 = 1615.00 (Exemplo de valor)

-- ----------------------------------------------------------------------
-- CONSULTAS SQL COMPLEXAS (DQL)
-- ----------------------------------------------------------------------

-- Pergunta 1: Qual o valor total (peças + mão de obra) de cada Ordem de Serviço que ainda NÃO foi concluída?
-- Cláusulas: SELECT, JOIN, Expressão Derivada, WHERE, GROUP BY, ORDER BY, Expressão de Agregação (SUM)
SELECT
    S.idServico AS OS,
    V.Placa,
    V.Marca,
    -- Expressão Derivada: Soma dos custos de Peças
    ROUND(COALESCE(SUM(PS.QuantidadeUtilizada * PS.PrecoVendaUnitario), 0), 2) AS Custo_Pecas,
    -- Expressão Derivada: Soma dos custos de Mão de Obra
    ROUND(COALESCE(SUM(IT.CustoMaoObra), 0), 2) AS Custo_Mao_Obra,
    -- Expressão Derivada: Custo Total Estimado
    ROUND(
        COALESCE(SUM(PS.QuantidadeUtilizada * PS.PrecoVendaUnitario), 0) + 
        COALESCE(SUM(IT.CustoMaoObra), 0), 
        2
    ) AS Valor_Total_Estimado,
    S.StatusServico
FROM
    Servico S
INNER JOIN
    Veiculo V ON S.idVeiculo = V.idVeiculo
LEFT JOIN
    Pecas_Servico PS ON S.idServico = PS.idServico
LEFT JOIN
    ItensServico IT ON S.idServico = IT.idServico
-- Filtro WHERE: Apenas serviços que não estão Concluído ou Cancelado
WHERE
    S.StatusServico NOT IN ('Concluído', 'Cancelado')
GROUP BY
    S.idServico, V.Placa, V.Marca, S.StatusServico
ORDER BY
    Valor_Total_Estimado DESC;


-- Pergunta 2: Quais equipes têm mais de 2 Mecânicos e qual o salário médio da Equipe?
-- Cláusulas: SELECT, GROUP BY, HAVING, Expressão Derivada (AVG), Expressão de Agregação (COUNT)
SELECT
    E.DescricaoEquipe,
    E.Especialidade,
    COUNT(M.idMecanico) AS Total_Mecanicos,
    -- Expressão Derivada: Salário Médio
    ROUND(AVG(M.Salario), 2) AS Salario_Medio
FROM
    Equipe E
INNER JOIN
    Mecanico M ON E.idEquipe = M.idEquipe
GROUP BY
    E.idEquipe, E.DescricaoEquipe, E.Especialidade
-- Filtro HAVING: Restringe o grupo a equipes com mais de 2 membros
HAVING
    Total_Mecanicos > 2;
-- Nota: Nos dados de teste, apenas a Equipe Alpha tem 2 mecânicos, então esta query deve retornar 0 resultados.

-- Pergunta 3: Rastrear quais clientes PF têm veículos com ano de fabricação anterior a 2015 e qual o status da última OS (se houver).
-- Cláusulas: SELECT, JOIN (Junções entre 4 tabelas), WHERE, ORDER BY, COALESCE
SELECT
    PF.Nome AS Nome_Cliente_PF,
    C.Telefone,
    V.Placa,
    V.Marca,
    V.AnoFabricacao,
    -- COALESCE para lidar com clientes sem OS aberta.
    COALESCE(S.StatusServico, 'Nenhuma OS Encontrada') AS Ultimo_Status_OS,
    S.DataEmissao
FROM
    Cliente C
INNER JOIN
    Cliente_PF PF ON C.idCliente = PF.idCliente
INNER JOIN
    Veiculo V ON C.idCliente = V.idCliente
LEFT JOIN -- LEFT JOIN para incluir clientes mesmo sem OS
    Servico S ON V.idVeiculo = S.idVeiculo
-- Filtro WHERE: Clientes PF (já filtrado pelo JOIN) e veículos antigos
WHERE
    V.AnoFabricacao < 2015
ORDER BY
    PF.Nome, S.DataEmissao DESC; -- Ordena por nome e pela data da OS mais recente


-- Pergunta 4: Gerar um relatório de inventário mostrando todas as peças com a quantidade total em estoque. Incluir o custo total do estoque para cada peça.
-- Cláusulas: SELECT, JOIN, Expressão Derivada, GROUP BY, ORDER BY, Expressão de Agregação (SUM)
SELECT
    P.NomePeca,
    P.Fabricante,
    P.ValorCusto AS Custo_Unitario,
    -- Expressão Agregação: Soma das quantidades em todos os estoques
    SUM(PE.Quantidade) AS Quantidade_Total_Em_Estoque,
    -- Expressão Derivada: Custo Total de Estoque (Unitário * Total)
    ROUND(SUM(PE.Quantidade) * P.ValorCusto, 2) AS Custo_Total_Estoque
FROM
    Peca P
INNER JOIN
    Pecas_Estoque PE ON P.idPeca = PE.idPeca
GROUP BY
    P.idPeca, P.NomePeca, P.Fabricante, P.ValorCusto
ORDER BY
    Custo_Total_Estoque DESC;


-- Pergunta 5: Quais peças foram usadas em serviços e qual o lucro potencial *médio* dessas peças? (Lucro = Preço Venda - Custo)
-- Cláusulas: SELECT, JOIN, Expressão Derivada, GROUP BY, Expressão de Agregação (AVG)
SELECT
    P.NomePeca,
    P.Fabricante,
    -- Expressão Derivada: Lucro Unitário
    ROUND(AVG(PS.PrecoVendaUnitario - P.ValorCusto), 2) AS Lucro_Medio_Por_Peca_Usada,
    -- Expressão Agregação: Total de Peças Usadas
    SUM(PS.QuantidadeUtilizada) AS Total_Vendido
FROM
    Peca P
INNER JOIN
    Pecas_Servico PS ON P.idPeca = PS.idPeca
GROUP BY
    P.idPeca, P.NomePeca, P.Fabricante
ORDER BY
    Lucro_Medio_Por_Peca_Usada DESC;
