CREATE TABLE empresa
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  codigo character varying(14) NOT NULL,
  nmempresa character varying(255) NOT NULL,
  dtcadastro date NOT NULL,
  CONSTRAINT empresa_pkey PRIMARY KEY (id)
);


CREATE TABLE pais
(
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  cdpais character varying(5) NOT NULL,
  nmpais character varying(250) NOT NULL,
  cdsiscomex character varying(5),
  sgpais2 character varying(2),
  sgpais3 character varying(3),
  CONSTRAINT pais_pkey PRIMARY KEY (id),
  CONSTRAINT pais_cdpais_key UNIQUE (cdpais)
);

CREATE INDEX pais_cdpais_like ON pais(cdpais);
CREATE INDEX pais_cdsiscomex ON pais(cdsiscomex);
CREATE INDEX pais_cdsiscomex_like ON pais(cdsiscomex);


CREATE TABLE estado
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  cdestado character varying(2) NOT NULL,
  nmestado character varying(40) NOT NULL,
  sgestado character varying(2) NOT NULL,
  pais_id integer NOT NULL,
  dsregiao character varying(20) NOT NULL,
  CONSTRAINT estado_pkey PRIMARY KEY (id),
  CONSTRAINT pais_id_refs_id_6c29dca0 FOREIGN KEY (pais_id)
      REFERENCES pais (id),
  CONSTRAINT estado_cdestado_key UNIQUE (cdestado),
  CONSTRAINT estado_sgestado_key UNIQUE (sgestado)
);

CREATE INDEX estado_cdestado_like ON estado(cdestado);
CREATE INDEX estado_pais_id ON estado(pais_id);
CREATE INDEX estado_sgestado_like ON estado(sgestado);


CREATE TABLE cidade
(
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  cdcidade character varying(10) NOT NULL,
  nmcidade character varying(250) NOT NULL,
  pais_id integer NOT NULL,
  estado_id integer NOT NULL,
  CONSTRAINT cidade_pkey PRIMARY KEY (id),
  CONSTRAINT estado_id_refs_id_e254ed43 FOREIGN KEY (estado_id)
      REFERENCES estado (id),
  CONSTRAINT pais_id_refs_id_12b4b1b1 FOREIGN KEY (pais_id)
      REFERENCES pais (id),
  CONSTRAINT cidade_cdcidade_key UNIQUE (cdcidade)
);

CREATE INDEX cidade_cdcidade_like ON cidade (cdcidade);
CREATE INDEX cidade_estado_id ON cidade(estado_id);
CREATE INDEX cidade_pais_id ON cidade (pais_id);


CREATE TABLE bairro
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  cdbairro character varying(10) NOT NULL,
  nmbairro character varying(250) NOT NULL,
  cidade_id integer NOT NULL,
  CONSTRAINT bairro_pkey PRIMARY KEY (id),
  CONSTRAINT cidade_id_refs_id_799ddc47 FOREIGN KEY (cidade_id)
      REFERENCES cidade (id),
  CONSTRAINT bairro_cdbairro_key UNIQUE (cdbairro)
);
CREATE INDEX bairro_cdbairro_like ON bairro(cdbairro);
CREATE INDEX bairro_cidade_id ON bairro (cidade_id);



CREATE TABLE cliente
(
  id integer NOT NULL AUTO_INCREMENT,
  nrinscjurd character varying(20) NOT NULL,
  nmcliente character varying(250) NOT NULL,
  identificador character varying(1) NOT NULL,
  telcel character varying(15),
  telfixo character varying(15),
  nmrua character varying(200),
  cdnumero character varying(30),
  cdcep character varying(10),
  cdbairro_id integer,
  CONSTRAINT cliente_pkey PRIMARY KEY (id),
  CONSTRAINT cliente_telcel_key UNIQUE (telcel),
  CONSTRAINT cdbairro_id_refs_id_302eac2a FOREIGN KEY (cdbairro_id)
      REFERENCES bairro (id)

);
CREATE INDEX cliente_nmcliente_like ON cliente (nmcliente);

