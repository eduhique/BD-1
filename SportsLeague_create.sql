-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-05-24 05:42:53.25

-- tables
-- Table: escalado_para
CREATE TABLE escalado_para (
    partida_code int  NOT NULL,
    time_jogador int  NOT NULL,
    cpf_jogador char(11)  NOT NULL,
    posicao_jogada varchar(2)  NOT NULL,
    CONSTRAINT escalado_para_pk PRIMARY KEY (partida_code,time_jogador,cpf_jogador)
);

-- Table: jogador
CREATE TABLE jogador (
    cpf_jogador char(11)  NOT NULL,
    primeiro_nome varchar(10)  NOT NULL,
    ultimo_nome varchar(10)  NULL,
    cod_time int  NOT NULL,
    posicao varchar(2)  NOT NULL,
    data_inicio date  NOT NULL,
    CONSTRAINT jogador_time_un UNIQUE (cpf_jogador, cod_time) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT jogador_cpf_chk CHECK (LENGTH(cpf_jogador) = 11) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT jogador_cpf_pkey PRIMARY KEY (cpf_jogador)
);

-- Table: partida
CREATE TABLE partida (
    code_partida serial  NOT NULL,
    data date  NOT NULL,
    juiz_1 varchar(20)  NOT NULL,
    juiz_2 varchar(20)  NOT NULL,
    juiz_linha_1 varchar(20)  NOT NULL,
    juiz_linha_2 varchar(20)  NOT NULL,
    apontador_1 varchar(20)  NOT NULL,
    apontador_2 varchar(20)  NOT NULL,
    local text  NOT NULL,
    CONSTRAINT partida_pk PRIMARY KEY (code_partida)
);

-- Table: partida_time
CREATE TABLE partida_time (
    time_cod_time int  NOT NULL,
    partida_code int  NOT NULL,
    set_1 int  NOT NULL,
    set_2 int  NOT NULL,
    set_3 int  NOT NULL,
    set_4 int  NOT NULL,
    timebreak int  NULL,
    vecendor boolean  NOT NULL,
    CONSTRAINT time_partida_pkey PRIMARY KEY (time_cod_time,partida_code)
);

-- Table: time
CREATE TABLE time (
    cod_time serial  NOT NULL,
    nome varchar(15)  NOT NULL,
    tecnico varchar(20)  NOT NULL,
    ct_endereco text  NULL,
    CONSTRAINT time_nome_un UNIQUE (nome) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT time_tecnico_un UNIQUE (tecnico) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT time_cod_time_pkey PRIMARY KEY (cod_time)
);

-- foreign keys
-- Reference: escalado_para_jogador_fkey (table: escalado_para)
ALTER TABLE escalado_para ADD CONSTRAINT escalado_para_jogador_fkey
    FOREIGN KEY (cpf_jogador, time_jogador)
    REFERENCES jogador (cpf_jogador, cod_time)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: escalado_para_partida_fkey (table: escalado_para)
ALTER TABLE escalado_para ADD CONSTRAINT escalado_para_partida_fkey
    FOREIGN KEY (time_jogador, partida_code)
    REFERENCES partida_time (time_cod_time, partida_code)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: partida_time_fkey (table: partida_time)
ALTER TABLE partida_time ADD CONSTRAINT partida_time_fkey
    FOREIGN KEY (time_cod_time)
    REFERENCES time (cod_time)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: partida_time_partida_fkey (table: partida_time)
