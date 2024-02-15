/* Ejercicio 3.3 */
SELECT codpie FROM pieza WHERE ( (color='Rojo' OR color='Gris') AND (ciudad='Madrid') );

/* Ejercicio 3.4 */
SELECT * FROM ventas WHERE (cantidad BETWEEN 200 AND 300);

/* Ejercicio 3.5 */
SELECT codpie FROM pieza WHERE ( (nompie LIKE '%tornillo%') OR (nompie LIKE '%Tornillo%') );

/* Ejercicio 3.7 */
( SELECT ciudad FROM proveedor WHERE (status > 2) ) 
INTERSECT
( SELECT p1.ciudad FROM pieza p1, pieza p2 WHERE (p1.ciudad != p2.ciudad) AND (p2.codpie = 'P1') );

/* Ejercicio 3.8 */
(SELECT codpj FROM ventas WHERE (codpro = 'S1') ) 
MINUS
( SELECT codpj FROM ventas WHERE (codpro != 'S1') );

/* Ejercicio 3.9 */
(SELECT ciudad FROM proveedor) 
UNION
(SELECT ciudad FROM proyecto)
UNION
(SELECT ciudad FROM pieza);

/* Ejercicio 3.10 */
(SELECT DISTINCT ciudad FROM proveedor) 
UNION ALL
(SELECT DISTINCT ciudad FROM proyecto)
UNION ALL
(SELECT DISTINCT ciudad FROM pieza);

/* Ejercicio 3.11 */
SELECT * FROM proveedor, ventas;

/* Ejercicio 3.12 */
SELECT v.codpro, v.codpie, v.codpj, pr.ciudad
FROM proveedor pr, pieza pie, proyecto pj, ventas v
WHERE ( ( pr.codpro = v.codpro) AND (pie.codpie = v.codpie) AND (pj.codpj = v.codpj) AND (pr.ciudad = pie.ciudad) AND (pie.ciudad = pj.ciudad) );

/* Ejercicio 3.13 */
SELECT pr1.codpro, pr1.nompro, pr2.codpro, pr2.nompro
FROM proveedor pr1, proveedor pr2
WHERE ( (pr1.codpro < pr2.codpro) AND (pr1.ciudad != pr2.ciudad) );

/* Ejercicio 3.14 */
(SELECT codpie FROM pieza)
MINUS
( SELECT pie1.codpie
FROM pieza pie1, pieza pie2
WHERE ( (pie1.peso < pie2.peso) ) );

/* Ejercicio 3.15 */
SELECT codpie FROM ventas 
NATURAL JOIN
(SELECT * FROM proveedor WHERE ciudad = 'Madrid');

/* Ejercicio 3.16 */
SELECT DISTINCT pie.ciudad, pie.codpie
FROM proveedor pr, pieza pie, proyecto pj, ventas v
WHERE ( (pr.codpro = v.codpro) AND (pj.codpj = v.codpj) AND (pie.codpie = v.codpie) AND (pr.ciudad = pj.ciudad) );

/* Ejercicio 3.17 */
-- Sin el order by nos salen los nombres tal y como los hemos introducidos en la tabla
-- Si el orden es importante, tenemos que poner el order by

/* Ejercicio 3.18 */
SELECT *
FROM ventas
ORDER BY cantidad, fecha DESC;

/* Ejercicio 3.19 */
SELECT codpie
FROM ventas
WHERE codpro IN 
(SELECT codpro FROM proveedor WHERE ciudad = 'Madrid');

/* Ejercicio 3.20 */
SELECT codpj 
FROM proyecto 
WHERE ciudad IN 
(SELECT ciudad FROM pieza);

-- Sin el IN
SELECT codpj 
FROM proyecto 
WHERE ciudad = ANY(SELECT ciudad FROM pieza);

/* Ejercicio 3.21 */
SELECT DISTINCT codpj
FROM ventas
WHERE codpj NOT IN (
    SELECT codpj 
    FROM ventas 
    WHERE codpro IN ( 
        SELECT codpro 
        FROM proveedor 
        WHERE ciudad = 'Londres') 
    AND codpie IN (
        SELECT codpie 
        FROM pieza 
        WHERE color = 'Rojo')
);

