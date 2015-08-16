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
  empresa_id integer,
  dtcadastro date,
  cdpais character varying(5) NOT NULL,
  nmpais character varying(250) NOT NULL,
  cdsiscomex character varying(5),
  sgpais2 character varying(2),
  sgpais3 character varying(3),
  CONSTRAINT pais_pkey PRIMARY KEY (id),
  CONSTRAINT pais_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT pais_cdpais_key UNIQUE (cdpais)
);

CREATE INDEX pais_cdpais_like ON pais(cdpais);
CREATE INDEX pais_cdsiscomex ON pais(cdsiscomex);
CREATE INDEX pais_cdsiscomex_like ON pais(cdsiscomex);
CREATE INDEX pais_empresa_id ON pais (empresa_id);


CREATE TABLE estado
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  cdestado character varying(2) NOT NULL,
  nmestado character varying(40) NOT NULL,
  sgestado character varying(2) NOT NULL,
  pais_id integer NOT NULL,
  dsregiao character varying(20) NOT NULL,
  CONSTRAINT estado_pkey PRIMARY KEY (id),
  CONSTRAINT estado_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT pais_id_refs_id_6c29dca0 FOREIGN KEY (pais_id)
      REFERENCES pais (id),
  CONSTRAINT estado_cdestado_key UNIQUE (cdestado),
  CONSTRAINT estado_sgestado_key UNIQUE (sgestado)
);

CREATE INDEX estado_cdestado_like ON estado(cdestado);
CREATE INDEX estado_empresa_id ON estado (empresa_id);
CREATE INDEX estado_pais_id ON estado(pais_id);
CREATE INDEX estado_sgestado_like ON estado(sgestado);


CREATE TABLE cidade
(
  id integer NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  cdcidade character varying(10) NOT NULL,
  nmcidade character varying(250) NOT NULL,
  pais_id integer NOT NULL,
  estado_id integer NOT NULL,
  CONSTRAINT cidade_pkey PRIMARY KEY (id),
  CONSTRAINT cidade_empresa_id_fkey FOREIGN KEY (empresa_id) 
      REFERENCES empresa (id),
  CONSTRAINT estado_id_refs_id_e254ed43 FOREIGN KEY (estado_id)
      REFERENCES estado (id),
  CONSTRAINT pais_id_refs_id_12b4b1b1 FOREIGN KEY (pais_id)
      REFERENCES pais (id),
  CONSTRAINT cidade_cdcidade_key UNIQUE (cdcidade)
);

CREATE INDEX cidade_cdcidade_like ON cidade (cdcidade);
CREATE INDEX cidade_empresa_id ON cidade (empresa_id);
CREATE INDEX cidade_estado_id ON cidade(estado_id);
CREATE INDEX cidade_pais_id ON cidade (pais_id);


CREATE TABLE bairro
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  cdbairro character varying(10) NOT NULL,
  nmbairro character varying(250) NOT NULL,
  cidade_id integer NOT NULL,
  CONSTRAINT bairro_pkey PRIMARY KEY (id),
  CONSTRAINT bairro_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT cidade_id_refs_id_799ddc47 FOREIGN KEY (cidade_id)
      REFERENCES cidade (id),
  CONSTRAINT bairro_cdbairro_key UNIQUE (cdbairro)
);
CREATE INDEX bairro_cdbairro_like ON bairro(cdbairro);
CREATE INDEX bairro_cidade_id ON bairro (cidade_id);
CREATE INDEX bairro_empresa_id ON bairro (empresa_id);


CREATE TABLE cliente
(
  id integer NOT NULL AUTO_INCREMENT,
  idempresa integer not null,
  nrinscjurd character varying(20) NOT NULL,
  nmcliente character varying(250) NOT NULL,
  identificador character varying(1) NOT NULL,
  telcel character varying(15),
  telfixo character varying(15),  
  CONSTRAINT cliente_pkey PRIMARY KEY (id),
  CONSTRAINT cliente_idempresa_empresa FOREIGN KEY(idempresa) 
     REFERENCES empresa(id),
  CONSTRAINT cliente_nmcliente_key UNIQUE (nmcliente)
);
CREATE INDEX cliente_nmcliente_like ON cliente (nmcliente);
--CREATE UNIQUE INDEX cliente_telcel_key ON cliente (telcel);
--CREATE UNIQUE INDEX cliente_telfixo_key ON cliente (telfixo);

CREATE TABLE fornecedor
(
  id integer not null ,
  nrinscjurd character varying(20) NOT NULL,
  nmfornecedor character varying(250) NOT NULL,
  identificador character varying(1) NOT NULL,
  idempresa integer not null,  
  CONSTRAINT fornecedor_pkey PRIMARY KEY (id),
  CONSTRAINT fornecedor_idempresa_empresa FOREIGN KEY(idempresa) 
     REFERENCES empresa(id),  
  CONSTRAINT fornecedor_nmfornecedor_key UNIQUE (nmfornecedor)
);

CREATE INDEX fornecedor_nmfornecedor_like ON fornecedor(nmfornecedor);


