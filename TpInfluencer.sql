CREATE SCHEMA IF NOT EXISTS Recetario_Influencer;

USE Recetario_Influencer;

CREATE TABLE Comida (
	id int primary key auto_increment,
	id_tipo_comida int not null references tipo_comida(id) 
);

INSERT INTO Comida (id_tipo_comida) values (1), (2), (3), (1), (2);

CREATE TABLE Comensal (
	id int primary key auto_increment,
	edad int not null  
);

INSERT INTO Comensal (edad) values (21), (7) , (22), (28);

CREATE TABLE Comensal_come_comida( 
	id int primary key auto_increment,
	id_comida int not null references comida(id),
	codigo_comensal int not null references comensal(codigo),
	cantidad int not null
);

INSERT INTO Comensal_come_comida (id_comida, codigo_comensal, cantidad ) values ( 1, 1, 2), (2, 2, 3), (3, 3, 2), (2, 4, 3); 

CREATE TABLE Tipo_comida(
	id int primary key auto_increment, 
	descripcion varchar(40) not null
);

INSERT INTO Tipo_comida (descripcion) values ('Desayuno'), ('Almuerzo'), ('Merienda'), ('Cena');

CREATE TABLE menu(
	id int primary key auto_increment,
	fecha_desde date ,
	fecha_hasta date,
	id_frecuencia int references frecuencia(id)
);

INSERT INTO menu (fecha_desde, fecha_hasta, id_frecuencia) values ('2022-02-12', '2022-02-19', 1), ('2022-02-20', '2022-02-27' , 1), ('2022-02-28', '2022-03-15', 2);
INSERT INTO menu(fecha_desde, fecha_hasta, id_frecuencia) values('2022-11-01', '2022-11-15', 2) ,('2022-09-25', '2022-10-25', 3);
INSERT INTO menu (fecha_desde, fecha_hasta, id_frecuencia) values ('2022-10-19','2022-11-19', 1), ('2022-10-25', '2022-11-25' , 1), ('2022-11-01', '2022-11-15', 2);

Alter table menu add column fuePreparado boolean default false;

Update menu set fuePreparado = true where id= 2;

CREATE TABLE menu_contiene_comida(
	id int primary key auto_increment,
	id_menu int references menu(id),
	id_comida int references comida(id)
);
Alter table menu_contiene_comida add column cantidad int null;

INSERT INTO menu_contiene_comida (id_menu, id_comida ) values ( 1, 4), ( 2, 3), (2, 3);
INSERT INTO menu_contiene_comida (id_menu, id_comida ) values ( 2, 2), ( 3, 2), (1, 1);

update menu_contiene_comida set cantidad = 3  where menu_contiene_comida.id=1  or menu_contiene_comida.id=2 or  menu_contiene_comida.id=3; 
update menu_contiene_comida set cantidad = 5  where menu_contiene_comida.id=4  or menu_contiene_comida.id=5 or  menu_contiene_comida.id=6; 
update menu_contiene_comida set cantidad = 7  where menu_contiene_comida.id=7  or menu_contiene_comida.id=8 or  menu_contiene_comida.id=9; 
select * from menu_contiene_comida;

CREATE TABLE lista_compras(
	codigo int primary key auto_increment, 
	id_menu int not null references menu(id) ,
	cantidad int
);
Alter table lista_compras add column fecha date not null; 

INSERT INTO lista_compras (id_menu, cantidad) values (1, 1);

CREATE TABLE despensa( 
	id int primary key auto_increment, 
	descripcion varchar(40)
);

INSERT INTO despensa (descripcion) values ('Heladera'), ('Despensa en cocina');

CREATE TABLE frecuencia( 
	id int primary key auto_increment, 
	descripcion varchar(40) 
);

INSERT INTO frecuencia (descripcion) values ('Semanal'), ('Quincenal'), ('Mensual');

CREATE TABLE ia(
	codigo int primary key auto_increment, 
	url varchar(60), 
	nombre varchar(40), 
	algoritmo_principal varchar(40) not null
);

INSERT INTO ia(url, nombre, algoritmo_principal) values ('www.inteligencia-a.com', 'ia', 'Algoritmo-1');