CREATE TABLE fornecedor
(
  id integer not null AUTO_INCREMENT,
  nrinscjurd character varying(20) NOT NULL,
  nmfornecedor character varying(250) NOT NULL,
  identificador character varying(1) NOT NULL,
  nmrua character varying(200),
  cdnumero character varying(30),
  cdcep character varying(10),
  cdbairro_id integer,
  telcel character varying(15),
  telfixo character varying(15),
  CONSTRAINT fornecedor_pkey PRIMARY KEY (id),
  CONSTRAINT fornecedor_telcel_key UNIQUE (telcel),
  CONSTRAINT cdbairro_id_refs_id_fe7bab86 FOREIGN KEY (cdbairro_id)
      REFERENCES bairro (id)
);

CREATE INDEX fornecedor_nmfornecedor_like ON fornecedor(nmfornecedor);


CREATE TABLE endereco
(
  id integer NOT NULL AUTO_INCREMENT,
  nmrua character varying(200) NOT NULL,
  cdnumero character varying(30) NOT NULL,
  cdcep character varying(10) NOT NULL,
  dtcadastro date NULL,
  cdbairro_id integer NOT NULL,
  cliente_id integer NULL,
  fornecedor_id integer NULL,
  CONSTRAINT endereco_pkey PRIMARY KEY (id),
  CONSTRAINT endereco_cdbairro_id_fkey FOREIGN KEY(cdbairro_id)
      REFERENCES bairro(id),
  CONSTRAINT endereco_cliente_id FOREIGN KEY(cliente_id)
      REFERENCES cliente(id),
  CONSTRAINT endereco_forne_id_id FOREIGN KEY(fornecedor_id)
      REFERENCES fornecedor(id)

);


CREATE TABLE Almoxarifado
(
  id integer NOT NULL AUTO_INCREMENT,
  nmalmoxa character varying(250) NOT NULL,
  dtcadastro date,
  CONSTRAINT Almoxarifado_pkey PRIMARY KEY(id)
);


CREATE TABLE unidade
(
  id integer NOT NULL AUTO_INCREMENT,
  nmrazao character varying(255) NOT NULL,
  nmfantasia character varying(255) NOT NULL,
  almoxpedido_id integer not null,
  CONSTRAINT unidade_pkey PRIMARY KEY(id)
);
CREATE INDEX unidade_almoxpedido_id ON unidade(almoxpedido_id);


CREATE TABLE unimedida
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  nmmedida character varying(100) NOT NULL,
  sgmedida character varying(5) NOT NULL,
  qtfatorconv FLOAT(14,2) NOT NULL,
  idtipomed character varying(1) NOT NULL,
  CONSTRAINT unimedida_pkey PRIMARY KEY (id)
);



CREATE TABLE produto
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  posarvore character varying(40),
  nmproduto character varying(200) NOT NULL,
  unimedida_id integer NOT NULL,
  cdbarra character varying(100),
  idprodvenda boolean NOT NULL,
  idadicional boolean NOT NULL,
  imgindex integer NOT NULL,
  CONSTRAINT produto_pkey PRIMARY KEY (id),
  CONSTRAINT produto_unimedida_id_fkey FOREIGN KEY (unimedida_id)
      REFERENCES unimedida (id)
);

CREATE INDEX produto_unimedida_id ON produto(unimedida_id);


CREATE TABLE finalidade
(
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  descricao character varying(150) NOT NULL,
  CONSTRAINT finalidade_pkey PRIMARY KEY (id)
);


CREATE TABLE Entrada
(
  id integer NOT NULL AUTO_INCREMENT,
  dtentrada date NOT NULL,
  fornecedor_id integer NULL,
  id_web integer NULL,
  CONSTRAINT Entrada_pkey PRIMARY KEY(id));

CREATE TABLE Saida
(
  id integer NOT NULL AUTO_INCREMENT,
  dtsaida date NOT NULL,
  cliente_id integer NOT NULL,
  finalidade_id integer NULL,
  idtipo character varying(1) NOT NULL,
  id_web integer NULL,
  constraint Saida_pkey PRIMARY KEY(id),
  CONSTRAINT Saida_finalidade_id_fkey FOREIGN KEY (finalidade_id)
      REFERENCES finalidade (id)
);


CREATE TABLE lote
(
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro date null,
  dslote character varying(100) NOT NULL,
  dtvalidade date NOT NULL,
  dtfabricacao date NOT NULL,
  CONSTRAINT lote_pkey PRIMARY KEY (id)
);


