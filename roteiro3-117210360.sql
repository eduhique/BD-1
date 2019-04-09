-- 
-- Criacao das Tabelas
-- 

CREATE TYPE ESTADO_NE AS ENUM ('PB', 'PE', 'RN', 'BA', 'CE', 'PI','SE', 'AL','MA');
CREATE TYPE funcao_fun AS ENUM ('FARMACEUTICO', 'VENDEDOR', 'ENTREGADOR', 'CAIXA', 'ADMINISTRADOR');
CREATE TYPE adress_tipo AS  ENUM ('RESIDENCIA', 'TRABALHO', 'OUTRO');

CREATE TABLE funcionarios(
    cpf CHAR(11) NOT NULL,
    nome TEXT NOT NULL,
    funcao funcao_fun NOT NULL,
    farmaciaID BIGINT,
    gerente BOOLEAN NOT NULL,
    CONSTRAINT funcionarios_cpf_pkey PRIMARY KEY(cpf),
    CONSTRAINT funcionarios_chk_cpf_valido CHECK(LENGTH(cpf) = 11),
    CONSTRAINT funcionarios_chk_farmciaID_valido CHECK(farmaciaID >0),
    CONSTRAINT funcionarios_gerente_ex EXCLUDE USING gist(farmaciaID with=) WHERE (gerente = true),
    CONSTRAINT funcionarios_gerente_chk CHECK(farmaciaID IS NULL AND gerente = false)
);

CREATE TABLE farmacias(
    fa_id BIGINT,
    nome VARCHAR(20) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    estado ESTADO_NE NOT NULL,
    gerente CHAR(11) NOT NULL,
    gerente_fun funcao_fun NOT NULL,
    tipo_loja CHAR(1) NOT NULL,
    CONSTRAINT farmacias_id_pkey PRIMARY KEY(fa_id),
    CONSTRAINT farmacias_chk_fa_ID_valido CHECK(fa_id >0),
    CONSTRAINT farmacias_bairro_un UNIQUE(bairro),
    CONSTRAINT farmacias_tipo_ex EXCLUDE USING gist(tipo_loja with=) WHERE (tipo_loja = 'S'),
    CONSTRAINT farmacias_tipo_chk CHECK(tipo_loja = 'S' OR tipo_loja = 'F'),
    CONSTRAINT farmacias_gerente_fkey FOREIGN KEY (gerente) REFERENCES funcionarios(cpf),
    CONSTRAINT farmacias_gerente_fun_fkey FOREIGN KEY (gerente_fun) REFERENCES funcionarios(funcao),
    CONSTRAINT farmacias_gerente_fun_chk CHECK(gerente_fun = 'FARMACEUTICO' OR gerente_fun = 'ADMINISTRADOR')
);

ALTER TABLE funcionarios ADD CONSTRAINT funcionarios_farmaciaID_fkey FOREIGN KEY(farmaciaID) REFERENCES farmacias(fa_id);

CREATE TABLE medicamentos(
    medID BIGINT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    prin_ativo VARCHAR(50) NOT NULL,
    venda_exclusiva BOOLEAN NOT NULL UNIQUE,
    valor NUMERIC NOT NULL,
    CONSTRAINT medicamentos_medID_pkey PRIMARY KEY(medID),
    CONSTRAINT medicamentos_valor_chk CHECK(valor >= 0)  
);

CREATE TABLE clientes(
    clienteID BIGINT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    data_nasc date NOT NULL,
    CONSTRAINT clientes_clienteID_pkey PRIMARY KEY(clienteID),
    CONSTRAINT clientes_idade_min_chk CHECK((extract(year from age(date '1997-07-21'))) >= 18)
);

CREATE TABLE enderecos(
    endeID BIGINT NOT NULL,
    clienteID BIGINT NOT NULL,
    tipo_endereco adress_tipo NOT NULL,
    estado ESTADO_NE NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    rua VARCHAR(70) NOT NULL,
    CONSTRAINT enderecos_endeID_pkey PRIMARY KEY(endeID),
    CONSTRAINT enderecos_clienteID_fkey FOREIGN KEY (clienteID) REFERENCES clientes(clienteID)
);

CREATE TABLE vendas(
    venID BIGINT NOT NULL,
    produto BIGINT NOT NULL,
    produto_receita BOOLEAN NOT NULL,
    clienteID BIGINT,
    valor NUMERIC NOT NULL,
    vendedor CHAR(11) NOT NULL,
    vendedor_fun funcao_fun NOT NULL,
    CONSTRAINT vendas_venID_pkey PRIMARY KEY(venID),
    CONSTRAINT vendas_produto_fkey FOREIGN KEY(produto) REFERENCES medicamentos(medID) ON DELETE RESTRICT,
    CONSTRAINT vendas_produto_receita_fkey FOREIGN KEY(produto_receita) REFERENCES medicamentos(venda_exclusiva) ON DELETE RESTRICT,
    CONSTRAINT vendas_clienteID_fkey FOREIGN KEY(clienteID) REFERENCES clientes(clienteID),
    CONSTRAINT vendas_vendedor_fkey FOREIGN KEY(vendedor) REFERENCES funcionarios(cpf) ON DELETE RESTRICT,
    CONSTRAINT vendas_vendedor_fun_fkey FOREIGN KEY(vendedor_fun) REFERENCES funcionarios(funcao) ON DELETE RESTRICT,
    CONSTRAINT vendas_receita_chk CHECK(clienteID IS NOT NULL AND produto_receita = true),
    CONSTRAINT vendas_valor_chk CHECK(valor >= 0),
    CONSTRAINT vendas_vendedor_chk CHECK(vendedor_fun = 'VENDEDOR')
);

CREATE TABLE entregas(
    entregaID BIGINT NOT NULL,
    vendaID BIGINT NOT NULL,
    clienteID BIGINT NOT NULL,
    enderecoID BIGINT NOT NULL,
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

INSERT INTO funcionarios VALUES ('12734805000', 'Carlos Wilson', 'FARMACEUTICO', null, false);
INSERT INTO funcionarios VALUES ('12734805001', 'Pedro Santos', 'FARMACEUTICO', null, false);
INSERT INTO funcionarios VALUES ('12734805013', 'Ana Paula', 'ADMINSTRADOR', null, false);
INSERT INTO funcionarios VALUES ('12734805001', 'Carla Silva', 'FARMACEUTICO', null, false);