CREATE TABLE influencer (
	id int primary key auto_increment,
	cuenta varchar(40) not null, 
	nombre varchar(40), 
	ranking int
);

INSERT INTO influencer (cuenta, nombre, ranking) values ('@recetasrapidas', 'recetas rapidas', 1  ), ('@soyvegano', 'vegani', 2);


CREATE TABLE Red_social (
	id int primary key auto_increment,
	nombre varchar(40) not null
);

INSERT INTO Red_social (nombre) values ('Instagram'), ('TikTok'), ('YouTube');

CREATE TABLE Influencer_pertenece_red_social (
	id int primary key auto_increment,
	id_influencer int not null references Influencer(id) ,
	id_red_social int not null references Red_social (id)
);

INSERT INTO Influencer_pertenece_red_social (id_influencer, id_red_social) values (1, 1), (2,2), (1,3);

CREATE TABLE publicacion (
	id int primary key auto_increment, 
	descipcion varchar(40), 
	contador_likes int ,
	id_influencer int not null references influencer(id), 
	codigo_ia int not null references ia(codigo), 
	id_Tipo_Fuente int not null references Fuente(id)
);
Alter table publicacion change descipcion descripcion varchar(40) null;
INSERT INTO publicacion (descripcion, id_influencer, codigo_ia, contador_likes, id_tipo_fuente ) values ('Seguime para mas recetas', 1, 1, 20, 2 ), ('La mejor receta', 2, 1, 400,1);

CREATE TABLE Tipo_Fuente (
	id int primary key auto_increment, 
	nombre varchar(40) 
);

INSERT INTO Tipo_fuente (nombre) values ('Video'), ('Reel'), ('Foto');

CREATE TABLE receta(
	id int primary key auto_increment, 
	tiempo time , 
	porcion int, 
	comentario varchar(100), 
	datos varchar(40), 
	preparada boolean, 
	favorito boolean, 
	id_nivel int not null references nivel(id),
	id_preparacion int not null references preparacion(id), 
	id_tipo_coccion int not null references tipo_coccion(id), 
	id_tipo_receta int not null references tipo_receta(id), 
	id_fuente int references receta(id)
);

alter table  receta change id_fuente id_publicacion int;
alter table receta drop column preparada; 
alter table receta drop column favorito;
alter table receta drop column fecha_extraccion ; 

INSERT INTO receta (tiempo, porcion, preparada, favorito, id_nivel, id_preparacion, id_tipo_coccion, id_tipo_receta ) values ('01:00:00', 1, true, true, 1, 1, 1, 1), ('1:30:00', 2, false, false, 2, 2, 2, 2);

CREATE TABLE Tipo_Coccion (
	id int primary key auto_increment,
	descripcion varchar(40) 
);

INSERT INTO Tipo_coccion (descripcion) values ('HORNO'), ('MICROONDAS');

CREATE TABLE Tipo_De_Receta (
	id int primary key auto_increment,
	descripcion varchar(40) 
);

INSERT INTO Tipo_de_receta (descripcion) values ('VEGANA'), ('SIN TACC'), ('OMNIVORA');

CREATE TABLE Nivel (
	id int primary key auto_increment,
	descripcion varchar (40)
);

INSERT INTO Nivel (descripcion) values ('FACIL'), ('INTERMEDIO'), ('AVANZADO');

CREATE TABLE Preparacion (
	id int primary key auto_increment ,
	video varchar(70)
);

INSERT INTO Preparacion (video) values ('www.urlvideo.com' ), ('www.video-video.com');

CREATE TABLE Paso (
	numero int primary key auto_increment,
	accion varchar(40) not null
);

INSERT INTO Paso (accion ) values ('batir los huevos'), ('cortar cebolla');
/*
PREGUNTAR SI ES DEBIL DE PREPARACION
*/

CREATE TABLE Ingrediente (
	id int primary key auto_increment,
	id_pais_origen int references Pais(id),
	nombre varchar(40),
	precio double not null,
	foto varchar(70),
	nombre_comercial varchar(40),
	cantidad_despensa int,
	id_marca int references Marca(id),
	id_despensa int references Despensa(id),
	id_Ingrediente int references Ingrediente(id)
);