CREATE TABLE posestoque
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date NULL,
  produto_id integer NOT NULL,
  lote_id integer,
  qtdeproduto FLOAT(14,2) NOT NULL,
  CONSTRAINT posestoque_pkey PRIMARY KEY (id),
  CONSTRAINT lote_id_refs_id_7787491a FOREIGN KEY (lote_id)
      REFERENCES lote (id),
  CONSTRAINT posestoque_produto_id_fkey FOREIGN KEY (produto_id)
      REFERENCES produto (id)
);

CREATE INDEX posestoque_lote_id ON posestoque(lote_id);
CREATE INDEX posestoque_produto_id ON posestoque(produto_id);


CREATE TABLE AgrupAdicional
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  nmagrupadic character varying(250) NOT NULL,
  vragrupadic FLOAT(14,2) NOT NULL,
  idagrupativ character varying(1) NOT NULL,
  CONSTRAINT AgrupAdicional_pkey PRIMARY KEY (id),
  CONSTRAINT AgrupAdicional_nmagrupadic_key UNIQUE (nmagrupadic)
);


CREATE TABLE categoria
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  nmcategoria character varying(250) NOT NULL,
  idcategoriativ character varying(1) NOT NULL,
  imgindex integer NOT NULL,
  CONSTRAINT categoria_pkey PRIMARY KEY(id),
  CONSTRAINT categoria_nmcategoria_key UNIQUE (nmcategoria)
);

CREATE INDEX categoria_nmcategoria_like ON categoria (nmcategoria);


CREATE TABLE ComposicaoProd
(
  id integer NOT NULL AUTO_INCREMENT,
  produto_id integer NOT NULL,
  prodcomp_id integer NOT NULL,
  qtcomp FLOAT(14,2) NOT NULL,
  unimedida_id integer NOT NULL,
  CONSTRAINT ComposicaoProd_pkey PRIMARY KEY (id),
  CONSTRAINT ComposicaoProd_prodcomp_id_fkey FOREIGN KEY (prodcomp_id)
      REFERENCES produto (id),
  CONSTRAINT ComposicaoProd_produto_id_fkey FOREIGN KEY (produto_id)
      REFERENCES produto (id),
  CONSTRAINT ComposicaoProd_unimedida_id_fkey FOREIGN KEY (unimedida_id)
      REFERENCES unimedida (id)
);

CREATE INDEX ComposicaoProd_prodcomp_id ON ComposicaoProd(prodcomp_id);
CREATE INDEX ComposicaoProd_produto_id ON ComposicaoProd (produto_id);
CREATE INDEX ComposicaoProd_unimedida_id ON ComposicaoProd(unimedida_id);


CREATE TABLE ItemCategoria
(
  id integer NOT NULL AUTO_INCREMENT,
  categoria_id integer NOT NULL,
  produto_id integer NOT NULL,
  vrvenda FLOAT(14,2) NOT NULL,
  qtvenda FLOAT(14,2) NOT NULL,
  qtadicgratis integer NOT NULL,
  CONSTRAINT ItemCategoria_pkey PRIMARY KEY (id),
  CONSTRAINT ItemCategoria_categoria_id_fkey FOREIGN KEY (categoria_id)
      REFERENCES categoria (id),
  CONSTRAINT ItemCategoria_produto_id_fkey FOREIGN KEY (produto_id)
      REFERENCES produto (id)
);

CREATE INDEX ItemCategoria_categoria_id ON ItemCategoria (categoria_id);
CREATE INDEX ItemCategoria_produto_id ON ItemCategoria (produto_id);


CREATE TABLE itagrupadicional
(
  id integer NOT NULL AUTO_INCREMENT,
  cardapio_id integer NOT NULL,
  agrupadicional_id integer NOT NULL,
  CONSTRAINT itagrupadicional_pkey PRIMARY KEY (id),
  CONSTRAINT itagrupadicional_agrupadicional_id_fkey FOREIGN KEY (agrupadicional_id)
      REFERENCES AgrupAdicional (id),
  CONSTRAINT itagrupadicional_cardapio_id_fkey FOREIGN KEY (cardapio_id)
      REFERENCES ItemCategoria (id)
);

