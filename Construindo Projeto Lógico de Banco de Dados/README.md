Desafio de Projeto: Modelagem Lógica e Queries SQL para E-commerce

Contexto do Projeto

Este projeto consiste na implementação do esquema de banco de dados para um sistema de e-commerce, baseado em um modelo lógico relacional derivado de um Modelo Entidade-Relacionamento Estendido (EER). O objetivo é demonstrar a correta aplicação de mapeamento de modelos, definição de chaves, constraints e a formulação de consultas complexas em SQL.

Estrutura do Esquema Lógico

O modelo lógico foi mapeado para 14 tabelas, aplicando os seguintes refinamentos e regras de mapeamento:

1. Generalização e Especialização (PF vs. PJ)

O Cliente é modelado usando o padrão de Generalização/Especialização Exclusiva e Total.

Cliente (Super-tipo): Contém dados genéricos (ID, E-mail, Tipo - PF ou PJ).

Cliente_PF e Cliente_PJ (Sub-tipos): Contêm dados específicos (CPF, CNPJ, Razão Social). A chave primária dos sub-tipos é também uma chave estrangeira, garantindo a exclusividade 1:1 com o super-tipo.

2. Pagamento

Para permitir que um cliente tenha múltiplas formas de pagamento cadastradas, a tabela Pagamento foi criada com uma relação N:1 com Cliente.

3. Entrega

A funcionalidade de entrega foi implementada na tabela Entrega, estabelecendo uma relação 1:1 com Pedido (utilizando a PK de Pedido como PK e FK em Entrega), garantindo o rastreio e o status do pedido.

Tabelas e Relacionamentos Chave
| Tabela                       | Função Principal                                                      | Relacionamentos Chave                                      |
|------------------------------|----------------------------------------------------------------------|------------------------------------------------------------|
| Cliente                      | Super-tipo e dados base do cliente.                                  | 1:N com Pedido e Pagamento                                 |
| Pedido                       | Registro dos pedidos.                                                | 1:1 com Entrega                                            |
| Produtos_Pedido              | M:N entre Produto e Pedido, armazena quantidade e valor.             | PK Composta: idPedido, idProduto                           |
| Estoque / Produtos_Estoque   | Gerencia a localização e quantidade de produtos em diferentes estoques.| M:N entre Produto e Estoque                                |
| Fornecedor / Produtos_Fornecedor | Mapeia quais fornecedores fornecem quais produtos.              | M:N entre Produto e Fornecedor                             |
| VendedorTerceiro / Produtos_Vendedor | Mapeia produtos vendidos por terceiros (Marketplace).      | M:N entre Produto e VendedorTerceiro                       |


