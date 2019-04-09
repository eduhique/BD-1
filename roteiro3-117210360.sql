CREATE TYPE ESTADO_NE AS ENUM ('PB', 'PE', 'RN', 'BA', 'CE', 'PI','SE', 'AL','MA');
CREATE TYPE funcao_fun AS ('famacêuticos', 'vendedores', 'entregadores', 'caixas', 'administradores');


CREATE TABLE funcionarios(
    cpf CHAR(11),
    nome TEXT,
    funcao funcao_fun,
    farmaciaID SMALLSERIAL,
    gerente BOOLEAN,


);

CREATE TABLE farmacias(
    fa_id SMALLSERIAL,
    nome VARCHAR(20),
    bairro VARCHAR(20),
    cidade VARCHAR(20),
    estado ESTADO_NE,
    gerente CHAR(11),
    gerente_fun funcao_fun,
    tipo_loja CHAR(1),
    CONSTRAINT farmacias_id_pkey PRIMARY KEY(fa_id),
    CONSTRAINT farmacias_bairro_un UNIQUE(bairro),
    CONSTRAINT farmacias_tipo_ex EXCLUDE USING gist(tipo_loja with=) WHERE (tipo_loja = 'S'),
    CONSTRAINT farmacias_tipo_chk CHECK(tipo_loja = 'S' OR tipo_loja = 'F'),
    CONSTRAINT farmacias_gerente_fkey FOREIGN KEY (gerente) REFERENCES funcionarios(cpf),
    CONSTRAINT farmacias_gerente_fkey FOREIGN KEY (gerente_fun) REFERENCES funcionarios(funcao)
    CONSTRAINT farma

);


CREATE TABLE medicamentos(

);

CREATE TABLE vendas(

);

CREATE TABLE entregas(

);

CREATE TABLE clientes(

);
