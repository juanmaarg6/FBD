CREATE TABLE jugadores (
	codJ CHAR(3) CONSTRAINT codJ_clave_primaria PRIMARY KEY,
	codE CHAR(3) CONSTRAINT codE_no_nulo NOT NULL CONSTRAINT codE_clave_ext_equipos REFERENCES equipos(codE),
	nombreJ VARCHAR2(30) CONSTRAINT nombreJ_no_nulo NOT NULL
);