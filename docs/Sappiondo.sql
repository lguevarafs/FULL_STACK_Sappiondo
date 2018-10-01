-- Sappiondo
-- Base de de datos de registro y transacciones
-- Subir digrama y diccionario, subir doc interacion cliente servidor


CREATE SEQUENCE seq_dominiotipodoc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE sap_dominiotipodoc (
    dtd_id             integer DEFAULT nextval('seq_dominiotipodoc') NOT NULL,                 
    dtdl_descripcion   character varying(1527),    
    dtd_personas       boolean default true,    
    dtd_estado         boolean default true,    
    CONSTRAINT sap_dominiotipodoc_key PRIMARY KEY (dtd_id)
);

COMMENT ON TABLE sap_dominiotipodoc  IS 'Tabla que almacena los tipos de documentos de identificacion exsitentes ';
COMMENT ON COLUMN sap_dominiotipodoc.dtd_id IS 'La llave primaria de la tabla se vincula con la secuencia seq_dominiotipodoc';
COMMENT ON COLUMN sap_dominiotipodoc.dtdl_descripcion IS 'Rigistra el tipo de documento';
COMMENT ON COLUMN sap_dominiotipodoc.dtd_personas IS 'Indica si el registro es persona  so true o Empresa si false';
COMMENT ON COLUMN sap_dominiotipodoc.dtd_estado IS 'Indica si el registro esta activo o no';

insert into sap_dominiotipodoc(dtdl_descripcion) values ('Cedula de ciudadania');
insert into sap_dominiotipodoc(dtdl_descripcion) values ('Targeta de Identidad');
insert into sap_dominiotipodoc(dtdl_descripcion) values ('Registro civil');	
insert into sap_dominiotipodoc(dtdl_descripcion) values ('Pasaporte');		
insert into sap_dominiotipodoc(dtdl_descripcion) values ('Cedula de extrangeria');			
insert into sap_dominiotipodoc(dtdl_descripcion,dtd_personas) values ('NIT',false);
insert into sap_dominiotipodoc(dtdl_descripcion,dtd_personas) values ('RUT',false);	


CREATE SEQUENCE seq_dominiorol
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE sap_dominiorol (
    drol_id             integer DEFAULT nextval('seq_dominiorol') NOT NULL,                 
    drol_descripcion    character varying(1527),    
    drol_estado         boolean default true,    
    CONSTRAINT sap_dominiorol_canal_key PRIMARY KEY (drol_id)
);

COMMENT ON TABLE sap_dominiorol  IS 'Tabla que almacena los roles exsitentes en la solucion';
COMMENT ON COLUMN sap_dominiorol.drol_id IS 'La llave primaria de la tabla se vincula con la secuencia seq_dominiorol';
COMMENT ON COLUMN sap_dominiorol.drol_descripcion IS 'Rigistra la informacion del rol';
COMMENT ON COLUMN sap_dominiorol.drol_estado IS 'Indica si el registro esta activo o no';

insert into sap_dominiorol(drol_descripcion) values ('Ciudadano');
insert into sap_dominiorol(drol_descripcion) values ('Administrador Sistema');
insert into sap_dominiorol(drol_descripcion) values ('Administrador Academia');	
insert into sap_dominiorol(drol_descripcion) values ('Academico');		
insert into sap_dominiorol(drol_descripcion) values ('Profesional');
insert into sap_dominiorol(drol_descripcion) values ('Tecnologo');	
insert into sap_dominiorol(drol_descripcion) values ('Tecnico');	
					


CREATE SEQUENCE seq_dominioacademia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE sap_dominioacademia (
    daca_id                integer DEFAULT nextval('seq_dominioacademia') NOT NULL,                 
    daca_descripcion       character varying(1527),    
    fdaca_tipoid       integer  NOT NULL REFERENCES sap_dominiotipodoc(dtd_id),
    daca_numeroid       character varying(1527) UNIQUE,  
    daca_informacionadd    JSON,    
    daca_estado             boolean default true,    
    CONSTRAINT sap_dominioacademia_key PRIMARY KEY (daca_id)
);

COMMENT ON TABLE sap_dominioacademia  IS 'Tabla que almacena las academias como colegios, instituciones tecnicas y institunciones profesionales';
COMMENT ON COLUMN sap_dominioacademia.daca_id IS 'La llave primaria de la tabla se vincula con la secuencia sap_dominioacademia';
COMMENT ON COLUMN sap_dominioacademia.daca_descripcion IS 'Rigistra la informacion de la institucion';
COMMENT ON COLUMN sap_dominioacademia.fdaca_tipoid IS 'Rigistra la informacion de tipo de documento de la institunciones';
COMMENT ON COLUMN sap_dominioacademia.daca_numeroid IS 'Rigistra la informacion del numero de documento de la institunciones';
COMMENT ON COLUMN sap_dominioacademia.daca_informacionadd IS 'Rigistra la informacion del complementaria de la institucion';
COMMENT ON COLUMN sap_dominioacademia.daca_estado IS 'Indica si el registro esta activo o no';

insert into sap_dominioacademia(daca_descripcion,daca_informacionadd,fdaca_tipoid,daca_numeroid) values ('Fundacion Universitaria Konrad Lorens','{ "Dirrecion": "Cra. 9 Bis #62-43", "Carreras": {"product": "Ingeneria de Sistemas","Psicologia"}}',6,'860504759');
insert into sap_dominioacademia(daca_descripcion,daca_informacionadd,fdaca_tipoid,daca_numeroid) values ('SENA','{ "Dirrecion": "Cl. 57 #8 - 69", "Carreras": {"product": "Tecnicos","Tecnologos"}}',6,'899999034');	

