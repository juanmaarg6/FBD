CREATE TABLE faltas (
	codJ CHAR(3) CONSTRAINT codJ_clave_ext_jugadores REFERENCES jugadores(codJ),
	ELocal CHAR(3),
	EVisitante CHAR(3),
	num INT DEFAULT 0 CONSTRAINT num_entre_0_y_5 CHECK(num >= 0 AND num <= 5),
	
	CONSTRAINT clave_primaria_faltas PRIMARY KEY (codJ, ELocal, EVisitante),
	CONSTRAINT ELocal_EVisit_claves_exts FOREIGN KEY (ELocal, EVisitante) REFERENCES encuentros(ELocal, EVisitante)
);