CREATE TABLE endereco
(
  id integer NOT NULL AUTO_INCREMENT,
  nmrua character varying(200) NOT NULL,
  cdnumero character varying(30) NOT NULL,
  cdcep character varying(10) NOT NULL,
  empresa_id integer NOT NULL,
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
  
CREATE TABLE unidade
(
  id integer NOT NULL AUTO_INCREMENT,
  nmrazao character varying(255) NOT NULL,
  nmfantasia character varying(255) NOT NULL,
  almoxpedido_id integer not null,
  empresa_id integer not null,
  CONSTRAINT unidade_pkey PRIMARY KEY(id),
  CONSTRAINT unidade_empresa_id_fk FOREIGN KEY(empresa_id)
    REFERENCES empresa(id)
);
CREATE INDEX unidade_almoxpedido_id ON unidade(almoxpedido_id);


CREATE TABLE unimedida
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  nmmedida character varying(100) NOT NULL,
  sgmedida character varying(5) NOT NULL,
  qtfatorconv double precision NOT NULL,
  idtipomed character varying(1) NOT NULL,
  CONSTRAINT unimedida_pkey PRIMARY KEY (id),
  CONSTRAINT unimedida_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id)
);
CREATE INDEX unimedida_empresa_id ON unimedida(empresa_id);


CREATE TABLE produto
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  posarvore character varying(40),
  nmproduto character varying(200) NOT NULL,
  unimedida_id integer NOT NULL,
  cdbarra character varying(100),
  idprodvenda boolean NOT NULL,
  idadicional boolean NOT NULL,
  imgindex integer NOT NULL,
  CONSTRAINT produto_pkey PRIMARY KEY (id),
  CONSTRAINT produto_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT produto_unimedida_id_fkey FOREIGN KEY (unimedida_id)
      REFERENCES unimedida (id)
);

CREATE INDEX produto_empresa_id ON produto(empresa_id);
CREATE INDEX produto_unimedida_id ON produto(unimedida_id);


CREATE TABLE finalidade
(
  id integer NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date,
  descricao character varying(150) NOT NULL,
  CONSTRAINT finalidade_pkey PRIMARY KEY (id),
  CONSTRAINT finalidade_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id)
);

CREATE INDEX finalidade_empresa_id ON finalidade(empresa_id);

CREATE TABLE moviest
(
  id integer NOT NULL AUTO_INCREMENT,
  dtmovi date NOT NULL,
  cliente_id integer NULL,
  fornecedor_id integer NULL,
  finalidade_id integer NOT NULL,
  idtipo character varying(1) NOT NULL,
  tpmovi character varying(1) NOT NULL check(tpmovi in ('E', 'S' )),
  CONSTRAINT moviest_pkey PRIMARY KEY (id),
  CONSTRAINT smoviest_cliente_id_fkey FOREIGN KEY (cliente_id)
      REFERENCES cliente (id),
  CONSTRAINT moviest_finalidade_id_fkey FOREIGN KEY (finalidade_id)
      REFERENCES finalidade (id)      
);

CREATE INDEX moviest_cliente_id ON moviest (cliente_id);
CREATE INDEX moviest_fornecedor_id ON moviest (fornecedor_id);
CREATE INDEX moviest_finalidade_id ON moviest(finalidade_id);


CREATE TABLE lote
(
  id integer NOT NULL AUTO_INCREMENT,
  unidade_id integer,
  dtcadastro date null,
  dslote character varying(100) NOT NULL,
  dtvalidade date NOT NULL,
  dtfabricacao date NOT NULL,
  CONSTRAINT lote_pkey PRIMARY KEY (id),
  CONSTRAINT lote_unidade_id_fkey FOREIGN KEY (unidade_id)
      REFERENCES unidade(id)
);
CREATE INDEX lote_unidade_id ON lote(unidade_id);


CREATE TABLE posestoque
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer NOT NULL,
  dtcadastro date NULL,
  produto_id integer NOT NULL,
  lote_id integer,
  qtdeproduto double precision NOT NULL,
  CONSTRAINT posestoque_pkey PRIMARY KEY (id),
  CONSTRAINT lote_id_refs_id_7787491a FOREIGN KEY (lote_id)
      REFERENCES lote (id),
  CONSTRAINT posestoque_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT posestoque_produto_id_fkey FOREIGN KEY (produto_id)
      REFERENCES produto (id)
);
CREATE INDEX posestoque_empresa_id ON posestoque(empresa_id);
CREATE INDEX posestoque_lote_id ON posestoque(lote_id);
CREATE INDEX posestoque_produto_id ON posestoque(produto_id);



-- Table: "AgrupAdicional"
-- DROP TABLE "AgrupAdicional";

CREATE TABLE AgrupAdicional
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  nmagrupadic character varying(250) NOT NULL,
  vragrupadic double precision NOT NULL,
  idagrupativ character varying(1) NOT NULL,
  CONSTRAINT AgrupAdicional_pkey PRIMARY KEY (id),
  CONSTRAINT AgrupAdicional_nmagrupadic_key UNIQUE (nmagrupadic)
)
  