ALTER TABLE partida_time ADD CONSTRAINT partida_time_partida_fkey
    FOREIGN KEY (partida_code)
    REFERENCES partida (code_partida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_cod_fkey (table: jogador)
ALTER TABLE jogador ADD CONSTRAINT time_cod_fkey
    FOREIGN KEY (cod_time)
    REFERENCES time (cod_time)
    ON DELETE  SET NULL 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

-- Inserts

-- time {DEFAULT, nome, tecnico, ct_endereco}
INSERT INTO time VALUES (DEFAULT, 'SADA CRUZEIRO', 'MENDEZ MARCELO', 'POLIESPORTIVO DO RIACHO - RUA RIO PARAOPEBA, 1200, CONTAGEM - MG'),
    (DEFAULT, 'SESI-SP', 'LEONALDO RUBINHO', 'MARCELLO DE CASTRO LEITE - VILA LEOPOLDINA - RUA CARLOS WEBER, 835, SAO PAULO - SP'),
    (DEFAULT, 'SESC-RJ', 'GAVIO GIOVANE', 'TIJUCA TENIS CLUBE - RUA DESEMBARGADOR IZIDRO, 74, RIO DE JANEIRO - RJ'),
    (DEFAULT, 'COPEL TELECOM', 'FADUL ALESSANDRO', 'GINASIO CHICO NETO - RUA PROF LAURO EDUARDO WERNECK, MARINGA - PR'),
    (DEFAULT, 'FIAT/MINAS', 'JUNIOR NERY TAMBEIRO', 'ARENA MINAS TENIS CLUBE - RUA DA BAHIA, 2244, BELO HORIZONTE - MG');

-- jogador {cpf, nome, nome, cod_time, pos, data}
--FIAT/MINAS
INSERT INTO jogador VALUES ('82836685603','ELIAN', 'MAZORRA', 5,'PO', '2017-04-27'),
    ('11124720618','HENRIQUE', 'HONORATO', 5,'PO','2017-11-13'),
    ('98858753607','MATHEUS', 'SANTOS', 5,'CE','2016-06-28'),
    ('24623238644','FLAVIO', 'GUALBERTO', 5,'CE','2018-12-08'),
    ('53244621600','MARLON', 'YARED', 5,'LE','2016-09-08'),
    ('44011591602','DAVY', 'SILVA', 5,'OP','2019-01-16'),
    ('78010759600','LUCCA', 'VIERA', 5,'LB','2017-12-07'),
    ('59148220680','EDUARDO', 'CARISIO', 5,'LE','2017-12-24'),
    ('45867445615','LUCAS', 'FIGUEREDO', 5,'PO','2018-03-06');

-- SADA CRUZEIRO
INSERT INTO jogador VALUES ('33387839650','LEONARDO', 'NASCIMENTO', 1,'PO', '2018-12-09'),
    ('88151103647','RODRIGO', 'LEAO', 1,'PO', '2018-09-27'),
    ('16886665677','EDER', 'KOCK', 1,'CE', '2017-02-25'),
    ('78856809672','ARAUJO', 'ROBERT', 1,'CE', '2018-11-10'),
    ('35420738651','SANDRO', 'CARVALHO', 1,'LE', '2017-07-25'),
    ('92942186607','LUAN', 'WEBER', 1,'OP', '2018-10-24'),
    ('99159237678','SERGIO', 'NOGUEIRA', 1,'LB', '2016-03-10'),
    ('27859197693','FERNANDO', 'KRELING', 1,'LE', '2016-11-01'),
    ('50819141690','FILIPE', 'FERRAZ', 1,'PO', '2016-06-30');

-- SESI-SP
INSERT INTO jogador VALUES ('54391592827','ALAN', 'MACIEL', 2,'PO', '2017-06-12'),
    ('92658032820','ALAN', 'PATRICK', 2,'PO', '2018-02-07'),
    ('10186160801','GABRIEL', 'BERTOLINI', 2,'CE', '2018-04-02'),
    ('41350348880','LUCAS', 'BARRETO', 2,'CE', '2017-03-19'),
    ('00600846857','EVANDRO', 'BATISTA', 2,'LE', '2017-12-29'),
    ('95390820800','ALAN', 'SOUZA', 2,'OP', '2016-06-05'),
    ('14320355849','ENDRES', 'MURILO', 2,'LB', '2017-02-11'),
    ('84453649878','WILLIAM', 'ARJONA', 2,'LE', '2019-02-06'),
    ('02424894868','FELIPE', 'FONTELES', 2,'PO', '2016-08-31');

-- SESC-RJ
INSERT INTO jogador VALUES ('13492334717','DJALMA', 'JUNIOR', 3,'PO', '2018-05-05'),
    ('77436872796','MAURICIO', 'BORGES', 3,'PO', '2016-06-23'),
    ('00441691757','PAULO', 'M. PEREIRA', 3,'CE', '2017-12-27'),
    ('48895864743','HUGO', 'V. PEREIRA',3,'CE', '2018-08-02'),
    ('49009228703','EVERALDO', 'LUCENA', 3,'LE', '2018-01-16'),
    ('61193893771','WALLACE', 'SOUZA', 3,'OP', '2018-10-20'),
    ('29092666726','ALEXANDRE', 'ELIAS', 3,'LB', '2018-02-19'),
    ('08609209768','THIAGO', 'BARTH', 3,'LE', '2017-10-31'),
    ('60344305775','VALDIR', 'JUNIOR', 3,'PO', '2017-12-06');

-- COPEL TELECOM
INSERT INTO jogador VALUES ('94510276966','VINICIOS', 'SILVEIRA', 4,'PO', '2018-05-14'),
    ('94860230930','DANIEL', 'OLIVEIRA', 4,'PO', '2016-09-10'),
    ('06333392960','SILVIO', 'SANTOS', 4,'CE', '2017-09-08'),
    ('02770261991','VICTOR', 'ARAUJO', 4,'CE', '2016-09-09'),
    ('40521552974','RODRIGO', 'ROGRIGUES', 4,'LE', '2018-01-26'),
    ('05812464979','LUCAS', 'RIBEIRO', 4,'OP', '2019-01-15'),
    ('21754578934','DANIEL', 'ROSSI', 4,'LB', '2017-03-30'),
    ('61626210900','JONATAN', 'S. PEIXOTO', 4,'LE', '2018-02-01'),
    ('21421986949','VINICIUS', 'SANTOS', 4,'PO', '2016-10-29');

--Partida (code_partida, data,juiz_1, juiz_2, juiz_linha_1, juiz_linha_2, apontador_1, apontador_2, local)
INSERT INTO partida VALUES
    (DEFAULT, '2019-04-05', 'ANDRE LEITE', 'CARLA SILVA', 'LUIZ MOTA', 'PEDRO JUNIO', 'FELIPE ARAUJO', 'PRISCILA AMORIN', 'POLIESPORTIVO DO RIACHO - RUA RIO PARAOPEBA, 1200, CONTAGEM - MG'),
    (DEFAULT, '2019-04-06','PRISCILA AMORIN', 'BRUNO GARCIA', 'THAIS FREITAS', 'THIAGO PELOTAS', 'EUGENIO BATISTA', 'JORGE CARVALHO', 'TIJUCA TENIS CLUBE - RUA DESEMBARGADOR IZIDRO, 74, RIO DE JANEIRO - RJ'),
    (DEFAULT, '2019-04-18','GENILSON PEDROSA', 'LUANA SANTANA', 'EDSON LUIZ', 'EDVALDO GARCIA', 'FELIPE MOURA', 'TADEU GUSTAVO', 'ARENA MINAS TENIS CLUBE - RUA DA BAHIA, 2244, BELO HORIZONTE - MG');