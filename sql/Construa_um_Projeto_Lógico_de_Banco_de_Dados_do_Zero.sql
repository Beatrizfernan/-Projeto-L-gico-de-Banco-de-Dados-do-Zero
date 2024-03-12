-- Criação das tabelas do esquema lógico

CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    TipoCliente VARCHAR(10) -- PF ou PJ
);

CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY,
    ClienteID INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    AnoFabricacao INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE OrdemServico (
    OrdemID INT PRIMARY KEY,
    ClienteID INT,
    DataEmissao DATE,
    Status VARCHAR(20),
    PrazoConclusao DATE,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE Servico (
    ServicoID INT PRIMARY KEY,
    Descricao VARCHAR(100),
    Valor DECIMAL(10, 2)
);

CREATE TABLE Pagamento (
    PagamentoID INT PRIMARY KEY,
    OrdemID INT,
    ValorPago DECIMAL(10, 2),
    DataPagamento DATE,
    FOREIGN KEY (OrdemID) REFERENCES OrdemServico(OrdemID)
);

CREATE TABLE Entrega (
    EntregaID INT PRIMARY KEY,
    OrdemID INT,
    StatusEntrega VARCHAR(20),
    CodigoRastreio VARCHAR(20),
    FOREIGN KEY (OrdemID) REFERENCES OrdemServico(OrdemID)
);

-- Exemplo de consultas SQL

-- Recuperação simples de clientes
SELECT * FROM Cliente;

-- Filtro de veículos por marca
SELECT * FROM Veiculo WHERE Marca = 'Toyota';

-- Expressão para calcular idade dos veículos
SELECT Marca, AnoFabricacao, YEAR(CURRENT_DATE()) - AnoFabricacao AS IdadeVeiculo FROM Veiculo;

-- Ordenação dos serviços por valor
SELECT * FROM Servico ORDER BY Valor DESC;

-- Condição de filtro para clientes com mais de 2 veículos
SELECT ClienteID, COUNT(*) AS NumVeiculos FROM Veiculo GROUP BY ClienteID HAVING COUNT(*) > 2;

-- Junção entre tabelas para listar clientes com suas ordens de serviço
SELECT c.Nome, o.OrdemID, o.Status FROM Cliente c JOIN OrdemServico o ON c.ClienteID = o.ClienteID;
