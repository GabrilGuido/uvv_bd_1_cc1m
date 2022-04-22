create user GabrielGuido with SUPERUSER;

CREATE DATABASE uvv
with
OWNER = GabrielGuido
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true
;



--Criando tabela funcionários
CREATE TABLE elmasri.funcionario (
                --Tabela que armazena as informações dos funcionários.
                cpf CHAR(11) NOT NULL /*CPF do funcionário. Será a PK da tabela.*/,
                primeiro_nome VARCHAR(15) NOT NULL /*Primeiro nome do funcionário.*/,
                nome_meio CHAR(1) /*Inicial do nome do meio.*/,
                ultimo_nome VARCHAR(15) NOT NULL /*Sobrenome do funcionário.*/,
                data_nascimento DATE /*Nascimento do fucionário*/,
                endereco VARCHAR(30) /*Endereço do funcionário.*/,
                sexo CHAR(1) /*Sexo do funcionário.*/,
                salario NUMERIC(10,2) /*Salário do funcionário.*/,
                cpf_supervisor CHAR(11) NOT NULL /*CPF do supervisor. É uma FK para a própria tabela.*/,
                numero_departamento INTEGER NOT NULL /*Número do departamento do funcionário.*/,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)/*Adicionando as chaves primárias da tabela*/
);


CREATE INDEX funcionario_idx
 ON elmasri.funcionario
 ( cpf_supervisor );

CLUSTER funcionario_idx ON funcionario;

--Criando tabela do dependente do funcionário
CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL /*CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.*/,
                nome_dependente VARCHAR(15) NOT NULL/*Nome do dependente. Faz parte da PK desta tabela.*/,
                sexo CHAR(1) /*Sexo do dependente.*/,
                data_nascimento DATE /*Data de nascimento do dependente.*/,
                parentesco VARCHAR(15) /*Descrição do parentesco do dependente com o funcionário.*/,
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)/*Adicionando as chaves primárias da tabela*/
);

--Criando tabela do departamento
CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL /*Número do departamento. É a PK desta tabela.*/,
                nome_departamento VARCHAR(15) NOT NULL /*Nome do departamento. Deve ser único.*/,
                cpf_gerente CHAR(11) NOT NULL /*CPF do gerente do departamento. FK para a tabela funcionários.*/,
                data_inicio_gerente DATE /*Data do início do gerente no departamento.*/,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)/*Adicionando as chaves primárias da tabela*/
);

--Criando uma chave alternativa
CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento )

--Criando tabela do proejeto
CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL /*Número do projeto. É a PK desta tabela.*/,
                nome_projeto VARCHAR(15) NOT NULL /*Nome do projeto. Deve ser único.*/,
                local_projeto VARCHAR(15) /*Localização do projeto.*/,
                numero_departamento INTEGER NOT NULL /*Número do departamento. É uma FK para a tabela departamento.*/,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto) /*Adicionando a chave primária da tabela*/
);

--Criando uma chave alternativa
CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

--Criando tabela onde o funcioário trabalha
CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL /*CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.*/,
                numero_projeto INTEGER NOT NULL /*Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.*/,
                horas NUMERIC(3,1) NOT NULL /*Horas trabalhadas pelo funcionário neste projeto.*/ ,
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto) /*Adicionando a chave primária da tabela*/
);


--Criando a tabela da localização do departamento onde o funcionário trabalha
CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL /*Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.*/,
                local VARCHAR(15) NOT NULL /*Localização do departamento. Faz parte da PK desta tabela.*/,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local) /*Adicionando a chave primária da tabela*/
);

--Adicionando chave estrangeira na tabela departamento
ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela dependente
ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela trbalha_em
ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela funcionário
ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela localizações_departamento
ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela projeto
ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela trbalha_em
ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;