INSERT INTO Ingrediente (id_pais_origen, nombre, precio, nombre_comercial, cantidad_despensa, id_marca, id_despensa, id_Ingrediente) 
values (1, 'mayonesa', 400.5, 'gran salsa', 3, 1, 1, 2), (2, 'mayonesa', 300.0, 'danica-nombre-producto', 1, 1, 1,1)  ; 

INSERT INTO Ingrediente (id_pais_origen, nombre, precio, nombre_comercial, cantidad_despensa, id_marca, id_despensa, id_Ingrediente) 
values (2,"producto1", 250.5, "nombreComercialProducto1", 9, 1,1,2), (2,"producto2", 550.5, "nombreComercialProducto2", 9, 1,1,1); 

CREATE TABLE Pais (
	id int primary key auto_increment ,
	nombre varchar(40) not null
);

INSERT INTO Pais (nombre) values ('ARGENTINA') , ('BRASIL'), ('ITALIA');


CREATE TABLE Ingrediente_tiene_Nutriente (
	id int primary key auto_increment,
	cantidad int,
	id_nutriente int not null references Nutriente(id),
	id_ingrediente int not null references Ingrediente(id)
);

INSERT INTO Ingrediente_tiene_nutriente (cantidad, id_nutriente, id_ingrediente) values (2,1,1), ( 2, 3, 2);

CREATE TABLE Marca (
	id int primary key  auto_increment,
	descripcion varchar(40) 
);

INSERT INTO Marca (descripcion) values ('HELLMANS'), ('DANICA'), ('LOS HERMANOS');

CREATE TABLE Comida_es_conjunto_receta (
	id int primary key auto_increment,
	id_comida int references Comida(id),
	id_receta int references Receta(id),
	cantidad int
);

INSERT INTO Comida_es_conjunto_receta (id_comida, id_receta, cantidad) values ( 2, 2, 2);
INSERT INTO Comida_es_conjunto_receta (id_comida, id_receta, cantidad) values ( 2, 1, 9),(1,1,3),(1,2,1);

alter table Comida_es_conjunto_receta add column preparada boolean default false;


CREATE TABLE Receta_Es_Opcion_Menu(
	id int primary key auto_increment,
	id_Menu int not null references Menu_id,
	id_Receta int references Receta_id,
	cantidad int not null
	
);

INSERT INTO Receta_es_opcion_menu (id_menu, id_receta, cantidad) values (2, 1 , 2);

CREATE TABLE Receta_Tiene_Ingrediente(
	id int primary key auto_increment,
	id_receta int references receta_id,
	id_Ingrediente int references ingrediente_id,
	cantidad int not null
);

INSERT INTO Receta_tiene_ingrediente (id_receta, id_ingrediente, cantidad) values (2, 2, 1);
select * from receta;
INSERT INTO Receta_tiene_ingrediente (id_receta, id_ingrediente, cantidad) values (1, 3, 3);
INSERT INTO Receta_tiene_ingrediente (id_receta, id_ingrediente, cantidad) values (1, 4, 1);
INSERT INTO Receta_tiene_ingrediente (id_receta, id_ingrediente, cantidad) values (2, 4, 1);

CREATE TABLE Preparacion_Interviene_Paso_Ingrediente(
	id_preparacion int references  preparacion_id,
	numero_paso int references  paso_numero ,  
	id_ingrediente int references ingrediente_id,
	cantidad_ingredientes int not null,
	constraint  pkTernaria primary key(id_preparacion, numero_paso, id_ingrediente)

);

INSERT INTO Preparacion_Interviene_Paso_Ingrediente(id_preparacion, numero_paso, id_ingrediente, cantidad_ingredientes) values (1,1, 1, 1);

CREATE TABLE Lista_compras_incluye_Ingrediente(
	id int auto_increment primary key,
	id_ingrediente int references ingrediente_id,
	codigo_lista_compras int references lista_compras_codigo,
	comprado_o_no boolean
);
Alter Table Lista_compras_incluye_Ingrediente change comprado_o_no comprado_o_no boolean default false;

