# Desafio de Projeto: Gestão de Oficina Mecânica (Modelo Relacional)

# Contexto do Projeto
Este projeto define o esquema lógico relacional para um sistema de gestão de oficina mecânica. O objetivo é registrar clientes, veículos, ordens de serviço (OS), a alocação de equipes, o uso de peças e o faturamento. O modelo aplica técnicas de mapeamento de Generalização/Especialização e modelagem N:N para garantir a integridade e a complexidade necessária dos dados.

# Estrutura do Esquema Lógico
O modelo foi mapeado para 14 tabelas principais:

1. Generalização e Especialização (PF vs. PJ)

O Cliente (dono do veículo) é modelado com Generalização/Especialização Exclusiva e Total.
Cliente (Super-tipo): Dados genéricos (ID, Tipo).
Cliente_PF e Cliente_PJ (Sub-tipos): Dados específicos (CPF, CNPJ, Razão Social).

2. Estrutura da Ordem de Serviço (OS)

Servico (Ordem de Serviço): Entidade principal que registra o veículo, o status, o valor total, e a equipe responsável.
TabelaServico: Tabela de referência de serviços pré-definidos (ex: Troca de Óleo).
ItensServico: Tabela N:N entre Servico e TabelaServico, detalhando as tarefas específicas realizadas na OS, permitindo que uma OS inclua múltiplos serviços.

3. Alocação de Mão de Obra

Equipe: Define o time responsável por uma OS.
Mecanico: Funcionários, cada um alocado a uma única equipe (relação 1:N simplificada).

# Tabelas e Relacionamentos Chave
| Tabela                       | Função Principal                                                      | Relacionamentos Chave                                      |
|------------------------------|----------------------------------------------------------------------|------------------------------------------------------------|
| Cliente                      | Super-tipo e dados base do cliente.                                  | 1:N com Veiculo                               |
| Veiculo                       | Veículos dos clientes.                                                | 1:N com Servico                                            |
| Servico              | Ordem de Serviço (OS) principal.             | 1:1 com PagamentoServico                           |
| Equipe/Mecanico   | Mão de Obra | 1:N entre Equipe e Mecanico                                |
| Peca / Pecas_Servico | Peças usadas nas OS              | M:N entre Peça e Servico                             |
| Peca / Pecas_Estoque | Gestão de Inventário.      | M:N entre Peca e EstoquePeca                       |

