--
-- Criacao das Tabelas
--

CREATE TYPE ESTADO_NE AS ENUM ('PB', 'PE', 'RN', 'BA', 'CE', 'PI','SE', 'AL','MA');
CREATE TYPE FUNCAO_FUN AS ENUM ('FARMACEUTICO', 'VENDEDOR', 'ENTREGADOR', 'CAIXA', 'ADMINISTRADOR');
CREATE TYPE ADDRESS_TIPO AS  ENUM ('RESIDENCIA', 'TRABALHO', 'OUTRO');

CREATE TABLE funcionarios(
    cpf CHAR(11) NOT NULL,
    nome TEXT NOT NULL,
    funcao FUNCAO_FUN NOT NULL,
    farmaciaID INTEGER,
    CONSTRAINT funcionarios_cpf_pkey PRIMARY KEY(cpf),
    CONSTRAINT funcionarios_chk_cpf_valido CHECK(LENGTH(cpf) = 11),
    CONSTRAINT funcionarios_chk_farmciaID_valido CHECK(farmaciaID >0),
    CONSTRAINT funcionarios_funcao_uni UNIQUE(cpf, funcao)
);

CREATE TABLE farmacias(
    fa_id SERIAL,
    nome VARCHAR(50) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    estado ESTADO_NE NOT NULL,
    gerente CHAR(11) NOT NULL,
    gerente_fun FUNCAO_FUN NOT NULL,
    tipo_loja CHAR(1) NOT NULL,
    CONSTRAINT farmacias_id_pkey PRIMARY KEY(fa_id),
    CONSTRAINT farmacias_chk_fa_ID_valido CHECK(fa_id >0),
    CONSTRAINT farmacias_bairro_un UNIQUE(bairro),
    CONSTRAINT farmacias_tipo_ex EXCLUDE USING gist(tipo_loja with=) WHERE (tipo_loja = 'S'),
    CONSTRAINT farmacias_tipo_chk CHECK(tipo_loja = 'S' OR tipo_loja = 'F'),
    CONSTRAINT farmacias_gerente_fkey FOREIGN KEY (gerente, gerente_fun) REFERENCES funcionarios(cpf,funcao) ON DELETE RESTRICT,
    CONSTRAINT farmacias_gerente_fun_chk CHECK(gerente_fun = 'FARMACEUTICO' OR gerente_fun = 'ADMINISTRADOR'),
    CONSTRAINT farmacias_gerente_un UNIQUE(gerente, fa_id)
);

ALTER TABLE funcionarios ADD CONSTRAINT funcionarios_farmaciaID_fkey FOREIGN KEY(cpf, farmaciaID) REFERENCES farmacias(gerente, fa_id);

CREATE TABLE medicamentos(
    medID SERIAL,
    nome VARCHAR(50) NOT NULL,
    prin_ativo VARCHAR(50) NOT NULL,
    venda_exclusiva BOOLEAN NOT NULL,
    valor NUMERIC NOT NULL,
    CONSTRAINT medicamentos_venda_uni UNIQUE(medID, venda_exclusiva),
    CONSTRAINT medicamentos_medID_pkey PRIMARY KEY(medID),
    CONSTRAINT medicamentos_valor_chk CHECK(valor >= 0)
);

CREATE TABLE clientes(
    clienteID SERIAL,
    nome VARCHAR(50) NOT NULL,
    data_nasc date NOT NULL,
    CONSTRAINT clientes_clienteID_pkey PRIMARY KEY(clienteID),
    CONSTRAINT clientes_idade_min_chk CHECK((extract(year from age(data_nasc))) >= 18)
);

CREATE TABLE enderecos(
    endeID SERIAL,
    clienteID INTEGER NOT NULL,
    tipo_endereco ADDRESS_TIPO NOT NULL,
    estado ESTADO_NE NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    rua VARCHAR(70) NOT NULL,
    CONSTRAINT enderecos_endeID_pkey PRIMARY KEY(endeID),
    CONSTRAINT enderecos_clienteID_fkey FOREIGN KEY (clienteID) REFERENCES clientes(clienteID)
);

CREATE TABLE vendas(
    venID SERIAL,
    produto INTEGER NOT NULL,
    produto_receita BOOLEAN NOT NULL,
    clienteID INTEGER,
    valor NUMERIC NOT NULL,
    vendedor CHAR(11) NOT NULL,
    vendedor_fun FUNCAO_FUN NOT NULL,
    CONSTRAINT vendas_venID_pkey PRIMARY KEY(venID),
    CONSTRAINT vendas_produto_receita_fkey FOREIGN KEY(produto, produto_receita) REFERENCES medicamentos(medID, venda_exclusiva) ON DELETE RESTRICT,
    CONSTRAINT vendas_clienteID_fkey FOREIGN KEY(clienteID) REFERENCES clientes(clienteID),
    CONSTRAINT vendas_vendedor_fkey FOREIGN KEY(vendedor, vendedor_fun) REFERENCES funcionarios(cpf, funcao) ON DELETE RESTRICT,
    CONSTRAINT vendas_receita_chk CHECK (NOT(clienteID IS NULL AND produto_receita = true)),
    CONSTRAINT vendas_valor_chk CHECK(valor >= 0),
    CONSTRAINT vendas_vendedor_chk CHECK(vendedor_fun = 'VENDEDOR')
);

CREATE TABLE entregas(
    entregaID SERIAL,
    vendaID INTEGER NOT NULL,
    clienteID INTEGER NOT NULL,
    enderecoID INTEGER NOT NULL,
    CONSTRAINT entregas_entregaID_pkey PRIMARY KEY(entregaID),
    CONSTRAINT entregas_vendaID_fkey FOREIGN KEY(vendaID) REFERENCES vendas(venID),
    CONSTRAINT entregas_clienteID_fkey FOREIGN KEY(clienteID) REFERENCES clientes(clienteID),
    CONSTRAINT entregas_enderecoID_fkey FOREIGN KEY(enderecoID) REFERENCES enderecos(endeID)
);

--
-- COMANDOS ADICIONAIS
--

-- Devem ser executados com sucesso
--

INSERT INTO funcionarios VALUES ('12734805000', 'Carlos Wilson', 'FARMACEUTICO', null),
    ('12734805001', 'Pedro Santos', 'FARMACEUTICO', null),
    ('12734805013', 'Ana Paula', 'ADMINISTRADOR', null),
    ('12734805021', 'Carla Silva', 'VENDEDOR', null),
    ('12734804002', 'Mario Batista', 'ENTREGADOR', null),
    ('12734807001', 'Fernanda Barbosa', 'ADMINISTRADOR', null),
    ('12734805002', 'Joao Paulo', 'ENTREGADOR', null);

INSERT INTO farmacias VALUES (DEFAULT, 'REDEPHARMA Unidade Manaira', 'Manaira', 'João Pessoa', 'PB', '12734805000', 'FARMACEUTICO', 'S'),
    (DEFAULT,'REDEPHARMA Unidade Geisel', 'geisel', 'João Pessoa', 'PB', '12734805013', 'ADMINISTRADOR', 'F'),
    (DEFAULT,'PAGUE MENOS Unidade Prata', 'prata', 'Campina Grande', 'PB', '12734805001', 'FARMACEUTICO', 'F');

UPDATE funcionarios SET farmaciaID = 1 WHERE cpf = '12734805000';
UPDATE funcionarios SET farmaciaID = 2 WHERE cpf = '12734805013';
UPDATE funcionarios SET farmaciaID = 3 WHERE cpf = '12734805001';