CREATE INDEX itagrupadicional_agrupadicional_id ON itagrupadicional(agrupadicional_id);
CREATE INDEX itagrupadicional_cardapio_id ON itagrupadicional(cardapio_id);

CREATE TABLE mesa
(
  id integer NOT NULL AUTO_INCREMENT,
  nmmesa character varying(250) NOT NULL,
  dsobsmesa character varying(250),
  idmesaativ character varying(1) NOT NULL,
  CONSTRAINT mesa_pkey PRIMARY KEY (id),
  CONSTRAINT mesa_nmmesa_key UNIQUE (nmmesa)
);
CREATE INDEX mesa_nmmesa_like ON mesa (nmmesa);




CREATE TABLE pedido
(
  id integer NOT NULL AUTO_INCREMENT,
  idtipopedido character varying(1) NOT NULL,
  cliente_id integer NULL,
  nmcliente character varying(250),
  mesa_id integer null,
  vrpedido FLOAT(14,2) NOT NULL,
  idstatusped character varying(1) NOT NULL check(idstatusped in ('P', 'C')),/*pendente, concluido*/
  CONSTRAINT pedido_pkey PRIMARY KEY (id),
  CONSTRAINT mesa_id_refs_id_8a44dbc3 FOREIGN KEY (mesa_id)
      REFERENCES mesa(id),
  CONSTRAINT pedido_cliente_id_fkey FOREIGN KEY (cliente_id)
      REFERENCES cliente(id)
);

CREATE INDEX pedido_cliente_id ON pedido(cliente_id);
CREATE INDEX pedido_mesa_id ON pedido(mesa_id);


CREATE TABLE itempedido
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  dtcadastro date NULL,
  pedido_id integer NOT NULL,
  cardapio_id integer NOT NULL,
  lote_id integer NULL,
  qtitem FLOAT(14,2) NOT NULL,
  vrvenda FLOAT(14,2) NOT NULL,
  vrtotal FLOAT(14,2) NOT NULL,
  idadicional boolean NOT NULL,
  CONSTRAINT itempedido_pkey PRIMARY KEY (id),
  CONSTRAINT cardapio_id_refs_id_23fd3cc8 FOREIGN KEY (cardapio_id)
      REFERENCES ItemCategoria (id) ON DELETE CASCADE,
  CONSTRAINT itempedido_lote_id_fkey FOREIGN KEY (lote_id)
      REFERENCES lote (id),
  CONSTRAINT itempedido_pedido_id_fkey FOREIGN KEY (pedido_id)
      REFERENCES pedido (id)
);

CREATE INDEX itempedido_cardapio_id ON itempedido(cardapio_id);
CREATE INDEX itempedido_lote_id ON itempedido(lote_id);
CREATE INDEX itempedido_pedido_id ON itempedido(pedido_id);



CREATE TABLE adicionais
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  agrupadicional_id integer NOT NULL,
  item_id integer NOT NULL,
  valor FLOAT(14,2) NOT NULL,
  quantidade FLOAT(14,2) NOT NULL,
  id_web integer null,
  CONSTRAINT agrupadicional_adicionais_pkey PRIMARY KEY (id),
  CONSTRAINT agrupadicional_adicionais_agrupadicional_id_fkey FOREIGN KEY (agrupadicional_id)
      REFERENCES AgrupAdicional (id),
  CONSTRAINT agrupadicional_adicionais_item_id_fkey FOREIGN KEY (item_id)
      REFERENCES produto (id)
);

CREATE INDEX agrupadicional_adicionais_agrupadicional_id ON adicionais(agrupadicional_id);
CREATE INDEX agrupadicional_adicionais_item_id ON adicionais(item_id);


CREATE TABLE itadicional
(
  id integer NOT NULL AUTO_INCREMENT,
  itempedido_id integer NOT NULL,
  item_id integer NOT NULL,
  qtitem FLOAT(14,2) NOT NULL,
  CONSTRAINT itadicional_pkey PRIMARY KEY (id),
  CONSTRAINT itadicional_itempedido_id_fkey FOREIGN KEY (itempedido_id)
      REFERENCES itempedido(id) ON DELETE CASCADE,
  CONSTRAINT item_id_refs_id_a74b663d FOREIGN KEY (item_id)
      REFERENCES Adicionais(id)
);

