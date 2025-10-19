-- Criação do esquema
-- DROP DATABASE ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- ----------------------------------------------------------------------
-- 1. TABELAS BASE (Geral/Super-tipo)
-- ----------------------------------------------------------------------

-- Tabela Super-tipo: Cliente (Mapeamento de Generalização/Especialização)
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Endereco VARCHAR(255) NOT NULL,
    TipoCliente ENUM('PF', 'PJ') NOT NULL -- Define se será PF ou PJ
);

-- Tabela Sub-tipo: Pessoa Física
CREATE TABLE Cliente_PF (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    DataNascimento DATE,
    CONSTRAINT fk_cliente_pf FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Sub-tipo: Pessoa Jurídica
CREATE TABLE Cliente_PJ (
    idCliente INT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    NomeFantasia VARCHAR(255),
    CONSTRAINT fk_cliente_pj FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela de Produtos
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Descricao VARCHAR(500),
    Categoria ENUM('Eletrônicos', 'Vestuário', 'Alimentos', 'Brinquedos', 'Livros') NOT NULL
);

-- ----------------------------------------------------------------------
-- 2. TABELAS DE FLUXO DE COMPRA
-- ----------------------------------------------------------------------

-- Tabela de Pedidos
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    DescricaoPedido VARCHAR(255),
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    StatusPedido ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Em processamento',
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela de Pagamento (Refinamento: cliente pode ter mais de uma forma de pagamento cadastrada)
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    TipoPagamento ENUM('Cartão', 'Boleto', 'Pix') NOT NULL,
    Detalhes VARCHAR(100), -- Ex: Últimos 4 dígitos do cartão
    LimiteDisponivel DECIMAL(10, 2) DEFAULT 0.00, -- Aplicável a cartões/crédito
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela de Entrega (Refinamento: 1:1 com Pedido)
CREATE TABLE Entrega (
    idPedido INT PRIMARY KEY, -- Chave Primária e Estrangeira (1:1)
    StatusEntrega ENUM('Pendente', 'Em Transporte', 'Entregue', 'Cancelada') NOT NULL,
    CodigoRastreio VARCHAR(50) UNIQUE NOT NULL,
    ValorFrete DECIMAL(10, 2) DEFAULT 0.00,
    DataPrevista DATE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela N:N: Produtos do Pedido (Adicionando Quantidade e Valor Unitário no momento da compra)
CREATE TABLE Produtos_Pedido (
    idPedido INT NOT NULL,
    idProduto INT NOT NULL,
    Quantidade INT DEFAULT 1,
    ValorUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idPedido, idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- ----------------------------------------------------------------------
-- 3. TABELAS DE ESTOQUE E FORNECIMENTO
-- ----------------------------------------------------------------------

-- Tabela de Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(255) NOT NULL
);

-- Tabela N:N: Produtos e Estoque (Quantos produtos há em cada local)
CREATE TABLE Produtos_Estoque (
    idProduto INT NOT NULL,
    idEstoque INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idEstoque),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela de Fornecedores
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE
);

-- Tabela N:N: Produtos e Fornecedores
CREATE TABLE Produtos_Fornecedor (
    idProduto INT NOT NULL,
    idFornecedor INT NOT NULL,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- Tabela de Vendedores Terceiros (Marketplace)
CREATE TABLE VendedorTerceiro (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    NomeFantasia VARCHAR(255),
    CNPJ CHAR(14) NOT NULL UNIQUE
);

-- Tabela N:N: Produtos e Vendedores Terceiros
CREATE TABLE Produtos_Vendedor (
    idProduto INT NOT NULL,
    idVendedor INT NOT NULL,
    PRIMARY KEY (idProduto, idVendedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idVendedor) REFERENCES VendedorTerceiro(idVendedor)
);
