# ☁️ Desafio: Integração Power BI, Azure MySQL e Modelagem ETL 
# STATUS: Em desenvolvimento

## 🎯 Descrição do Desafio de Projeto

Este projeto consiste em configurar uma infraestrutura de banco de dados na nuvem (Azure Database for MySQL) e integrá-la ao Power BI. O foco principal é extrair os dados, realizar transformações complexas seguindo diretrizes específicas no Power Query (ETL) e criar um modelo de dados limpo pronto para análise.

### 1. Stack Tecnológica
* **Banco de Dados:** Azure Database for MySQL
* **Ferramenta SQL:** MySQL Workbench e Azure Cloud Shell
* **Ferramenta ETL/BI:** Microsoft Power BI (Power Query)
* **Infraestrutura:** Microsoft Azure

### 2. Entregáveis e Estrutura de Dados
O projeto resultou em um conjunto de tabelas transformadas e prontas para a criação de um modelo estrela (Star Schema), além da documentação do processo de ETL.

---

## 🛠️ Etapas de Configuração e Conexão

### 1. Criação da Instância MySQL no Azure
* **Recurso:** Azure Database for MySQL Flexible Server.
* **Credenciais:** [Listar as credenciais, se necessário, ou apenas referenciar as variáveis de ambiente.]
* **Segurança (Firewall):** Foi configurada uma regra de firewall para permitir o acesso do meu IP local e serviços do Azure, garantindo a conectividade via Workbench e Power BI.

### 2. Criação do Banco de Dados
* **Nome do DB:** `company_database` (Exemplo)
* **Script SQL:** O script `creation_script.sql` foi executado (via Cloud Shell ou Workbench) para criar o esquema e popular as tabelas (`Employee`, `Department`, `Project`, etc.).
    * *Caminho do Script:* `Script_SQL/creation_script.sql`

---

## ⚙️ Diretrizes de Transformação de Dados (Processo ETL no Power Query)

As seguintes transformações foram aplicadas às consultas (tabelas) no Power Query para garantir a qualidade e a estrutura dos dados:

### Tabela `Employee` (Foco em Dimensão/Fato)

| Diretriz | Detalhe da Transformação |
| :--- | :--- |
| **Limpeza Inicial** | Verificação de tipos, remoção de nulos críticos e padronização de cabeçalhos. `Salary` e valores monetários alterados para tipo **Número Decimal Fixo**. |
| **Mescla 1 (Departamento)** | Junção **Externa Esquerda** com a tabela `Department` para trazer a coluna `Dname` (Nome do Departamento) para a tabela `Employee`, usando `Dno` como chave. Colunas `Dno` e `Dlocation` originais foram eliminadas. |
| **Mescla 2 (Self-Join)** | Mescla **Externa Esquerda** com a própria tabela `Employee` (cópia renomeada para `Manager`) para trazer o nome completo do gerente, usando `Super_ssn` (Supervisor) e `Ssn` (Gerente) como chaves de junção. |
| **Nome Completo** | Mescla das colunas `Fname` e `Lname` para criar a coluna `Full_Name` do colaborador. |
| **Agrupamento** | Agrupamento de dados para gerar a tabela de **Hierarquia de Gerência**, contando o número de colaboradores subordinados por gerente. |