/* Ejercicio 3.22 */
-- Aqui no hay que meter DISTINCT porque estamos proyectando la clave única
SELECT codpie
FROM pieza
WHERE peso > ANY
(SELECT peso FROM pieza WHERE nompie = 'Tornillo');

-- SIN SUBCONSULTAS
-- Aquí si hay que meter el distinct porque si hubiera más de una pieza tornillo se repetiría
SELECT DISTINCT pie1.codpie
FROM pieza pie1, pieza pie2
WHERE (pie1.peso > pie2.peso AND pie2.nompie = 'Tornillo');

/* Ejercicio 3.23 */
SELECT codpie
FROM pieza
WHERE peso >= ALL
(SELECT peso FROM pieza);

/* Ejercicio 3.24 */
select codpie
from pieza where not exists (select * from proyecto where ciudad = 'Londres' and not exists(select * from ventas where pieza.codpie = ventas.codpie and proyecto.codpj = ventas.condpj));

/* Ejercicio 3.25 */
select codpro from proveedor where not exists( (select ciudad from proyecto) minus (select ciudad from (pieza natural join ventas) where codpro = proveedor.codpro) ); 


/* Ejercicio 3.26 */
select count(*) from ventas where (cantidad>1000);

/* Ejercicio 3.27 */
select max(peso) from pieza;

/* Ejercicio 3.28 */
select codpie from pieza where peso = (select max(peso) from pieza);
-- Cuando hagamos una igualdad con una subconsulta, tenemos que asegurarnos que dicha subconsulta solo va a devolver una tupla en cualquier caso

/* Ejercicio 3.29 */
-- La consulta "select codpie, max(peso) from pieza;" no resuelve el ejercicio anterior porque 

/* Ejercicio 3.30 */
select codpro from proveedor where 3 < (select count(*) from ventas where ventas.codpro = proveedor.codpro);
--otra opcion select codpro from ventas group by codpro having count(*)>3

/* Ejercicio 3.31 */
select nompie, avg(cantidad) from ventas natural join (select codpie, nompie from pieza) group by codpie, nompie;
-- Al hacer un group bye, en el select solo se pueden poner funciones de agrupamiento o los campos que están en el group by

/* Ejercicio 3.32 */
select codpro, avg(cantidad) from ventas where codpie='P1' group by codpro;

/* Ejercicio 3.33 */
select codpj, codpie, SUM(cantidad) from ventas group by codpie, codpj ORDER BY codpj, codpie;

/* Ejercicio 3.35 */
select nompro from proveedor natural join (select codpro from ventas group by codpro having sum(cantidad) >= 1000);

/* Ejercicio 3.36 */
select codpie from ventas group by codpie having SUM(cantidad) = (select MAX(SUM(v.cantidad)) from ventas v group by v.codpie);

/* Ejercicio 3.38 */
select to_char(fecha, 'MM/YYYY'), avg(cantidad) from ventas group by to_char(fecha, 'MM/YYYY');

/* Ejercicio 3.42 */
select codpro from ventas group by codpro having sum(cantidad) > (select sum(cantidad) from ventas where codpro='S1' group by codpro);

/* Ejercicio 3.43 */
select codpro from ventas group by codpro having sum(cantidad) >= 

/* Ejercicio 3.44 */
select codpro from proveedor p where codpro != 'S3' and not exists(
    (select ciudad from ventas natural join proyecto where codpro='S3')
    minus
    (select ciudad from ventas natural join proyecto where codpro = p.codpro)
);

/* Ejercicio 3.45 */
select codpro, count(*) from ventas group by codpro having count(*) >= 10;

/* Ejercicio 3.46 */
select codpro from proveedor where not exists(
    select codpie from ventas where codpro = 'S1'
    minus
    select codpie from ventas where ventas.codpro = proveedor.codpro
);

/* Ejercicio 3.47 */
select codpro, sum(cantidad) from ventas v where not exists(
    select codpie from ventas where codpro = 'S1'
    minus
    select codpie from ventas where ventas.codpro = v.codpro
)
group by v.codpro;

/* Ejercicio 3.48 */
select codpj from proyecto where not exists (
    select distinct codpro from ventas where codpie='P3'
    minus
    select distinct codpro from ventas where codpie='P3' AND codpj = proyecto.codpj
);

/* Ejercicio 3.49 */
select codpro, avg(cantidad) from ventas natural join (select distinct codpro from ventas where codpie='P3') group by codpro;

