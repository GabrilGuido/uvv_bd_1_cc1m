CREATE ROLE gabrielguido SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN PASSWORD '1337'

CREATE SCHEMA elmasri;

CREATE DATABASE uvv
with
OWNER = gabrielguido
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
                cpf_supervisor CHAR(11) /*CPF do supervisor. É uma FK para a própria tabela.*/,
                numero_departamento INTEGER NOT NULL /*Número do departamento do funcionário.*/,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)/*Adicionando as chaves primárias da tabela*/
);

-- Adcionando constraint check no atributo sexo
alter table elmasri.funcionario
 add constraint check (sexo in ('M', 'F'));

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

-- Adcionando constraint check no atributo sexo
alter table elmasri.dependente
 add constraint check (sexo in ('M', 'F'));

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
                horas NUMERIC(3,1) /*Horas trabalhadas pelo funcionário neste projeto.*/ ,
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto) /*Adicionando a chave primária da tabela*/
);


--Criando a tabela da localização do departamento onde o funcionário trabalha
CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL /*Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.*/,
                local VARCHAR(15) NOT NULL /*Localização do departamento. Faz parte da PK desta tabela.*/,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local) /*Adicionando a chave primária da tabela*/
);

--Adicionando chave estrangeira na tabela departamento
ALTER TABLE elmasri.departamento ADD 
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela dependente
ALTER TABLE elmasri.dependente ADD 
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela trbalha_em
ALTER TABLE elmasri.trabalha_em ADD 
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela funcionário
ALTER TABLE elmasri.funcionario ADD 
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela localizações_departamento
ALTER TABLE elmasri.localizacoes_departamento ADD  departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela projeto
ALTER TABLE elmasri.projeto ADD 
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
NOT DEFERRABLE;

--Adicionando chave estrangeira na tabela trbalha_em
ALTER TABLE elmasri.trabalha_em ADD 
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
NOT DEFERRABLE;

-- Adicionando chave primária na tabela departamento
ALTER TABLE departamento 
ADD FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
;

-- Adicionando chave primária na tabela depedente
ALTER TABLE dependente 
ADD FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
;

-- Adicionando chave primária na tabela trabalha_em
ALTER TABLE trabalha_em 
ADD FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
;

-- Adicionando chave primária na tabela funcionário
ALTER TABLE funcionario 
ADD FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
;


-- Adicionando chave primária na tabela localizações_departamento
ALTER TABLE localizacoes_departamento 
ADD FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
;

-- Adicionando chave primária na tabela projeto
ALTER TABLE projeto 
ADD FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
;

-- Adicionando chave primária na tabela trabalha_em
ALTER TABLE trabalha_em 
ADD FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
;

-- Inserindo dados na tabela funcionário
INSERT INTO funcionario VALUES 
   (
   "33344555587", "Fernando", "T", "Wong", '1955-12-08', "Rua da Lapa, 34, São Paulo, SP", "M", 40.000, 33344555587, 5 
),
   (
     "88866555576" , "Jorge", "E", "Brito", '1937-11-10', "Rua do Horto, 35, São Paulo, SP ", "M", 55.000, NULL, 1 
),
   (
   "12345678966", "João", "B", "Silva", '1965.11.09', "Rua das Flores, 751, São Paulo, SP", "M", 30.000, 33344555587, 5 
), 
   (
     "98765432168" , "Jennifer", "S", "Souza", '1941-06-20', "Av.Arthur de Lima, 54, Santo André, SP", "F", 43.000, 88866555576, 4
), 
   (
     "99988777767" , "Alice", "J", "Zelaya", '1968-01-19', "Rua Souza Lima, 35 ,Curitiba< PR", "F", 25.000, 98765432168, 4
),   
   (
     "66688444476" , "Ronaldo", "K", "Lima", '1962-09-15', "Rua Rebouças, 65, Piracicaba< SP", "M", 38.000, 33344555587, 5 
),
   (
     "45345345376" , "Joice", "A", "Leite", '1972-07-31', "Av.Lucas Obes, 74, São Paulo< SP", "F", 25.000, 33344555587, 5 
),
   (
     "98798798733" , "André", "V", "Pereira", '1969-03-29', "Rua Timbira, 35, São Paulo, SP", "M", 25.000, 98765432168, 4 
);


-- Inserindo dados na tabela departamento
INSERT INTO departamento VALUES (
      5, "Pesquisa", "33344555587", '1988-05-22'
),
   (
       4, "Administração", "98765432168", '1995-01-01'
),
   (
       1, "Matriz", "88866555576", '1981-06-19'
);

-- Inserindo dados na tabela localizações_departamento
INSERT INTO localizacoes_departamento VALUES (
       1, "São Paulo"
),
   (
       4, "Mauá"
),
   (
       5, "Santo André"
),
   (
       5, "Itu"
),
   (
       5, "São Paulo"
);

-- Inserindo dados na tabela projeto
INSERT INTO projeto VALUES (
       1, "ProdutoX", "Santo André", 5 
),
   (
       2, "ProdutoY", "Itu", 5 
),
   (
       3, "ProdutoZ", "São Paulo", 5
),
   (
       10, "Informatização", "Mauá", 4
),
   (
       20, "Reotganização", "São Paulo", 1
),
   (
       30, "Novosbenefícios", "Mauá", 4
);

-- Inserindo dados na tabela dependente
INSERT INTO dependente VALUES (
       "33344555587", "Alicia", "F", '1986-04-05', "Filha"
),
   (
       "33344555587", "Tiago", "M", '1983-10-25', "Filho"
),
   (
       "33344555587", "Janaína", "F", '1958-05-03', "Esposa"
),
   (
       "98765432168", "Antonio", "M", '1942-02-18', "Marido"
),
   (
       "12345678966", "Michael", "M", '1988-01-04', "Filho"
),
   (
       "12345678966", "Alicia", "F", '1988-12-30', "Filha"
),
   (
       "12345678966", "Elizabeth", "F", '1967-05-05', "Esposa"
);


-- Inserindo dados na tabela trbalha_em
INSERT INTO trabalha_em VALUES (
       "12345678966", 1, 32.5
),
   (
       "12345678966", 2, 7.5
),
   (
       "66688444476", 3, 40.0
),
   (
       "45345345376", 1, 20.0
),
   (
       "45345345376", 2, 20.0
),
   (
       "33344555587", 2, 10.0
),
   (
       "33344555587", 3, 10.0
),
   (
       "33344555587", 10, 10.0
),
   (
       "33344555587", 20, 10.0
),
   (
       "99988777767", 30, 30.0
),
   (
       "99988777767", 10, 10.0
),
   (
       "98798798733", 10, 35.0
),
   (
       "98798798733", 30, 5.0
),
   (
       "98765432168", 30, 20.0
),
   (
       "98765432168", 20, 15.0
),
   (
       "88866555576", 20, NULL
);