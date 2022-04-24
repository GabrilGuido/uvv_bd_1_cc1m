create user gabrielguido identified by '1337';

grant  all privileges on uvv.*  to gabrielguido;

CREATE DATABASE uvv;

USE uvv;

-- Criando tabela funcionário
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL /*CPF do funcionário. Será a PK da tabela.*/,
                primeiro_nome VARCHAR(15) NOT NULL /*Primeiro nome do funcionário.*/,
                nome_meio CHAR(1) /*Inicial do nome do meio.*/,
                ultimo_nome VARCHAR(15) NOT NULL /*Sobrenome do funcionário.*/,
                data_nascimento DATE /*Data de nascimento do funcionário*/,
                endereco VARCHAR(150) /*Endereço do funcionário.*/,
                sexo CHAR(1) /*Sexo do funcionário.*/,
                salario DECIMAL(10,2) /*Salário do funcionário.*/,
                cpf_supervisor CHAR(11) NOT NULL /*CPF do supervisor. Será uma FK para a própria tabela.*/,
                numero_departamento INT NOT NULL /*Número do departamento do funcionário.*/,
                PRIMARY KEY (cpf) /*Adicionando chave prímaria para a tabela*/
);

-- Adicionando comentários nas colunas da tabela
ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(150) COMMENT 'Endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor. Será uma FK para a própria tabela.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário.';


-- Adcionando constraint check no atributo sexo
alter table funcionario
 add constraint check (sexo in ('M', 'F'));


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

-- Adicionando comentários nas colunas da tabela
ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';


-- Adcionando constraint check no atributo sexo
alter table dependente
 add constraint check (sexo in ('M', 'F'));


-- Criando tabela departamento
CREATE TABLE departamento (
                numero_departamento INT NOT NULL /*Número do departamento. É a PK desta tabela.*/,
                nome_departamento VARCHAR(15) NOT NULL /*Nome do departamento. Deve ser único.*/,
                cpf_gerente CHAR(11) NOT NULL /*CPF do gerente do departamento. FK para a tabela funcionários.*/,
                data_inicio_gerente DATE /*Data do início do gerente no departamento.*/,
                PRIMARY KEY (numero_departamento) /*Adicionando chave prímaria para a tabela*/
);

-- Adicionando comentários nas colunas da tabela
ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento. FK para a tabela funcionários.';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';


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

-- Adicionando comentários nas colunas da tabela
ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';

ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK para a tabela departamento.';


-- Criando chave alternativa
CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

-- Criando tabela trbalha_em
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL /*CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.*/,
                numero_projeto INT NOT NULL /*Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.*/,
                horas DECIMAL(3,1) /*Horas trabalhadas pelo funcionário neste projeto.*/,
                PRIMARY KEY (cpf_funcionario, numero_projeto) /*Adicionando chaves prímarias para a tabela*/
);

-- Adicionando comentários nas colunas da tabela
ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';


-- Criando tabela localizacoes_departamento
CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL /*Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.*/,
                local VARCHAR(15) NOT NULL /*Localização do departamento. Faz parte da PK desta tabela.*/,
                PRIMARY KEY (numero_departamento, local) /*Adicionando chaves prímarias para a tabela*/
);

-- Adicionando comentários nas colunas da tabela
ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';


-- Adicionando chave estrangeira na tabela departamento
ALTER TABLE departamento 
ADD FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
;

-- Adicionando chave estrangeira na tabela depedente
ALTER TABLE dependente 
ADD FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
;

-- Adicionando chave estrangeira na tabela trabalha_em
ALTER TABLE trabalha_em 
ADD FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
;

-- Adicionando chave estrangeira na tabela funcionário
ALTER TABLE funcionario 
ADD FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
;


-- Adicionando chave estrangeira na tabela localizações_departamento
ALTER TABLE localizacoes_departamento 
ADD FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
;

-- Adicionando chave estrangeira na tabela projeto
ALTER TABLE projeto 
ADD FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
;

-- Adicionando chave estrangeira na tabela trabalha_em
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
     "88866555576" , "Jorge", "E", "Brito", '1937-11-10', "Rua do Horto, 35, São Paulo, SP ", "M", 55.000, 88866555576, 1 
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
     "66688444476" , "Ronaldo", "K", "Lima", '1962-09-15', "Rua Rebouças, 65, Piracicaba, SP", "M", 38.000, 33344555587, 5 
),
   (
     "45345345376" , "Joice", "A", "Leite", '1972-07-31', "Av.Lucas Obes, 74, São Paulo, SP", "F", 25.000, 33344555587, 5 
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