CREATE INDEX frentecaixa_itadicional_item_id ON itadicional(item_id);
CREATE INDEX frentecaixa_itadicional_itempedido_id ON itadicional(itempedido_id);


CREATE TABLE funcionario
(
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro date,
  nome character varying(255) NOT NULL,
  usuario character varying(255) NOT NULL,
  sexo character varying(1) NOT NULL,
  dtnascimento date NOT NULL,
  email character varying(255) NOT NULL,
  senha character varying(128) NOT NULL,
  confsenha character varying(128) NOT NULL,
  endereco character varying(255) NOT NULL,
  numero character varying(20) NOT NULL,
  complemento character varying(255),
  cep character varying(9),
  pais_id integer NOT NULL,
  estado_id integer NOT NULL,
  cidade_id integer NOT NULL,
  bairro_id integer,
  dtadmissao date,
  dtdemissao date,
  pessoa character varying(2) NOT NULL,
  CONSTRAINT funcionario_pkey PRIMARY KEY (id),
  CONSTRAINT funcionario_bairro_id_fkey FOREIGN KEY (bairro_id)
      REFERENCES bairro (id),
  CONSTRAINT funcionario_cidade_id_fkey FOREIGN KEY (cidade_id)
      REFERENCES cidade (id),
  CONSTRAINT funcionario_estado_id_fkey FOREIGN KEY (estado_id)
      REFERENCES estado (id),
  CONSTRAINT funcionario_pais_id_fkey FOREIGN KEY (pais_id)
      REFERENCES pais (id)
);

CREATE INDEX funcionario_bairro_id ON funcionario(bairro_id);
CREATE INDEX funcionario_cidade_id ON funcionario(cidade_id);
CREATE INDEX funcionario_estado_id ON funcionario(estado_id);
CREATE INDEX funcionario_pais_id ON funcionario(pais_id);
CREATE UNIQUE INDEX funcionario_usuario ON funcionario(usuario);

CREATE TABLE caixa
(
  id integer NOT NULL AUTO_INCREMENT,
  nmcaixa character varying(50),
  CONSTRAINT caixa_pkey PRIMARY KEY(id)
);
CREATE UNIQUE INDEX ux_caixa_nmcaixa ON caixa(nmcaixa);

CREATE TABLE aberfechcaixa
(
  id integer NOT NULL AUTO_INCREMENT,
  id_caixa integer NOT NULL,
  vrinicial FLOAT(14,2) NOT NULL,
  vrcorrigido FLOAT(14,2) NULL,
  dtmovi date not null,
  funciconfabertura integer null,
  funcipreabertura integer null,
  vrvenda FLOAT(14,2) NULL,
  vrretirada FLOAT(14,2) NULL,
  vrsangria FLOAT(14,2) NULL,
  vrentrada FLOAT(14,2) NULL,
  vrdebio FLOAT(14,2) NULL,
  vrcredito FLOAT(14,2) NULL,
  funcifechamento integer null,
  status character varying(1) not null check(status in ('P', 'A', 'F')), /*pendente, aberto, Fechado*/
  CONSTRAINT abercaixa_pkey PRIMARY KEY(id),
  CONSTRAINT abercaixa_funcionario_fkey FOREIGN KEY(funciconfabertura)
     REFERENCES funcionario(id),
  CONSTRAINT abercaixa_funcionariopre_fkey FOREIGN KEY(funcipreabertura)
     REFERENCES funcionario(id),
  CONSTRAINT abercaixa_caixa_fkey FOREIGN KEY(id_caixa)
     REFERENCES caixa(id),
  CONSTRAINT fechcaixa_funcionario_fkey FOREIGN KEY(funcifechamento)
     REFERENCES funcionario(id)

);


CREATE TABLE movcaixa
(
  id integer NOT NULL AUTO_INCREMENT,
  id_caixa integer not null,
  dtmovi date not null,
  vrmovi FLOAT(14,2) not null,
  tpmovi character varying(1) not null check(tpmovi in ('E, V, S, R')), /*ENTRADA, VENDA, SANGRIA, RETIRADA*/
  formpgto character varying(2) not null check(formpgto in ('DI', 'DE', 'CR')), /*DINHEIRO, DEBITO, CREDITO*/
  id_pedido integer null,
  CONSTRAINT movcaixa_pkey PRIMARY KEY(id),
  CONSTRAINT movcaixa_caixa_fkey FOREIGN KEY(id_caixa)
     REFERENCES caixa(id),
  CONSTRAINT movcaixa_pedido FOREIGN KEY(id_pedido)
   REFERENCES pedido(id)
);



