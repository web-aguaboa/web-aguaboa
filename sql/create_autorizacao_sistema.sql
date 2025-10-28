-- Tabela de autorizações de compra
CREATE TABLE IF NOT EXISTS autorizacoes_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NULL,
    nome_cliente VARCHAR(255) NOT NULL,
    cidade_cliente VARCHAR(255) NULL,
    observacoes TEXT NULL,
    status ENUM('pendente', 'em_producao', 'finalizado') DEFAULT 'pendente',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT
);

-- Tabela de itens da autorização
CREATE TABLE IF NOT EXISTS autorizacao_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autorizacao_id INT NOT NULL,
    produto VARCHAR(255) NOT NULL,
    unidade VARCHAR(50) NULL,
    quantidade INT DEFAULT 0,
    descricao TEXT NULL,
    FOREIGN KEY (autorizacao_id) REFERENCES autorizacoes_compra(id) ON DELETE CASCADE
);

-- Tabela de movimentos de carga
CREATE TABLE IF NOT EXISTS movimentos_carga (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autorizacao_id INT NOT NULL,
    
    -- Descarregamento/Carregamento
    descarregamento_20l INT DEFAULT 0,
    descarregamento_10l INT DEFAULT 0,
    descarregamento_total INT DEFAULT 0,
    carregamento_20l INT DEFAULT 0,
    carregamento_10l INT DEFAULT 0,
    carregamento_total INT DEFAULT 0,
    
    -- Ocorrências - Aguaboa
    aguaboa_20l INT DEFAULT 0,
    aguaboa_10l INT DEFAULT 0,
    aguaboa_total INT DEFAULT 0,
    
    -- Ocorrências - Aguaboa Pet Adesivo
    pet_adesivo_20l INT DEFAULT 0,
    pet_adesivo_10l INT DEFAULT 0,
    pet_adesivo_total INT DEFAULT 0,
    
    -- Ocorrências - Premium com Alça
    premium_alca_20l INT DEFAULT 0,
    premium_alca_10l INT DEFAULT 0,
    premium_alca_total INT DEFAULT 0,
    
    -- Ocorrências - Premium sem Alça
    premium_sem_alca_20l INT DEFAULT 0,
    premium_sem_alca_10l INT DEFAULT 0,
    premium_sem_alca_total INT DEFAULT 0,
    
    -- Campos das ocorrências
    descarregado INT DEFAULT 0,
    compra_novos INT DEFAULT 0,
    recusado_insp INT DEFAULT 0,
    consumo INT DEFAULT 0,
    carregado INT DEFAULT 0,
    
    -- Descartáveis
    descartavel_200ml INT DEFAULT 0,
    descartavel_510ml_nat INT DEFAULT 0,
    descartavel_510ml_gas INT DEFAULT 0,
    descartavel_1500ml INT DEFAULT 0,
    saches_aguaboa INT DEFAULT 0,
    saches_premium INT DEFAULT 0,
    
    -- Observações
    observacoes TEXT NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (autorizacao_id) REFERENCES autorizacoes_compra(id) ON DELETE CASCADE
);

-- Índices para performance
CREATE INDEX idx_autorizacoes_status ON autorizacoes_compra(status);
CREATE INDEX idx_autorizacoes_client ON autorizacoes_compra(client_id);
CREATE INDEX idx_autorizacoes_created_at ON autorizacoes_compra(created_at);
CREATE INDEX idx_movimento_autorizacao ON movimentos_carga(autorizacao_id);
