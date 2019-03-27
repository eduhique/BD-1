-- questão 1

CREATE TABLE Automoveis (
A_placa varchar(8),
A_fabricante text,
A_modelo text,
A_num_Chassi varchar(17),
A_ano_Fabricacao Integer,
A_estado text,
A_segurado_Id INTEGER(11),
A_seguro_Id varchar(10),
A_tabela_FIPE Integer);

CREATE TABLE Segurado(
S_nome TEXT,
S_cpf INTEGER(11),
S_sexo TEXT,
S_telefone INTEGER(11),
S_endereco TEXT,
S_CEP INTEGER(8),
S_data_nascimento DATE,
S_classe_bonus INTEGER,
S_seguro_Id varchar(10));

CREATE TABLE Perito(
P_nome TEXT,
P_cpf INTEGER(11),
P_telefone INTEGER(11),
P_endereco TEXT,
P_CEP INTEGER(8),
P_data_nascimento INTEGER(8),
P_id varchar(10);

CREATE TABLE Oficina(
O_nome_Fantasia TEXT,
O_razao_social TEXT,
O_cnpj INTEGER(14),
O_telefone INTEGER(11),
O_endereco TEXT,
O_CEP INTEGER(8));

CREATE TABLE Seguro (
SE_id varchar(10),
SE_data DATA,
SE_classe_bonus INTEGER,
SE_Segurado INTEGER(11),
SE_placa varchar(8),
SE_pago INTEGER,
SE_valor_apolice_sinistro INTEGER,
SE_valor_apolice_vidros INTEGER,
SE_valor_apolice_farol INTEGER,
SE_valor_terceiros INTEGER,
SE_condutores TEXT);

CREATE TABLE Sinistro (
SI_id VARCHAR(10),
SI_data_ocorrencia TIMESTAMP
SI_pericia VARCHAR(10),
SI_veiculo VARCHAR(8),
SI_seguro VARCHAR(10),
SI_Condutor TEXT,
SI_vitimas BOOLEAN,
SI_terceiros BOOLEAN,
SI_Depoimento TEXT);

CREATE TABLE Pericia (
PER_id VARCHAR(10),
PER_sinistro_id VARCHAR(10),
PER_perito VARCHAR(10),
PER_veiculo VARCHAR(8),
PER_Descricao TEXT);









