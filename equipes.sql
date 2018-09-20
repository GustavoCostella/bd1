/*Comandos em psql
psql -U postgres -h localhost -d postgres
\c nome_banco conecta no banco
\d mostra as tabels do nome_banco
\d nome_tabela mostra a tabela especifica
insert into nome_tabela (lista de colunas separadas por virgula) value (valores)
select * from nome_tabela mostra os valores da tabela
id serial constraint... para criar id automatico
alter table (altera o nome da tabela)
ADD constraint nome PRIMARY KEY()
alter column nome_col SET NOT NULL||DROP NOT NULL
Sempre criar um usuario e um banco
create user ______ password ' ';
\c nome_banco nome_user*/
/*  insert into competicao (sigla,datai,dataf,titulo) values ('TIMEA','16/09/18','17/09/18','copa fifa');
insert into profissional (matricula,dataNasc,nome) values (1711100028,'20/08/1999','Bruno Karling');
insert into equipe (codigo,nome,matricula) values (101,'Coringao',1711100028);
insert into jogo (data,codigoLocal,codigoVisi,hora) values ('17/09/2018',101,102,'15:20');
insert into plantel (matricula,codigo,dataAD,dataDES) values (171100028,101,'05/08/2007','06/09/2018'); */
/*begin (começa)
end; (termina)
rollback; (volta )
no caso de seleção de valores usar between*/


create table competicao(
  sigla varchar(4) not null constraint pk_competicao PRIMARY KEY,
  dtin date not null,
  dtfim date not null,
  titulo varchar(20) not null
);

create table profissional(
  matricula integer not null constraint pk_profissional PRIMARY KEY,
  dtNasc date not null,
  nome varchar(30) not null

);

create table equipe(
  cod integer not null,
  nome varchar(20) not null,
  matricula integer not null,

  constraint pk_equipe PRIMARY KEY (cod,nome),
  constraint fk_equipe_profissional FOREIGN KEY (matricula) references profissional(matricula)
);

create table jogo(
  data date not null,
  cdloc integer not null,
  cdvis integer not null,
  ptloc integer,
  ptvis integer,
  hora time not null,


  constraint pk_jogo PRIMARY KEY (data,cdloc,cdvis),
  constraint fk_equipe_local FOREIGN KEY (cdloc) references equipe (cod),
  constraint fk_equipe_visi  FOREIGN KEY (cdvis) references equipe (cod)

);

create table plantel(
  dtADM date not null,
  dtDESL date,
  codigo integer not null,
  mat integer not null,

  constraint fk_plantel_mat FOREIGN KEY (mat) references profissional(matricula),
  constraint fk_plantel_codigo FOREIGN KEY (codigo) references equipe (cod)

);
create table participa (
  sigla varchar(5) not null,
  codigo integer not null,


  constraint fk_participa_sigla FOREIGN KEY (sigla) references competicao(sigla),
  constraint fk_participa_codigo FOREIGN KEY (codigo) references equipe (cod),
  constraint pk_participa PRIMARY KEY (sigla, codigo)

);

create table treina(
  mat integer not null,
  eqnome varchar(20) not null,

  constraint fk_treina_mat FOREIGN KEY (mat) references profissional(matricula),
  constraint fk_treina_eqnome FOREIGN KEY (eqnome) references equipe(nome),
  constraint pk_treina PRIMARY KEY (mat,eqnome)

);
