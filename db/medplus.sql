CREATE DATABASE medplus;
USE medplus;

-- Tabela de Usuários (para login e perfil)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'recepcionista', 'medico', 'enfermeiro') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Convênios
CREATE TABLE convenios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

-- Tabela de Pacientes
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15),
    endereco TEXT,
    convenio_id INT,
    FOREIGN KEY (convenio_id) REFERENCES convenios(id)
);

-- Tabela de Especialidades
CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Profissionais (médicos e enfermeiros)
CREATE TABLE profissionais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('medico', 'enfermeiro') NOT NULL,
    especialidade_id INT,
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id)
);

-- Tabela de Serviços
CREATE TABLE servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

-- Tabela de Agenda Padrão
CREATE TABLE agenda_padrao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profissional_id INT,
    especialidade_id INT,
    servico_id INT,
    dia_semana ENUM('segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'),
    horario_inicio TIME,
    horario_fim TIME,
    centro_custo VARCHAR(100),
    permite_reserva BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (profissional_id) REFERENCES profissionais(id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id),
    FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

-- Tabela de Agendamentos
CREATE TABLE agendamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT,
    profissional_id INT,
    especialidade_id INT,
    servico_id INT,
    convenio_id INT,
    data DATE,
    horario TIME,
    centro_custo VARCHAR(100),
    status ENUM('agendado', 'concluido', 'cancelado') DEFAULT 'agendado',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (profissional_id) REFERENCES profissionais(id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id),
    FOREIGN KEY (servico_id) REFERENCES servicos(id),
    FOREIGN KEY (convenio_id) REFERENCES convenios(id)
);

-- Tabela de Atendimentos
CREATE TABLE atendimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    agendamento_id INT,
    paciente_id INT,
    numero_prontuario VARCHAR(50),
    data_atendimento DATETIME,
    observacoes TEXT,
    FOREIGN KEY (agendamento_id) REFERENCES agendamentos(id),
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
);
