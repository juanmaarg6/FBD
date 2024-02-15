CREATE TABLE equipos (
	codE CHAR(3) CONSTRAINT codE_clave_primaria PRIMARY KEY,
	nombreE VARCHAR2(10) CONSTRAINT nombreE_no_nulo NOT NULL CONSTRAINT nombreE_unico UNIQUE,
	localidad VARCHAR2(15) CONSTRAINT localidad_no_nulo NOT NULL,
	entrenador VARCHAR2(30) CONSTRAINT entrenador_no_nulo NOT NULL,
	fecha_crea DATE CONSTRAINT fecha_crea_no_nulo NOT NULL
);