CREATE TABLE rotina
(
  id integer NOT NULL AUTO_INCREMENT,
  modulo character varying(255) NOT NULL,
  descricao character varying(255) NOT NULL,
  visivel character varying(1) NOT NULL DEFAULT 'S' CHECK(visivel in ('S', 'N')),
  CONSTRAINT rotina_pkey PRIMARY KEY(ID)
);

CREATE UNIQUE INDEX ux_rotina_modulo ON rotina(modulo);

CREATE TABLE permusr
(
  id integer NOT NULL AUTO_INCREMENT,
  id_rotina integer NOT NULL,
  descricao character varying(255) NOT NULL,
  funcionario_id integer not null,
  CONSTRAINT permusr_pkey PRIMARY KEY(id),
  CONSTRAINT permusr_rotina_fkey FOREIGN KEY(id_rotina)
    REFERENCES rotina(id)
);
CREATE UNIQUE INDEX ux_permusr_descricao ON permusr(id_rotina, descricao);


CREATE TABLE itemproduto (
  id integer NOT NULL AUTO_INCREMENT,
  dtcadastro DATE DEFAULT NULL,
  produto_id integer NOT NULL,
  lote_id integer DEFAULT NULL,
  qtdeprod DOUBLE NOT NULL,
  id_web integer NULL,
  PRIMARY KEY (id),
  INDEX itemproduto_0e78abec (produto_id),
  INDEX itemproduto_8f382e5a (lote_id),
  CONSTRAINT lote_id_refs_id_81ed77f5 FOREIGN KEY (lote_id)
    REFERENCES lote(id),
  CONSTRAINT produto_id_refs_id_4f2c4634 FOREIGN KEY (produto_id)
    REFERENCES produto(id)
)



alter table endereco add complemento character varying(255) NULL;
alter table empresa add id_web integer NULL;
alter table pais add id_web integer NULL;
alter table estado add id_web integer NULL;
alter table cidade add id_web integer NULL;
alter table bairro add id_web integer NULL;
alter table cliente add id_web integer NULL;
alter table fornecedor add id_web integer NULL;
alter table endereco add id_web integer NULL;
alter table unidade add id_web integer NULL;
alter table unimedida add id_web integer NULL;
alter table produto add id_web integer NULL;
alter table finalidade add id_web integer NULL;
alter table lote add id_web integer NULL;
alter table posestoque add id_web integer NULL;
alter table AgrupAdicional add id_web integer NULL;
alter table categoria add id_web integer NULL;
alter table ComposicaoProd add id_web integer NULL;
alter table ItemCategoria add id_web integer NULL;
alter table itagrupadicional add id_web integer NULL;
alter table mesa add id_web integer NULL;
alter table cliente add dtcadastro datetime not NULL DEFAULT CURRENT_TIMESTAMP;
alter table fornecedor add dtcadastro datetime not NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE ITEMPEDIDO ADD Produto_id integer NOT NULL;

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT ItemPedido_produto_id_fkey FOREIGN KEY (produto_id)
  REFERENCES produto (id);

ALTER TABLE ITADICIONAL ADD valor FLOAT(14,2) NOT NULL;
ALTER TABLE Entrada ADD dtcadastro datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Saida ADD dtcadastro datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE itemproduto ADD entrada_id INTEGER NULL;
ALTER TABLE itemproduto ADD saida_id INTEGER NULL;

ALTER TABLE itemproduto ADD CONSTRAINT FK_itemproduto_entrada FOREIGN KEY(entrada_id)
  REFERENCES Entrada(id);
  

ALTER TABLE itemproduto ADD CONSTRAINT FK_itemproduto_saida FOREIGN KEY(saida_id)
  REFERENCES Saida(id);

ALTER TABLE ITADICIONAL ADD valor FLOAT(14,2) NOT NULL;

ALTER TABLE PEDIDO ADD dsmotivo TEXT NULL;

ALTER TABLE mesa ADD idstatus character varying(1) NOT NULL  default 'L' check(idstatus in ('L', 'O'));