CREATE SEQUENCE seq_gestionusuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE sap_gestionusuario (
    gesu_id                integer DEFAULT nextval('seq_gestionusuario') NOT NULL,                 
    gesu_nombres           character varying(527),    
    gesu_apellidos         character varying(527), 
    gesu_correo            character varying(527) UNIQUE,     
    fgesu_tipoid           integer  NOT NULL REFERENCES sap_dominiotipodoc(dtd_id),
    gesu_numeroid          character varying(1527) UNIQUE,  
    gesu_informacionadd    JSON,    
    gesu_estado            boolean default true,    
    CONSTRAINT sap_gestionusuario_key PRIMARY KEY (gesu_id)
);

COMMENT ON TABLE sap_gestionusuario  IS 'Tabla que almacena las personas que se registran en el sistema para consultar o responder';
COMMENT ON COLUMN sap_gestionusuario.gesu_id IS 'La llave primaria de la tabla se vincula con la secuencia seq_gestionusuario';
COMMENT ON COLUMN sap_gestionusuario.gesu_nombres IS 'Rigistra  los nombres de la persona';
COMMENT ON COLUMN sap_gestionusuario.gesu_apellidos IS 'Rigistra  los apellidos de la persona';
COMMENT ON COLUMN sap_gestionusuario.gesu_correo IS 'Rigistra  el correo electronico  de la persona es unico y el usuario de inicio de secion';
COMMENT ON COLUMN sap_dominioacademia.daca_informacionadd IS 'Rigistra la informacion del complementaria de la institucion';
COMMENT ON COLUMN sap_gestionusuario.daca_estado IS 'Indica si el registro esta activo o no';

insert into sap_gestionusuario(gesu_nombres,gesu_apellidos,gesu_correo,fgesu_tipoid,gesu_numeroid,gesu_informacionadd) values ('Luis Carlos','Guevara Villalobos','lguevarafs@gmail.com',1,'79649056','{ "Dirrecion": "Cll. n  #a-b", "gustos": {"profesion": "Ingeneria de Sistemas"}}');


CREATE SEQUENCE seq_usuarioacademiarol
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE sap_usuarioacademiarol (
    uar_id             integer DEFAULT nextval('seq_usuarioacademiarol') NOT NULL,    
    fuar_rol           integer  NOT NULL deafult 1 REFERENCES sap_dominiorol(dtd_id),             
    fuar_academia      integer deafult 0,
    fgesu_id           integer  NOT NULL  REFERENCES sap_gestionusuario(gesu_id),             
    uar_observacion    character varying(1527),        
    uar_estado         boolean default true,    
    CONSTRAINT sap_usuarioacademiarol_key PRIMARY KEY (uar_id)
);

COMMENT ON TABLE sap_usuarioacademiarol  IS 'Tabla que vincula los usuarios a un rol y a una acedemia ';
COMMENT ON COLUMN sap_usuarioacademiarol.uar_id IS 'La llave primaria de la tabla se vincula con la secuencia seq_usuarioacademiarol';
COMMENT ON COLUMN sap_usuarioacademiarol.fuar_rol IS 'La llave foranea a la tabla sap_dominiorol, es obligatoria';
COMMENT ON COLUMN sap_usuarioacademiarol.fuar_academia IS 'La llave foranea a la tabla sap_dominioacademia, no es obligatoria';
COMMENT ON COLUMN sap_usuarioacademiarol.fgesu_id IS 'La llave foranea a la tabla sap_gestionusuario, es obligatoria';
COMMENT ON COLUMN sap_usuarioacademiarol.uar_observacion IS 'Rigistra una observacion de la asignacion la mimima es ciudadano';
COMMENT ON COLUMN sap_usuarioacademiarol.uar_estado IS 'Indica si el registro esta activo o no';



CREATE SEQUENCE seq_cuestionaminetos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE sap_cuestionaminetos (
    cus_id                integer DEFAULT nextval('seq_cuestionaminetos') NOT NULL,                 
    fcus_id_pregunta      integer  NOT NULL  REFERENCES sap_gestionusuario(gesu_id), 
    fcus_id_respuesta     integer  
    cus_pregunta          character varying(3527),    
    cus_respuestas        JSON,    
    cus_estado           boolean default true,    
    CONSTRAINT sap_cuestionaminetos_key PRIMARY KEY (cus_id)
);

COMMENT ON TABLE sap_cuestionaminetos  IS 'Tabla que almacena las preguntas realizadas a  los  acadamicos';
COMMENT ON COLUMN sap_cuestionaminetos.cus_id IS 'La llave primaria de la tabla se vincula con la secuencia seq_cuestionaminetos';
COMMENT ON COLUMN sap_cuestionaminetos.fcus_id_pregunta IS 'La llave foranea a la tabla sap_gestionusuario quien realizo la pregunta, es obligatoria';
COMMENT ON COLUMN sap_cuestionaminetos.fcus_id_respuesta IS 'La llave foranea a la tabla sap_gestionusuario quien a criterio de quien pregunto fue mas asertado en su respuesta, noes obligatorio';
COMMENT ON COLUMN sap_cuestionaminetos.cus_pregunta IS 'Rigistra  el enunciado de la pregunta';
COMMENT ON COLUMN sap_cuestionaminetos.cus_respuestas IS 'Rigistra  todas las respuesta dadas en un json';
COMMENT ON COLUMN sap_cuestionaminetos.cus_estado IS 'Indica si el registro esta activo o no';

CREATE SEQUENCE seq_baselexica
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE sap_baselexica (
    bal_id                integer DEFAULT nextval('seq_baselexica') NOT NULL,                 
    fbal_id_preedesor     integer default 0, 
    bal_componenteidioma  character varying(350),    
    bal_estado           boolean default true,    
    CONSTRAINT sap_baselexica_key PRIMARY KEY (cus_id)
);

