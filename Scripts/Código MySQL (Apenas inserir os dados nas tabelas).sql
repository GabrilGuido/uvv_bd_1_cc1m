CREATE DATABASE uvv;

USE uvv;

-- Criandot tabela funcionário
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL /*CPF do funcionário. Será a PK da tabela.*/,
                primeiro_nome VARCHAR(15) NOT NULL /*Primeiro nome do funcionário.*/,
                nome_meio CHAR(1) /*Inicial do nome do meio.*/,
                ultimo_nome VARCHAR(15) NOT NULL /*Sobrenome do funcionário.*/,
                data_nascimento DATE /*Data de nascimento do funcionário*/,
                endereco VARCHAR(30) /*Endereço do funcionário.*/,
                sexo CHAR(1) /*Sexo do funcionário.*/,
                salario DECIMAL(10,2) /*Salário do funcionário.*/,
                cpf_supervisor CHAR(11) NOT NULL /*CPF do supervisor. Será uma FK para a própria tabela.*/,
                numero_departamento INT NOT NULL /*Número do departamento do funcionário.*/,
                PRIMARY KEY (cpf) /*Adicionando chave prímaria para a tabela*/
);


CREATE INDEX funcionario_idx
 ON funcionario
 ( cpf_supervisor );

-- Criando tabela dependente
CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL /*CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.*/,
                nome_dependente VARCHAR(15) NOT NULL /*Nome do dependente. Faz parte da PK desta tabela.*/,
                sexo CHAR(1) /*Sexo do dependente.*/,
                data_nascimento DATE /*Data de nascimento do dependente.*/, 
                parentesco VARCHAR(15) /*Descrição do parentesco do dependente com o funcionário.*/,
                PRIMARY KEY (cpf_funcionario, nome_dependente) /*Adicionando chave prímaria para a tabela*/
);


-- Criando tabela departamento
CREATE TABLE departamento (
                numero_departamento INT NOT NULL /*Número do departamento. É a PK desta tabela.*/,
                nome_departamento VARCHAR(15) NOT NULL /*Nome do departamento. Deve ser único.*/,
                cpf_gerente CHAR(11) NOT NULL /*CPF do gerente do departamento. FK para a tabela funcionários.*/,
                data_inicio_gerente DATE /*Data do início do gerente no departamento.*/,
                PRIMARY KEY (numero_departamento) /*Adicionando chave prímaria para a tabela*/
);


-- Criando chave alternativa
CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

-- Criando tabela projeto
CREATE TABLE projeto (
                numero_projeto INT NOT NULL /*Número do projeto. É a PK desta tabela.*/,
                nome_projeto VARCHAR(15) NOT NULL /*Nome do projeto. Deve ser único.*/,
                local_projeto VARCHAR(15) /*Localização do projeto.*/,
                numero_departamento INT NOT NULL /*Número do departamento. É uma FK para a tabela departamento.*/,
                PRIMARY KEY (numero_projeto) /*Adicionando chave prímaria para a tabela*/
);


-- Criando chave alternativa
CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

-- Criando tabela trbalha_em
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL /*CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.*/,
                numero_projeto INT NOT NULL /*Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.*/,
                horas DECIMAL(3,1) NOT NULL /*Horas trabalhadas pelo funcionário neste projeto.*/,
                PRIMARY KEY (cpf_funcionario, numero_projeto) /*Adicionando chaves prímarias para a tabela*/
);


-- Criando tabela localizacoes_departamento
CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL /*Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.*/,
                local VARCHAR(15) NOT NULL /*Localização do departamento. Faz parte da PK desta tabela.*/,
                PRIMARY KEY (numero_departamento, local) /*Adicionando chaves prímarias para a tabela*/
);


-- Adicionando chave primária na tabela departamento
ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela depedente
ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela trabalha_em
ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela funcionário
ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela localizações_departamento
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela projeto
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Adicionando chave primária na tabela trabalha_em
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;