INSERT INTO Lista_compras_incluye_Ingrediente(id_ingrediente,codigo_lista_compras,comprado_o_no) values (1,2,false);
Insert into Lista_compras_incluye_ingrediente(id_ingrediente, codigo_lista_compras)values (2,1);
select * From lista_compras_incluye_Ingrediente;

-- Consultas

-- i. ¿Cuáles son mis listas de compras activas? 
select lc.codigo
from lista_compras lc where exists 
                                    (select 1 from lista_compras_incluye_ingrediente lcii 
                                    where lc.codigo = lcii.codigo_lista_compras and lcii.comprado_o_no=false);
-- ii. El historial de los menúes que fui armando.
Select m.id, m.fecha_desde, m.fecha_hasta 
From menu m 
where m.fuePreparado = true 
order by m.fecha_desde, m.fecha_hasta; 
-- iii. Mis recetas favoritas, es decir, las que más elijo.
/*select r.datos,  r.id
from receta r
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id 
join comida c on c.id = ccr.id_comida
join menu_contiene_comida mcc on mcc.id_comida = c.id
join menu m on m.id = mcc.id_menu
where m.fuePreparado=true
and r.id in (select cantidadMarcaFavorita.idMarcaFavorita
                    from  (select max(cantidadMaxima.total), cantidadMaxima.idMarca as idMarcaFavorita
                                    from  (select count(r.id) as total, r.id as idReceta
                                            from comida_es_conjunto_receta
                                            group by i.id_marca) as cantidadMaxima) as cantidadMarcaFavorita)
group by r.id;
*/

select r.*
from receta r
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id
where exists (select 1
                from comida c join menu_contiene_comida mcc on mcc.id_comida= c.id
                join menu m on m.id=mcc.id_menu
                where c.id=ccr.id_comida
                and m.fuePreparado=true)
group by ccr.id_receta
HAVING sum(ccr.id_receta)=(select max(cantidadMaxima.total)
                                    from (select count(ccr.id_receta) as total
                                            from comida_es_conjunto_receta ccr
                                            group by ccr.id_receta) as cantidadMaxima);                                            
                                            
-- iv. Reporte de ingredientes por tipo de comida del último mes.
Select tc.descripcion, i.nombre, i.nombre_comercial,i.precio,m.id as IDMenu, m.fecha_hasta
From ingrediente i 
join receta_tiene_ingrediente rti on rti.id_Ingrediente = i.id
join receta r on r.id=rti.id_receta
join comida_es_conjunto_receta comrec on comrec.id_receta = r.id
join comida c on c.id = comrec.id_comida
join tipo_comida tc on tc.id = c.id_tipo_comida
join menu_contiene_comida on menu_contiene_comida.id_comida = c.id
join menu m on m.id = menu_contiene_comida.id_menu
where m.fecha_desde between '2021-01-01' and '2022-12-31'
group by tc.descripcion;


-- v. Reporte de costo por menú del mes en curso, con la posibilidad de ingresar el factor inflacionario
-- para poder conocer el presupuesto para el mes que viene.
select m.id, avg((i.precio*rti.cantidad)*ccr.cantidad)  as costo
from menu m join menu_contiene_comida mcc on mcc.id_menu = m.id
join comida com on com.id = mcc.id_comida
join comida_es_conjunto_receta ccr on ccr.id_comida = com.id
join receta r on r.id = ccr.id_receta
join receta_tiene_ingrediente rti on rti.id_receta = r.id
join ingrediente i on i.id = rti.id_ingrediente
where exists ( select 1 from menu m join menu_contiene_comida mcc on mcc.id_comida = m.id 
					where m.id = mcc.id_comida and month(m.fecha_desde)=month(curdate()) and year(m.fecha_desde) = year(curdate()))
                    or exists  ( select 1 from menu m join menu_contiene_comida mcc on mcc.id_comida = m.id 
					where m.id = mcc.id_comida and month(m.fecha_hasta)=month(curdate()) and year(m.fecha_hasta) = year(curdate()))
group by m.id;


-- vi. Conocer mis marcas favoritas, es decir, las que más compro.

