CREATE TABLE encuentros (
	ELocal CHAR(3) CONSTRAINT ELocal_clave_ext_equipos REFERENCES equipos(codE),
	EVisitante CHAR(3) CONSTRAINT EVisitante_clave_ext_equipos REFERENCES equipos(codE),
	fecha DATE,
	PLocal INT DEFAULT 0 CONSTRAINT PLocal_positivo CHECK(PLocal >= 0),
	PVisitante INT DEFAULT 0 CONSTRAINT PVisitante_positivo CHECK(PVisitante >= 0),
	
	CONSTRAINT clave_primaria_encuentros PRIMARY KEY (ELocal, EVisitante)
	
);