/* Ejercicio 3.52 */
select codpro, to_char(fecha, 'YYYY'), avg(cantidad) from ventas group by codpro, to_char(fecha, 'YYYY') order by codpro, to_char(fecha, 'YYYY');

/* Ejercicio 3.53 */
select distinct codpro from ventas natural join (select codpie from pieza where color='Rojo');

/* Ejercicio 3.54 */
select codpro from proveedor where not exists(
    select codpie from pieza where color='Rojo'
    minus
    select codpie from ventas where proveedor.codpro = ventas.codpro
);

/* Ejercicio 3.55 */
select distinct codpro from ventas
minus
select distinct codpro from ventas where codpie IN (select codpie from pieza where color!='Rojo')

/* Ejercicio 3.56 */
select nompro from proveedor where codpro in(
    select distinct codpro from ventas where codpie IN (select codpie from pieza where color='Rojo') group by codpro having count(*) > 1
);

/* Ejercicio 3.57 */
select distinct codpro from ventas where codpro in (
    select codpro from proveedor where not exists(
        select codpie from pieza where color='Rojo'
        minus
        select codpie from ventas where proveedor.codpro = ventas.codpro
    )

) AND codpro in (
    select codpro from proveedor where not exists(
        select cantidad from ventas
        minus
        select cantidad from ventas where (cantidad > 10) and (proveedor.codpro = ventas.codpro)
    )
);

/* Ejercicio 3.58 */
UPDATE proveedor
SET status = 1
where codpro in(
    select distinct codpro from ventas
    minus
    select distinct codpro from ventas where codpie != 'P1'
);

/* Ejercicio 3.59 */
select ciudad from pieza where codpie NOT IN (
    select distinct codpie from ventas where TO_CHAR(fecha, 'MM/YYYY')='09/2009'
) AND codpie IN (
    select codpie from ventas where TO_CHAR(fecha, 'MM/YYYY')='08/2009' group by codpie having sum(cantidad) >= (select MAX(SUM(cantidad)) from ventas where TO_CHAR(fecha, 'MM/YYYY')='08/2009' group by codpie)
);



/* EJERCICIOS ADICIONALES */

/* Ejercicio 1 */
select codpro from ventas
where codpie = 'P1' and to_char(fecha,'YYYY')='2021'
group by codpro 
having count(*) >= (select max(count(*)) from ventas where codpie = 'P1' and to_char(fecha,'YYYY')='2021' group by codpro);

/* Ejercicio 2 */
select distinct codpie from ventas where codpie in (select codpie from pieza where color='Blanco') group by codpie having count(distinct codpro) >= 3;

/* Ejercicio 3 */
select distinct codpj, avg(cantidad) from ventas where to_char(fecha,'YYYY')='2000' group by codpj having avg(cantidad) > 150;

/* Ejercicio 4 */
select codpro from ventas where codpj in (select codpj from proyecto where ciudad = 'Londres') and to_char(fecha,'MM/YYYY')='01/2000'
group by codpro having count(*) >= (select max(count(*)) from ventas where codpj in (select codpj from proyecto where ciudad = 'Londres') and to_char(fecha,'MM/YYYY')='01/2000' group by codpro);

/* Ejercicio 5 */
select codpro from proveedor where not exists(
    select codpj from proyecto
    minus
    select codpj from ventas group by codpro, codpj having count(*) >= 3
);

/* Ejercicio 6 */
select codpie from ventas where to_char(fecha,'YYYY')='2010' group by codpie having count(*) = 1;

/* Ejercicio 7 */
select codpie from ventas group by codpie having max(to_char(fecha, 'MM/YYYY'))='03/2010';

/* Ejercicio 8 */
select codpj from ventas where codpro in (select codpro from proveedor where ciudad='Londres') group by codpj having count(*) = 3;

/* Ejercicio 9 */
select codpj from ventas where to_char(fecha,'YYYY')='2021' group by codpj having count(distinct codpro)=1 and count(*) > 1;

/* Ejercicio 10 */
select codpie from pieza where color='Rojo' and not exists(
    select to_char(fecha,'YYYY') from ventas
    minus
    select to_char(fecha,'YYYY') from ventas where ventas.codpie = pieza.codpie group by codpie, to_char(fecha,'YYYY') having count(*) >= 2
);