-- Table: categoria

-- DROP TABLE categoria;

CREATE TABLE categoria
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  nmcategoria character varying(250) NOT NULL,
  idcategoriativ character varying(1) NOT NULL,
  imgindex integer NOT NULL,
  CONSTRAINT categoria_pkey PRIMARY KEY (id),
  CONSTRAINT categoria_nmcategoria_key UNIQUE (nmcategoria)
);

CREATE INDEX categoria_nmcategoria_like ON categoria (nmcategoria);

-- Table: "ComposicaoProd"

-- DROP TABLE "ComposicaoProd";

CREATE TABLE ComposicaoProd
(
  id serial NOT NULL,
  produto_id integer NOT NULL,
  prodcomp_id integer NOT NULL,
  qtcomp double precision NOT NULL,
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




-- Table: "ItemCategoria"
-- DROP TABLE "ItemCategoria";

CREATE TABLE ItemCategoria
(
  id integer NOT NULL AUTO_INCREMENT,
  categoria_id integer NOT NULL,
  produto_id integer NOT NULL,
  vrvenda double precision NOT NULL,
  qtvenda double precision NOT NULL,
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
  unidade_id integer,
  CONSTRAINT mesa_pkey PRIMARY KEY (id),
  CONSTRAINT mesa_unidade_id_fkey FOREIGN KEY(unidade_id)
      REFERENCES unidade(ID),
  CONSTRAINT mesa_nmmesa_key UNIQUE (nmmesa)
);
CREATE INDEX mesa_nmmesa_like ON mesa (nmmesa);
CREATE INDEX mesa_unidade_id ON mesa(unidade_id);



-- Table: pedido
-- DROP TABLE pedido;

CREATE TABLE pedido
(
  id integer NOT NULL AUTO_INCREMENT,
  idtipopedido character varying(1) NOT NULL,
  cliente_id integer NULL,
  nmcliente character varying(250),
  mesa_id integer null,
  vrpedido double precision NOT NULL,
  idstatusped character varying(1) NOT NULL check(idstatusped in ('P', 'C')),
  CONSTRAINT pedido_pkey PRIMARY KEY (id),
  CONSTRAINT mesa_id_refs_id_8a44dbc3 FOREIGN KEY (mesa_id)
      REFERENCES mesa(id),
  CONSTRAINT pedido_cliente_id_fkey FOREIGN KEY (cliente_id)
      REFERENCES cliente(id)
);

CREATE INDEX pedido_cliente_id ON pedido(cliente_id);
CREATE INDEX pedido_mesa_id ON pedido(mesa_id);


-- Table: itempedido
-- DROP TABLE itempedido;

CREATE TABLE itempedido
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  empresa_id integer,
  dtcadastro date NULL,
  pedido_id integer NOT NULL,
  cardapio_id integer NOT NULL,  
  lote_id integer NULL,
  qtitem double precision NOT NULL,
  vrvenda double precision NOT NULL,
  vrtotal double precision NOT NULL,
  idadicional boolean NOT NULL,
  CONSTRAINT itempedido_pkey PRIMARY KEY (id),
  CONSTRAINT cardapio_id_refs_id_23fd3cc8 FOREIGN KEY (cardapio_id)
      REFERENCES ItemCategoria (id) ON DELETE CASCADE,
  CONSTRAINT itempedido_empresa_id_fkey FOREIGN KEY (empresa_id)
      REFERENCES empresa (id),
  CONSTRAINT itempedido_lote_id_fkey FOREIGN KEY (lote_id)
      REFERENCES lote (id),
  CONSTRAINT itempedido_pedido_id_fkey FOREIGN KEY (pedido_id)
      REFERENCES pedido (id)
);

CREATE INDEX itempedido_cardapio_id ON itempedido(cardapio_id);
CREATE INDEX itempedido_empresa_id ON itempedido(empresa_id);
CREATE INDEX itempedido_lote_id ON itempedido(lote_id);
CREATE INDEX itempedido_pedido_id ON itempedido(pedido_id);


-- Table: agrupadicional_adicionais

-- DROP TABLE agrupadicional_adicionais;

CREATE TABLE adicionais
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  agrupadicional_id integer NOT NULL,
  item_id integer NOT NULL,
  valor double precision NOT NULL,
  quantidade double precision NOT NULL,
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
  qtitem double precision NOT NULL,
  CONSTRAINT itadicional_pkey PRIMARY KEY (id),
  CONSTRAINT itadicional_itempedido_id_fkey FOREIGN KEY (itempedido_id)
      REFERENCES itempedido(id) ON DELETE CASCADE,
  CONSTRAINT item_id_refs_id_a74b663d FOREIGN KEY (item_id)
      REFERENCES Adicionais(id)
);

CREATE INDEX frentecaixa_itadicional_item_id ON itadicional(item_id);
CREATE INDEX frentecaixa_itadicional_itempedido_id ON itadicional(itempedido_id);

  
--unidade
--  produto
--  unimedida
--  finalidade
--  entrada/saida
--  fornecedor