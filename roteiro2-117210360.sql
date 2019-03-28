-- Eduardo Henrique Pontes Silva
-- 117210360

-- Questão 1

CREATE TABLE tarefas(
    id BIGINT,
    descricao TEXT,
    func_resp_cpf CHAR(11),
    prioridade SMALLINT,
    status CHAR(1)
);

INSERT INTO tarefas VALUES
(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F'),
(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F'),
eduardo_db-> (null, null, null, null, null);

INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
-- Retorno de tela: 'ERROR:  value too long for type character(11)'

INSERT INTO tarefas VALUES (2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');
-- Retorno de tela: 'ERROR:  value too long for type character(1)'

--Questão 2

INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');
-- não retornou erro

-- Questão 3

-- Comandos 3

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
-- retorno de tela: ERROR:  smallint out of range

INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');
-- retorno de tela: ERROR:  smallint out of range

-- Comandos 4

INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o  andar', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o  andar', '32323232911', 32766, 'A');

-- Questão 4

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
--retorno de tela: ERROR:  column "id" contains null values
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
--retorno de tela: ERROR:  column "descricao" contains null values
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
--retorno de tela: ERROR:  column "func_resp_cpf" contains null values
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
--retorno de tela: ERROR:  column "prioridade" contains null values
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;
--retorno de tela: ERROR:  column "status" contains null values

DELETE FROM tarefas WHERE id IS NULL;

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Questão 5

ALTER TABLE tarefas ADD CONSTRAINT tarefas_pkey PRIMARY KEY(id);

-- Comandos 5

INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');

INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');
--retorno de tela: ERROR:  duplicate key value violates unique constraint "tarefas_pkey"
--                 DETAIL:  Key (id)=(2147483653) already exists.

-- Questão 6

--A)

ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_func_cpf_valido CHECK(LENGTH(func_resp_cpf) = 11);

INSERT INTO tarefas VALUES (2147483658, 'limpar portas do 1o andar', '32323232', 2, 'A');
-- retorno de tela: ERROR:  new row for relation "tarefas" violates check constraint "tarefas_chk_func_cpf_valido"
--                  DETAIL:  Failing row contains (2147483654, limpar portas do 1o andar, 32323232   , 2, A).

INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '323232329119', 2, 'A');
-- Retorno de tela: 'ERROR:  value too long for type character(11)'

--B)

ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_Status_possiveis CHECK (status = 'P' OR status = 'E' OR status = 'C');
--retorno de tela: ERROR:  check constraint "tarefas_chk_status_possiveis" is violated by some row

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_Status_possiveis CHECK (status = 'P' OR status = 'E' OR status = 'C');

INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');
-- ERROR:  new row for relation "tarefas" violates check constraint "tarefas_chk_status_possiveis"
-- DETAIL:  Failing row contains (2147483653, limpar portas do 1o andar, 32323232911, 2, A).

-- Questão 7

ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_prioridade_possiveis CHECK (prioridade >= 0 AND prioridade <=5);
-- ERROR:  check constraint "tarefas_chk_prioridade_possiveis" is violated by some row

DELETE FROM tarefas WHERE prioridade > 5;

ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_prioridade_possiveis CHECK (prioridade >= 0 AND prioridade <=5);

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 6, 'A');
-- ERROR:  new row for relation "tarefas" violates check constraint "tarefas_chk_prioridade_possiveis"
-- DETAIL:  Failing row contains (2147483649, limpar portas da entrada principal, 32322525199, 32767, A).

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', -1, 'A');
-- ERROR:  new row for relation "tarefas" violates check constraint "tarefas_chk_prioridade_possiveis"
-- DETAIL:  Failing row contains (2147483649, limpar portas da entrada principal, 32322525199, -1, A).

-- Questão 8

CREATE TABLE funcionario(
    cpf CHAR(11),
    data_nasc DATE,
    nome TEXT,
    funcao TEXT,
    nivel CHAR(1),
    superior_cpf CHAR(11)
    
);