# 📈 Dashboard de Vendas - Xbox Game Pass Subscriptions Sales

## 🎯 Objetivo do Projeto

O objetivo deste desafio é criar um dashboard de vendas interativo e visualmente atraente no Microsoft Excel. O foco está em transformar dados brutos de assinaturas em informações visuais claras e úteis (KPIs e gráficos), permitindo uma análise eficaz do desempenho de vendas e a tomada de decisões baseadas em dados para o negócio Xbox Game Pass.

## 📁 Dados Utilizados

O dashboard foi construído a partir de dados simulados de vendas de assinaturas do Xbox Game Pass, fornecidos em um arquivo Excel que contém as seguintes abas (exportadas como CSVs):

| Arquivo (Aba Original) | Conteúdo Principal | Uso no Dashboard |
| :--- | :--- | :--- |
| `dashboard.xlsx - Bases.csv` | Tabela de dados brutos (ID do Assinante, Plano, Data de Início, Renovação Automática, Valores, Add-ons). | Fonte primária para criação de Tabelas Dinâmicas e Cálculos. |
| `dashboard.xlsx - Cálculos.csv` | Análises e sumarizações de dados (Faturamento Total, Vendas EA Play, Vendas Minecraft, etc.). | Base para os Key Performance Indicators (KPIs). |
| `dashboard.xlsx - Assets.csv` | Paleta de cores e ativos visuais (ícones, logos) utilizados no design. | Referência para a aplicação do tema visual. |
| `dashboard.xlsx - Dashboard.csv` | Aba final onde o layout e os elementos visuais são consolidados. | Tela final do dashboard. |

## 📊 Principais Indicadores (KPIs) e Análises Visuais

O dashboard deve focar na visualização dos seguintes indicadores e análises para a tomada de decisão:

### Key Performance Indicators (KPIs)
* **Faturamento Total de Vendas:** Soma de `Total Value`.
* **Receita Gerada pelo EA Play:** Soma de `EA Play Season Pass Price`.
* **Receita Gerada pelo Minecraft Season Pass:** Soma de `Minecraft Season Pass Price`.

### Análises Visuais (Gráficos)
1.  **Distribuição de Receita por Plano:** Gráfico de barras ou colunas, mostrando a soma de `Total Value` por `Plan` (Ultimate, Standard, Core).
2.  **Taxa de Renovação Automática:** Gráfico de Rosca/Pizza, visualizando a proporção de assinaturas com `Auto Renewal` (`Yes` vs. `No`).
3.  **Evolução da Receita (Tendência):** Gráfico de Linhas, mostrando o `Total Value` ao longo do tempo (eixo `Start Date`).
4.  **Desempenho por Tipo de Assinatura:** Tabela ou gráfico de barras, comparando a receita por `Subscription Type` (Monthly, Quarterly, Annual).

## 🎨 Layout e Design

Para um visual profissional, recomenda-se a aplicação de um tema consistente, utilizando a paleta de cores definida na aba `Assets` (ou a paleta de cores moderna sugerida no *último passo do desafio*):

* **Estrutura:** Layout de uma única página (tela), com os KPIs na parte superior, seguidos pelos gráficos e, opcionalmente, um filtro lateral (Slicers).
* **Cores:** Utilizar cores de contraste para dados em destaque e um fundo neutro para legibilidade.
* **Interatividade:** Inclusão de **Segmentação de Dados (Slicers)** baseados em `Plan` e/ou `Subscription Type` para filtrar as análises dinamicamente.

## 🛠️ Instruções para Reprodução (Passo a Passo)

Para visualizar e reproduzir o dashboard no Excel, siga os passos abaixo:

### Pré-requisitos
* Microsoft Excel (versão 2013 ou superior).
* O arquivo `dashboard.xlsx` (ou os quatro arquivos CSV importados para abas separadas em um novo arquivo Excel).

### 1. Preparação da Base de Dados
1.  Abra o arquivo Excel contendo as abas com os dados (`Bases`, `Cálculos`, etc.).
2.  Garanta que a aba `Bases` esteja formatada como uma **Tabela** (Ctrl + T) para facilitar a criação das Tabelas Dinâmicas.

### 2. Criação das Tabelas Dinâmicas
1.  Para cada KPI e Análise Visual, crie uma **Tabela Dinâmica** separada a partir da aba `Bases`.
    * *Exemplo para Faturamento Total:* Arraste o campo `Total Value` para Valores (somar).
    * *Exemplo para Receita por Plano:* Arraste `Plan` para Linhas e `Total Value` para Valores (somar).

### 3. Criação dos Gráficos
1.  Para cada Tabela Dinâmica criada, insira o **Gráfico Dinâmico** correspondente (Barra, Rosca, Linha, etc.).
2.  Remova elementos desnecessários do gráfico (botões de campo, linhas de grade desnecessárias, etc.).

### 4. Montagem do Dashboard
1.  Crie uma nova aba chamada `DASHBOARD`.
2.  Defina o título (`XBOX GAME PASS SUBSCRIPTIONS SALES`) e configure o fundo e as cores de acordo com o design escolhido.
3.  Copie e cole os Gráficos Dinâmicos para a aba `DASHBOARD`.
4.  Crie os cartões de **KPIs**: Use caixas de texto ou células vinculadas às células de resultado das Tabelas Dinâmicas de soma total na aba `Cálculos` ou em uma Tabela Dinâmica de KPI dedicada.

### 5. Adição de Interatividade (Slicers)
1.  Na aba `DASHBOARD`, insira um **Segmentação de Dados (Slicer)**.
2.  Conecte este Slicer a **todas** as Tabelas Dinâmicas que alimentam seus gráficos e KPIs para que a filtragem funcione em todo o dashboard.

---

## 🚀 Resultado Final

O arquivo final a ser entregue é o `dashboard.xlsx` contendo a base de dados, os cálculos e a aba `DASHBOARD` finalizada, juntamente com este `README.md`.