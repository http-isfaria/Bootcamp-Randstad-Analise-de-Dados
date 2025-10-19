-- Criação do esquema
-- DROP DATABASE oficina;
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- ----------------------------------------------------------------------
-- 1. CLIENTES (Generalização/Especialização)
-- ----------------------------------------------------------------------

-- Tabela Super-tipo: Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Telefone VARCHAR(15) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Endereco VARCHAR(255) NOT NULL,
    TipoCliente ENUM('PF', 'PJ') NOT NULL
);

-- Tabela Sub-tipo: Pessoa Física
CREATE TABLE Cliente_PF (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    CONSTRAINT fk_cliente_pf_oficina FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Sub-tipo: Pessoa Jurídica
CREATE TABLE Cliente_PJ (
    idCliente INT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    NomeContato VARCHAR(255),
    CONSTRAINT fk_cliente_pj_oficina FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- ----------------------------------------------------------------------
-- 2. VEÍCULOS
-- ----------------------------------------------------------------------

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    Placa CHAR(7) NOT NULL UNIQUE,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    AnoFabricacao YEAR,
    Cor VARCHAR(30),
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- ----------------------------------------------------------------------
-- 3. MÃO DE OBRA E EQUIPES
-- ----------------------------------------------------------------------

CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    DescricaoEquipe VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(50) NOT NULL -- Ex: Eletrica, Mecanica Geral
);

CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    idEquipe INT NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Salario DECIMAL(10, 2),
    DataContratacao DATE,
    CONSTRAINT fk_mecanico_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- ----------------------------------------------------------------------
-- 4. SERVIÇOS E PEÇAS
-- ----------------------------------------------------------------------

-- Tabela de Serviços Padrão (Tabela de Preços)
CREATE TABLE TabelaServico (
    idServicoBase INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    ValorPadrao DECIMAL(10, 2) NOT NULL
);

-- Tabela Ordem de Serviço (OS)
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idEquipe INT, -- Equipe responsável
    DataEmissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataConclusaoPrevista DATE,
    StatusServico ENUM('Em Avaliação', 'Aguardando Aprovação', 'Em Execução', 'Concluído', 'Cancelado') NOT NULL DEFAULT 'Em Avaliação',
    DescricaoDefeito TEXT,
    CONSTRAINT fk_servico_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_servico_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela N:N: Itens da OS (Serviços executados na OS)
CREATE TABLE ItensServico (
    idServico INT NOT NULL,
    idServicoBase INT NOT NULL,
    CustoMaoObra DECIMAL(10, 2) NOT NULL,
    Observacoes TEXT,
    PRIMARY KEY (idServico, idServicoBase),
    CONSTRAINT fk_itens_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico),
    CONSTRAINT fk_itens_servico_base FOREIGN KEY (idServicoBase) REFERENCES TabelaServico(idServicoBase)
);

-- Tabela de Peças
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    NomePeca VARCHAR(100) NOT NULL,
    Fabricante VARCHAR(100),
    ValorCusto DECIMAL(10, 2) NOT NULL
);

-- Tabela N:N: Peças Utilizadas no Serviço
CREATE TABLE Pecas_Servico (
    idServico INT NOT NULL,
    idPeca INT NOT NULL,
    QuantidadeUtilizada INT DEFAULT 1,
    PrecoVendaUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idServico, idPeca),
    CONSTRAINT fk_pecas_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico),
    CONSTRAINT fk_pecas_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);

-- ----------------------------------------------------------------------
-- 5. ESTOQUE E PAGAMENTO
-- ----------------------------------------------------------------------

CREATE TABLE EstoquePeca (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Localizacao VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela N:N: Peças em Estoque
CREATE TABLE Pecas_Estoque (
    idPeca INT NOT NULL,
    idEstoque INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idPeca, idEstoque),
    CONSTRAINT fk_estoque_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca),
    CONSTRAINT fk_estoque_local FOREIGN KEY (idEstoque) REFERENCES EstoquePeca(idEstoque)
);

-- Tabela de Pagamento (Faturamento da OS)
CREATE TABLE PagamentoServico (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idServico INT UNIQUE NOT NULL, -- 1:1 com Servico
    TipoPagamento ENUM('Cartão Crédito', 'Débito', 'Boleto', 'Pix') NOT NULL,
    ValorTotalPago DECIMAL(10, 2) NOT NULL,
    DataPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    StatusPagamento ENUM('Pendente', 'Concluído', 'Cancelado') NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);
