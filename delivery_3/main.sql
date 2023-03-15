/*  Trabalho realizado pelo grupo 40  */
/*  99286 99300 99330 */
DROP VIEW IF EXISTS Vendas;
DROP TABLE IF EXISTS evento_reposicao;
DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS IVM;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria (
    nome                    VARCHAR(50)                 NOT NULL UNIQUE,
    PRIMARY KEY(nome));

CREATE TABLE categoria_simples (
    nome                    VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome)
        REFERENCES categoria(nome));

CREATE TABLE super_categoria (
    nome                    VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome)
        REFERENCES categoria(nome));

CREATE TABLE tem_outra (
    super_categoria         VARCHAR(50)                 NOT NULL,
    categoria               VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(categoria),
    FOREIGN KEY(super_categoria)
        REFERENCES categoria(nome),
    FOREIGN KEY(categoria)
        REFERENCES categoria(nome)
    CHECK(super_categoria != categoria));

CREATE TABLE produto (
    ean                     INTEGER                     NOT NULL UNIQUE,
    cat                     VARCHAR(50)                 NOT NULL,
    descr                   VARCHAR(100),
    PRIMARY KEY(ean),
    FOREIGN KEY(cat)
        REFERENCES categoria(nome));

CREATE TABLE tem_categoria (
    ean                     INTEGER                     NOT NULL,       
    nome                    VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(ean, nome),
    FOREIGN KEY(ean)
        REFERENCES produto(ean),
    FOREIGN KEY(nome)
        REFERENCES categoria(nome));

CREATE TABLE IVM (
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(num_serie, fabricante));

CREATE TABLE ponto_de_retalho (
    nome                    VARCHAR(50)                 NOT NULL,
    distrito                VARCHAR(50)                 NOT NULL,
    concelho                VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(nome));

CREATE TABLE instalada_em (
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    local_                  VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante)
        REFERENCES IVM(num_serie, fabricante),
    FOREIGN KEY(local_)
        REFERENCES ponto_de_retalho(nome));

CREATE TABLE prateleira (
    nro                     INTEGER                     NOT NULL,
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    altura                  INTEGER                     NOT NULL,
    nome                    VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante)
        REFERENCES IVM(num_serie, fabricante),
    FOREIGN KEY(nome)
        REFERENCES categoria(nome));

CREATE TABLE planograma (
    ean                     INTEGER                     NOT NULL,
    nro                     INTEGER                     NOT NULL,
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    faces                   INTEGER                     NOT NULL,
    unidades                INTEGER                     NOT NULL,
    loc                     VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(ean, nro, num_serie, fabricante),
    FOREIGN KEY(ean)
        REFERENCES produto(ean),
    FOREIGN KEY(nro, num_serie, fabricante)
        REFERENCES prateleira(nro, num_serie, fabricante));

CREATE TABLE retalhista (
    tin                     INTEGER                     NOT NULL UNIQUE,
    name_                   VARCHAR(50)                 NOT NULL UNIQUE,    /* RI-RE7 unique(name)*/
    PRIMARY KEY(tin));

CREATE TABLE responsavel_por (
    nome_cat                VARCHAR(50)                 NOT NULL,
    tin                     INTEGER                     NOT NULL,
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante)
        REFERENCES IVM(num_serie, fabricante),
    FOREIGN KEY(tin)
        REFERENCES retalhista(tin),
    FOREIGN KEY(nome_cat)
        REFERENCES categoria(nome));

CREATE TABLE evento_reposicao (
    ean                     INTEGER                     NOT NULL,
    nro                     INTEGER                     NOT NULL,
    num_serie               INTEGER                     NOT NULL,
    fabricante              VARCHAR(50)                 NOT NULL,
    instante                TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    unidades                INTEGER                     NOT NULL,
    tin                     INTEGER                     NOT NULL,
    PRIMARY KEY(ean, nro, num_serie, fabricante, instante),
    FOREIGN KEY(ean, nro, num_serie, fabricante)
        REFERENCES planograma(ean, nro, num_serie, fabricante),
    FOREIGN KEY(tin)
        REFERENCES retalhista(tin));

