-- Database: pizza

-- DROP DATABASE pizza;

CREATE DATABASE pizza
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Table: public.pizza

-- DROP TABLE public.pizza;

create sequence pizza_piz_id_seq
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

CREATE TABLE public.pizza
(
    piz_id integer NOT NULL DEFAULT nextval('pizza_piz_id_seq'::regclass),
    piz_name text COLLATE pg_catalog."default",
    piz_origin text COLLATE pg_catalog."default",
    piz_state boolean,
    CONSTRAINT pizza_pkey PRIMARY KEY (piz_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.pizza
    OWNER to postgres;

-- Table: public.ingredients

-- DROP TABLE public.ingredients;

create sequence ingredients_ing_id_seq
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;



CREATE TABLE public.ingredients
(
    ing_id integer NOT NULL DEFAULT nextval('ingredients_ing_id_seq'::regclass),
    ing_name text COLLATE pg_catalog."default",
    ing_calories text COLLATE pg_catalog."default",
    ing_state boolean,
    CONSTRAINT ingredients_pkey PRIMARY KEY (ing_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ingredients
    OWNER to postgres;
	
-- Table: public.pizza_ingredient

-- DROP TABLE public.pizza_ingredient;

create sequence pizza_ingredient_piz_ing_id_seq
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

CREATE TABLE public.pizza_ingredient
(
    piz_ing_id integer NOT NULL DEFAULT nextval('pizza_ingredient_piz_ing_id_seq'::regclass),
    piz_id integer,
    ing_id integer,
    piz_ing_state boolean,
    CONSTRAINT pizza_ingredient_pkey PRIMARY KEY (piz_ing_id),
    CONSTRAINT fk_piz_ing_ing_id FOREIGN KEY (ing_id)
        REFERENCES public.ingredients (ing_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_piz_ing_piz_id FOREIGN KEY (piz_id)
        REFERENCES public.pizza (piz_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.pizza_ingredient
    OWNER to postgres;

INSERT INTO public.pizza(piz_name, piz_origin, piz_state) 
VALUES ('Pizza Hawaiana', 'Hawai', true);
INSERT INTO public.pizza(piz_name, piz_origin, piz_state) 
VALUES ('Pizza Pepperoni', 'Italia', true);
INSERT INTO public.pizza(piz_name, piz_origin, piz_state) 
VALUES ('Pizza Vegetariana', 'USA', true);
INSERT INTO public.pizza(piz_name, piz_origin, piz_state) 
VALUES ('Pizza Pollo', 'UTN', true);
INSERT INTO public.pizza(piz_name, piz_origin, piz_state) 
VALUES ('Pizza Napolitana', 'Italia', true);

INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Queso', '20cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Cebolla', '10cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Pollo', '75cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Piña', '15cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Harina', '30cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Jamón', '40cal', true);
INSERT INTO public.ingredients(ing_name, ing_calories, ing_state)
VALUES ('Oregano', '10cal', true);

INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (1, 1, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (1, 4, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (1, 5, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (2, 1, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (2, 2, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (2, 5, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (2, 6, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (2, 7, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (3, 1, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (3, 2, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (3, 5, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (4, 2, true);
INSERT INTO public.pizza_ingredient(piz_id, ing_id, piz_ing_state)
VALUES (4, 5, true);

--------------------CONSULTAS---------------------
------consulta pizza con sus ingreientes-----------
select p.piz_name, p.piz_origin, i.ing_name, i.ing_calories 
from pizza p, ingredients i, pizza_ingredient pi
where p.piz_id=pi.piz_id and i.ing_id=pi.ing_id and pi.piz_ing_state=true;
-----consultar las pizzas que tienen mas de 2 ingredientes---------
select p.piz_name,count(i.ing_id) as "ingredientes"
from pizza p, ingredients i, pizza_ingredient pi
where p.piz_id=pi.piz_id and i.ing_id=pi.ing_id and pi.piz_ing_state=true
group by p.piz_id HAVING count(i.ing_id)>2 order by 2;