select m.descripcion
from marca m join ingrediente i on m.id=i.id_marca
where exists (select 1
            from lista_compras_incluye_ingrediente lcii
            where i.id = lcii.id
            and lcii.comprado_o_no=true)
group by m.id, m.descripcion
having count(i.id_marca) = (select max(cantidadMaxima.total)
                                    from  (select count(i.id_marca) as total
                                            from ingrediente i
                                            group by i.id_marca) as cantidadMaxima);


              
-- vii. ¿En qué lapso del año (mes, semana, período de tiempo) preparé todas las recetas de algún influencer?
	
select i.nombre, datediff(max(m.fecha_hasta), min(m.fecha_desde)) as lapsotiempo
from receta r join publicacion p on p.id = r.id_publicacion
join influencer i on i.id= p.id_influencer
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id
join comida c on c.id = ccr.id_comida
join menu_contiene_comida mcc on mcc.id_comida = c.id
join menu m on m.id = mcc.id_menu
where not exists (select 1
					from comida_es_conjunto_receta ccr2 where ccr2.preparada = false
                    and ccr2.id=ccr.id_receta);
 




-- viii. ¿Cuáles son las recetas más utilizadas en los menúes del último año?
select r.id ,sum(mcc.cantidad*ccr.cantidad) as cantidad
from receta r 
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id 
join comida c on c.id = ccr.id_comida
join menu_contiene_comida mcc on mcc.id_comida = c.id
join menu m on m.id = mcc.id_menu
where year(m.fecha_desde) = '2022'
group by r.id
order by cantidad desc;

select r.id
from receta r
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id
join comida c on c.id= ccr.id_comida
join menu_contiene_comida mcc on mcc.id_comida= c.id
join menu m on m.id=mcc.id_menu
and r.id in (select cantidadRecetaFavorita.idReceta
                    from (select max(cantidadMaxima.total),cantidadMaxima.idReceta
                                    from (select count(ccr.id_receta) as total, ccr.id_receta as idReceta
                                            from comida_es_conjunto_receta ccr
                                            where year(m.fecha_desde) = '2022'
                                            group by ccr.id_receta) as cantidadMaxima) as cantidadRecetaFavorita)
group by r.id;

-- ix. ¿Cuántas comidas por semana preparo en promedio?
select cantidadComidas.total/cantidad_de_semanas.total 
from (select count(mcc.id_comida) as total
        from menu_contiene_comida mcc) as cantidadComidas,
        (select datediff(curdate(),min(m.fecha_desde))/7 as total
                        from menu m)  as cantidad_de_semanas;

                        

-- x. ¿Cuál es el costo por comensal en promedio, en un mes?
select c.id, avg((i.precio*rti.cantidad)*ccr.cantidad) as costo
from comensal c join comensal_come_comida ccc on ccc.codigo_comensal
join comida com on com.id = ccc.id_comida
join comida_es_conjunto_receta ccr on ccr.id_comida = com.id
join receta r on r.id = ccr.id_receta
join receta_tiene_ingrediente rti on rti.id_receta = r.id
join ingrediente i on i.id = rti.id_ingrediente
where exists ( select 1 from menu m join menu_contiene_comida mcc on mcc.id_comida = m.id 
					where c.id = mcc.id_comida and month(m.fecha_desde) between curdate() and date_sub(curdate(), interval 30 day))
                    or exists  ( select 1 from menu m join menu_contiene_comida mcc on mcc.id_comida = m.id 
					where c.id = mcc.id_comida and month(m.fecha_hasta) between curdate() and date_sub(curdate(), interval 30 day))
group by c.id;







/*
select com.id, 
from ingrediente i 
join receta_tiene_ingrediente rti on rti.id_Ingrediente = i.id
join receta r on r.id = rti.id_receta
join comida_es_conjunto_receta ccr on ccr.id_receta = r.id
join comida c on c.id = ccr.id_comida
join menu_contiene_comida mcc on mcc.id_comida = c.id
join menu m on m.id = mcc.id_menu
join comensal_come_comida ccc on ccc.id_comida = c.id
join comensal com on com.id = ccc.codigo_comensal
group by com.id, promedio
having month(m.fecha_hasta) = 10;
*/

