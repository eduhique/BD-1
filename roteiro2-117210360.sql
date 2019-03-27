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
--ERROR:  column "id" contains null values
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
--ERROR:  column "descricao" contains null values
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
--ERROR:  column "func_resp_cpf" contains null values
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
--ERROR:  column "prioridade" contains null values
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;
--ERROR:  column "status" contains null values

DELETE FROM tarefas WHERE id IS NULL;

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Questão 5


