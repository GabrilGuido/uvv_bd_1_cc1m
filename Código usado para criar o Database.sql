
CREATE TABLE public.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);
COMMENT ON COLUMN public.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN public.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN public.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN public.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN public.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN public.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN public.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN public.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN public.funcionario.numero_departamento IS 'Número do departamento do funcionário.';


CREATE TABLE public.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON COLUMN public.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN public.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN public.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN public.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN public.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


CREATE TABLE public.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);
COMMENT ON COLUMN public.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN public.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN public.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN public.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON public.departamento
 ( nome_departamento );

CREATE TABLE public.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);
COMMENT ON COLUMN public.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN public.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN public.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN public.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON public.projeto
 ( nome_projeto );

CREATE TABLE public.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON COLUMN public.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN public.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN public.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE public.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);
COMMENT ON COLUMN public.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN public.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


ALTER TABLE public.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES public.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES public.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES public.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES public.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES public.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (numero_departamento)
REFERENCES public.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES public.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
