select 'drop table ', table_name, 'cascade constraints;' from user_tables;
drop table 	TRAINER_SPEC_PROGRAMARE	cascade constraints;
drop table 	TRAINER_SPECIALIZARE	cascade constraints;
drop table 	TRAINERI	cascade constraints;
drop table 	TIP_ABONAMENT	cascade constraints;
drop table 	SPECIALIZARE_SALA	cascade constraints;
drop table 	SPECIALIZARE	cascade constraints;
drop table 	SALA	cascade constraints;
drop table 	INFORMATII_PROGRAMARE_CLASA	cascade constraints;
drop table 	INFORMATII_ABONAMENT_CLIENT	cascade constraints;
drop table 	CLIENT_PROGRAMARE	cascade constraints;
drop table 	CLIENTI	cascade constraints;
SET SERVEROUTPUT ON

create table clienti
(
id_client number(20) constraint pk_abonati primary key,
nume varchar2(20) not null,
prenume varchar2(20) not null,
data_nasterii date not null,
adresa varchar2(30),
id_abonament number(20) not null
);

create table tip_abonament
(
id_tip_abonament number(20) constraint pk_tip_abonament primary key,
nume_abonament varchar2(20) not null,
pret number(20) not null,
descriere varchar2(200) not null
);

create table informatii_abonament_client
(
id_abonament number(20) constraint pk_informatii_abonament_client primary key,
id_tip_abonament number(20) constraint fk_tip_abonament references tip_abonament(id_tip_abonament),
data_inceput date not null,
data_sfarsit date not null
);


ALTER TABLE clienti
ADD FOREIGN KEY(id_abonament) REFERENCES informatii_abonament_client(id_abonament);

create table traineri
(
id_trainer number(20) constraint pk_traineri primary key,
nume varchar2(20) not null,
prenume varchar2(20) not null,
specializari varchar2(20) not null
);

create table specializare
(
id_specializare number(20) constraint pk_specializare primary key,
nume_specializare varchar2(20) not null,
descriere varchar2(200)
);

create table trainer_specializare
(
id_trainer_specializare number(20) constraint pk_trainer_specializare primary key,
id_trainer number(20) constraint fk_traineri references traineri(id_trainer),
id_specializare number(20) constraint fk_specializare references specializare(id_specializare)
);

create table sala
(
id_sala number(20) constraint pk_sala primary key,
dimensiune number(20) not null
);

create table informatii_programare_clasa
(
id_programare_clasa number(20) constraint pk_informatii_programare_clasa primary key,
id_specializare number(20) constraint fk_specializare_programare references specializare(id_specializare),
id_sala number(20) constraint fk_sala_programare references sala(id_sala),
data_zi date not null,
ora_inceput date not null,
ora_sfarsit date not null
);

create table client_programare
(
id_client_programare number(20) constraint pk_client_programare primary key,
id_client number(20) constraint fk_client references clienti(id_client),
id_programare_clasa number(20) constraint fk_programare_clasa references informatii_programare_clasa(id_programare_clasa)
);

create table trainer_spec_programare
(
id_trainer_spec_programare number(20) constraint pk_trainer_spec_programare primary key,
id_trainer_specializare number(20) constraint fk_trainer_specializare references trainer_specializare(id_trainer_specializare),
id_programare_clasa number(20) constraint fk_informatii_programare_clasa references informatii_programare_clasa(id_programare_clasa)
);
-- identifier too long error

create table specializare_sala
(
id_specializare_sala number(20) constraint pk_specializare_sala primary key,
id_specializare number(20) constraint fk_specializare_many references specializare(id_specializare),
id_sala number(20) constraint fk_sala_many references sala(id_sala)
);

alter table traineri
drop column specializari;

-- inserturi

insert into tip_abonament(id_tip_abonament,nume_abonament,pret, descriere)
values(1,'Day time',120,'acces zilnic pana la ora 16');

insert into tip_abonament(id_tip_abonament,nume_abonament,pret, descriere)
values(2,'Full time',200,'acces la orice ora');

insert into tip_abonament(id_tip_abonament,nume_abonament,pret, descriere)
values(3,'Full time',220,'acces la orice ora');

insert into informatii_abonament_client(id_abonament, id_tip_abonament, data_inceput, data_sfarsit)
values(1,1,to_date('13/01/2020','dd/mm/yyyy'),to_date('12/02/2020','dd/mm/yyyy'));

insert into informatii_abonament_client(id_abonament, id_tip_abonament, data_inceput, data_sfarsit)
values(2,2,to_date('16/03/2020','dd/mm/yyyy'),to_date('15/04/2020','dd/mm/yyyy'));

insert into informatii_abonament_client(id_abonament, id_tip_abonament, data_inceput, data_sfarsit)
values(3,3,to_date('16/03/2020','dd/mm/yyyy'),to_date('15/04/2020','dd/mm/yyyy'));

insert into informatii_abonament_client(id_abonament, id_tip_abonament, data_inceput, data_sfarsit)
values(4,3,to_date('16/03/2020','dd/mm/yyyy'),to_date('15/06/2020','dd/mm/yyyy'));

insert into clienti(id_client,nume,prenume,data_nasterii,adresa,id_abonament)
values(1,'Cristian','Dinca',to_date('03/11/2001', 'DD/MM/YYYY'),'str mihail moxa 2',2);

insert into clienti(id_client,nume,prenume,data_nasterii,adresa,id_abonament)
values(2,'Alexandru','Ioan',to_date('09/03/1999', 'DD/MM/YYYY'),'str mihail moxa 11',1);

insert into clienti(id_client,nume,prenume,data_nasterii,adresa,id_abonament)
values(3,'Costel','Ioan',to_date('19/05/1999', 'DD/MM/YYYY'),'str alexandru cel bun 10',1);

insert into clienti(id_client,nume,prenume,data_nasterii,adresa,id_abonament)
values(4,'Vasilian','Ion',to_date('20/11/1999', 'DD/MM/YYYY'),'str alexandru cel bun 7',1);

insert into clienti(id_client,nume,prenume,data_nasterii,adresa,id_abonament)
values(5,'Cristian','Cornel',to_date('03/12/2005', 'DD/MM/YYYY'),'str mihail moxa 2',3);

insert into specializare(id_specializare, nume_specializare, descriere)
values(1,'antrenor personal','ajutor pentru atingerea obiectivelor sportive personale');

insert into specializare(id_specializare, nume_specializare, descriere)
values(2,'yoga','Practica yoga are ca scop flexibilitatea corpul, linistirea mintii si recapatarea starii de bine in intregul corp');

insert into specializare(id_specializare, nume_specializare, descriere)
values(3,'cardio','Este o specializare ce presupune exercitii ce stimuleaza frecventa cardiaca, fiind suficient de antrenanta');

insert into traineri(id_trainer, nume, prenume)
values(1,'Chiriac','Vlad');

insert into traineri(id_trainer, nume, prenume)
values(2,'Marinescu','Oana');

insert into traineri(id_trainer, nume, prenume)
values(3,'Cristian','Ionita');

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(1,1,1);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(2,1,2);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(3,1,3);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(4,2,1);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(5,3,1);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(6,3,3);

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(7,2,3);

insert into sala(id_sala, dimensiune)
values(1,40);

insert into sala(id_sala, dimensiune)
values(2,70);

insert into specializare_sala(id_specializare_sala,id_sala,id_specializare)
values(1,1,2);

insert into specializare_sala(id_specializare_sala,id_sala,id_specializare)
values(2,1,3);

insert into specializare_sala(id_specializare_sala,id_sala,id_specializare)
values(3,2,3);

insert into informatii_programare_clasa(id_programare_clasa, id_specializare, id_sala, data_zi, ora_inceput, ora_sfarsit)
values(1,3,1,to_date('18/03/2020', 'DD/MM/YYYY'),to_date('15:30', 'HH24:MI'),to_date('17:30', 'HH24:MI'));

insert into informatii_programare_clasa(id_programare_clasa, id_specializare, id_sala, data_zi, ora_inceput, ora_sfarsit)
values(2,3,2,to_date('18/03/2020', 'DD/MM/YYYY'),to_date('16:20', 'HH24:MI'),to_date('17:45', 'HH24:MI'));

insert into trainer_spec_programare(id_trainer_spec_programare,id_trainer_specializare,id_programare_clasa)
values(1,3,1);

insert into trainer_spec_programare(id_trainer_spec_programare,id_trainer_specializare,id_programare_clasa)
values(2,7,1);

insert into trainer_spec_programare(id_trainer_spec_programare,id_trainer_specializare,id_programare_clasa)
values(3,6,2);

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(1,1,1);

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(2,2,1);

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(3,4,1);

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(4,3,2);


--1.	Reduceti abonamentul cu 10% clientilor nascuti in luna ?decembrie?
update tip_abonament
set pret=pret-0.1*pret
where (select t.id_tip_abonament from clienti c, informatii_abonament_client i, tip_abonament t
    where t.id_tip_abonament=i.id_tip_abonament and c.id_abonament=i.id_abonament and extract(month from c.data_nasterii)=12)=tip_abonament.id_tip_abonament;
-- 2.	Reduceti cu 10 locuri dimensiunea salilor care au specializarea ?yoga?
update sala
set dimensiune =dimensiune -10
where dimensiune>10 and 
(select s.id_sala from specializare_sala s, sala, specializare sp where s.id_sala=sala.id_sala and s.id_specializare=sp.id_specializare and sp.nume_specializare='yoga')=sala.id_sala;

--3.	Mutati pe 3 decembrie 2020 programarile de clasa unde participa mai mult de 2 clienti

update informatii_programare_clasa
set data_zi=to_date('03/12/2020', 'dd/mm/yyyy')
where (select i.id_programare_clasa from client_programare c, informatii_programare_clasa i 
    where c.id_programare_clasa=i.id_programare_clasa
    group by i.id_programare_clasa
    having count(c.id_client)>=2)=informatii_programare_clasa.id_programare_clasa;

--4.	Modificati prenumele trainer-ului cu id-ul 2 in ?Cristian?
update traineri
set prenume='Cristian'
where id_trainer=2;

--5.	Modificati adresa clientilor care au numele ?Cristian? si care sunt nascuti dupa anul 2002 in "SUA"
update clienti
set adresa='SUA'
where extract(year from data_nasterii)>2002 and nume='Cristian';


-- 5 opera?ii de interogare a datelor utiliz?nd jonc?iuni ?i func?ii scalare diverse

-- jonctiune pentru a calcula numarul de traineri de la fiecare programare
SELECT ipc.id_programare_clasa, COUNT(tsp.id_trainer_specializare) as "numar traineri", ipc.id_sala, ipc.data_zi, ipc.ora_inceput, ipc.ora_sfarsit
FROM informatii_programare_clasa ipc
join trainer_spec_programare tsp ON ipc.id_programare_clasa = tsp.id_programare_clasa
GROUP BY ipc.id_programare_clasa, ipc.id_sala, ipc.data_zi, ipc.ora_inceput, ipc.ora_sfarsit;  
-- jonctiune pentru a vedea fiecare trainer si descrierea specializarilor lui
SELECT t.id_trainer,
       CONCAT(s.nume_specializare, s.descriere)
FROM trainer_specializare t
JOIN specializare s ON t.id_specializare = s.id_specializare;
 
-- jonctiune pentru a vedea datele despre sala in cazul programarilor de clase din luna decembrie
select *
from informatii_programare_clasa i, sala s
where i.id_sala=s.id_sala and extract(month from i.data_zi)=12;



-- 1.Se afiseaza informatii despre clientul cu ID-ul dat
dbms_output.enable(buffer_size IN INTEGER DEFAULT 20000);
exec dbms_output.enable(1000000);

SET SERVEROUTPUT ON
DECLARE
    client_id clienti.id_client%TYPE :='&id' ;
    client_nume clienti.nume%TYPE;
    client_prenume clienti.prenume%TYPE;
    abonament_nume tip_abonament.nume_abonament%TYPE;
    abonament_descriere tip_abonament.descriere%TYPE;
BEGIN
    SELECT nume, prenume INTO client_nume, client_prenume FROM clienti WHERE id_client = client_id;
    IF SQL%FOUND=TRUE THEN
        DBMS_OUTPUT.PUT_LINE('Nume client: ' || client_nume || ' ' || client_prenume);
        SELECT nume_abonament, descriere INTO abonament_nume, abonament_descriere 
            FROM tip_abonament JOIN informatii_abonament_client ON 
            tip_abonament.id_tip_abonament = informatii_abonament_client.id_tip_abonament 
            WHERE id_abonament = (SELECT id_abonament FROM clienti WHERE id_client = client_id);
    DBMS_OUTPUT.PUT_LINE('Tip abonament: ' || abonament_nume);
    DBMS_OUTPUT.PUT_LINE('Descriere abonament: ' || abonament_descriere);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista clientul cu id ' || client_id);
    END IF;
END;
/

-- 2. Sa se afiseze numele si descrierea tuturor tipurilor de abonamente
DECLARE
    v_nume_abonament tip_abonament.nume_abonament%TYPE;
    v_descriere tip_abonament.descriere%TYPE;
    v_pret tip_abonament.pret%TYPE;
BEGIN
    FOR i IN (SELECT nume_abonament, descriere, pret FROM tip_abonament)
    LOOP
        v_nume_abonament := i.nume_abonament;
        v_descriere := i.descriere;
        v_pret := i.pret;
        DBMS_OUTPUT.PUT_LINE('Tip abonament: ' || v_nume_abonament || ' - Descriere: ' ||
                v_descriere || ' - Pret: ' || v_pret);
    END LOOP;
END;
/

-- 3. Afiseaza numele si specializarea tuturor trainerilor
DECLARE
  CURSOR c_traineri IS
    SELECT t.nume, s.nume_specializare
    FROM traineri t
    JOIN trainer_specializare ts ON t.id_trainer = ts.id_trainer
    JOIN specializare s ON ts.id_specializare = s.id_specializare;
BEGIN
  FOR trainer IN c_traineri LOOP
    DBMS_OUTPUT.PUT_LINE('Nume: ' || trainer.nume || ', Specializare: ' || trainer.nume_specializare);
  END LOOP;
END;
/



-- 4. Afiseaza clientii majori
DECLARE
  CURSOR majori IS 
      SELECT id_client, nume, prenume, data_nasterii, adresa
      FROM clienti
      WHERE months_between(sysdate, data_nasterii)/12 >= 18;
BEGIN
    FOR i IN majori
    LOOP
        DBMS_OUTPUT.PUT_LINE('Client: ' || i.id_client || ' ' || i.nume|| ' '|| i.prenume
        || ' ' || i.data_nasterii || ' ' || i.adresa);
    END LOOP;
END;
/

-- 5. Modifica adresa clientului cu ID=1 si afiseaza numarul de modificari efectuate
DECLARE
   v_num_rows_updated INTEGER;
BEGIN
   UPDATE clienti
   SET adresa = '&adresa'
   WHERE id_client = 1;
   
   v_num_rows_updated := SQL%ROWCOUNT;
   
   DBMS_OUTPUT.PUT_LINE('Numarul de randuri actualizate: ' || v_num_rows_updated);
END;
/

select 'drop table ', table_name, 'cascade constraints;' from user_tables;

----- 1.Bloc PL/SQL pentru actualizarea numelui unui client in tabela clienti
DECLARE
    v_id_client NUMBER := &id;
    verificare_id NUMBER;
    v_nume VARCHAR2(20) := '&nume_update';
BEGIN
    SELECT id_client INTO verificare_id FROM CLIENTI WHERE v_id_client= clienti.id_client;
    UPDATE clienti SET nume = v_nume WHERE id_client = v_id_client;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Id-ul clientului nu exista!');
END;
/

--2. bloc pl/sql care sa afiseze primii 3 cei mai batrani clienti, si daca nu exista sa se scrie o exceptie personalizata
DECLARE
    CURSOR c_clienti IS
        SELECT id_client, nume, prenume, data_nasterii
        FROM clienti
        ORDER BY data_nasterii DESC
        FETCH FIRST 3 ROWS ONLY;
    
    v_id_client clienti.id_client%TYPE;
    v_nume clienti.nume%TYPE;
    v_prenume clienti.prenume%TYPE;
    v_data_nasterii clienti.data_nasterii%TYPE;
    v_count INTEGER:=0;
    clienti_insuficienti EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_count FROM clienti; -- numara numarul de clienti

    IF v_count < 3 THEN -- verifica daca exista mai putin de 3 clienti
        RAISE clienti_insuficienti;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Primii 3 cei mai batrani clienti:');
  
    FOR r_clienti IN c_clienti LOOP
        v_id_client := r_clienti.id_client;
        v_nume := r_clienti.nume;
        v_prenume := r_clienti.prenume;
        v_data_nasterii := r_clienti.data_nasterii;
    
        DBMS_OUTPUT.PUT_LINE(v_nume || ' ' || v_prenume || ' - Data nasterii: ' || v_data_nasterii);
    END LOOP;
EXCEPTION
    WHEN clienti_insuficienti THEN DBMS_OUTPUT.PUT_LINE('Clienti insuficienti!');
END;
/

-- 3. doar specializarile existente in tabela "specializare" pot fi atribuite unui trainer:
DECLARE
    trainer_specializare_exception EXCEPTION;
    cheie_duplicata EXCEPTION;
    ---00001 CODUL ERORII PT ACEASTA EXCEPTIE
    v_verif NUMBER;
    PRAGMA EXCEPTION_INIT(cheie_duplicata,-00001);
BEGIN
    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (1, 1, 1);

    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (2, 2, 3);

    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (3, 3, 4);

    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (4, 4, 2);

    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (5, 5, 5);
    
    --INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    --VALUES (5, 5, 5);
    SELECT id_specializare into v_verif from specializare s where s.id_specializare=200;
    INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
    VALUES (8, 4, 200);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Specializarea nu exista in tabela "specializare"');
    WHEN cheie_duplicata THEN
    DBMS_OUTPUT.PUT_LINE('Cheie duplicata');
END;
/

DECLARE
    trainer_specializare_exception EXCEPTION;
    cheie_duplicata EXCEPTION;
    ---00001 CODUL ERORII PT ACEASTA EXCEPTIE
    v_verif NUMBER;
    v_id_trainer_specializare trainer_specializare.id_trainer_specializare%TYPE;
    v_id_trainer trainer_specializare.id_trainer%TYPE;
    v_id_specializare trainer_specializare.id_specializare%TYPE;
    PRAGMA EXCEPTION_INIT(cheie_duplicata,-00001);
BEGIN
   
    FOR i IN 1..&num_values LOOP
        v_id_trainer_specializare := &id_trainer_specializare;
        v_id_trainer := &id_trainer;
        v_id_specializare := &id_specializare;
        
        BEGIN
            SELECT id_specializare INTO v_verif FROM specializare s WHERE s.id_specializare = v_id_specializare;
            INSERT INTO trainer_specializare (id_trainer_specializare, id_trainer, id_specializare)
            VALUES (v_id_trainer_specializare, v_id_trainer, v_id_specializare);
            
            DBMS_OUTPUT.PUT_LINE('Row inserted successfully.');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Specializarea nu exista in tabela "specializare"');
            WHEN cheie_duplicata THEN
                DBMS_OUTPUT.PUT_LINE('Cheie duplicata');
        END;
    END LOOP;
    
    COMMIT; 
END;
/


-- 4 Intr-un bloc PL/SQL utilizati un cursor parametrizat pentru a prelua numele si adresa clientilor al caror abonament este dat ca parametru.
SET SERVEROUTPUT ON

DECLARE
    CURSOR client_cursor (p_id_abonament IN NUMBER) IS
        SELECT c.nume, c.adresa
        FROM clienti c
        WHERE c.id_abonament = p_id_abonament;
    
    v_nume clienti.nume%TYPE;
    v_adresa clienti.adresa%TYPE;
    id_abonament_cautat number:=&id_abonament_cautat;
    verif number;
BEGIN
    SELECT id_tip_abonament into verif from tip_abonament a where id_abonament_cautat = a.id_tip_abonament;
    FOR client_c IN client_cursor(id_abonament_cautat) LOOP
        v_nume := client_c.nume;
        v_adresa := client_c.adresa;

        DBMS_OUTPUT.PUT_LINE('Nume: ' || v_nume || ', Adresa: ' || v_adresa);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NU EXISTA ID ABONAMENT CAUTAT');
END;
/


-- Utiliz?nd schema BD de la proiect (cel din semestrul 1, care va fi continuat ?n acest semestru), construi?i cel pu?in:

--3 proceduri
--3 func?ii
--(+ apelurile aferente)
--Not?: se puncteaz? complexitatea subprogramelor create; acestea ar trebui s? includ? simultan c?t mai multe dintre
--mecanismele ?nv??ate: structuri de control, cursori, excep?ii, tipuri de date compuse... 

-- 1. afisarea informatiilor despre tot clientii care au abonamente incheiate intr-un anumit interval de timp
CREATE OR REPLACE PROCEDURE afisare_clienti_abonamente 
(data_start IN DATE, data_end IN DATE)
AS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM clienti c
    JOIN informatii_abonament_client ia ON c.id_abonament = ia.id_abonament
    JOIN tip_abonament ta ON ia.id_tip_abonament = ta.id_tip_abonament
    WHERE ia.data_inceput BETWEEN data_start AND data_end;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista clienti in intervalul dorit!');
    ELSE
        FOR client IN (SELECT c.nume, c.prenume, c.adresa, ia.data_inceput, ia.data_sfarsit, ta.nume_abonament, ta.pret, ta.descriere
            FROM clienti c
            JOIN informatii_abonament_client ia ON c.id_abonament = ia.id_abonament
            JOIN tip_abonament ta ON ia.id_tip_abonament = ta.id_tip_abonament
            WHERE ia.data_inceput BETWEEN data_start AND data_end)
        LOOP
            DBMS_OUTPUT.PUT_LINE(client.nume || ' ' || client.prenume || ', ' || client.adresa || ', Abonament ' || client.nume_abonament || ', Pret: ' || client.pret || ' lei, Perioada: ' || client.data_inceput || ' - ' || client.data_sfarsit);
        END LOOP;
    END IF;
END;
/

EXECUTE afisare_clienti_abonamente('01-JAN-2020', '31-JAN-2020');
EXECUTE afisare_clienti_abonamente('01-JAN-2023', '31-JAN-2023');

--2. Returnare numar de clienti cu abonament de tipul dat

CREATE OR REPLACE PROCEDURE nr_clienti_abonament
    (p_id_abonament IN NUMBER, p_nr_clienti OUT NUMBER)
IS
BEGIN
    SELECT COUNT(*) INTO p_nr_clienti
    FROM clienti
    WHERE id_abonament = p_id_abonament;
    DBMS_OUTPUT.PUT_LINE('Numarul de clienti cu abonamentul cu id-ul '||p_id_abonament||' este: '||p_nr_clienti);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista abonament cu id-ul specificat');
END;
/

DECLARE
    nr_clienti NUMBER;
BEGIN
    nr_clienti_abonament(&id_abonament, nr_clienti);
END;
/

-- 3. procedura - cel mai lung abonament
CREATE OR REPLACE PROCEDURE cel_mai_lung_abonament
IS
    v_max NUMBER;
    v_id_abonament informatii_abonament_client.id_abonament%TYPE;
    v_data_inceput informatii_abonament_client.data_inceput%TYPE;
    v_data_sfarsit informatii_abonament_client.data_sfarsit%TYPE;
    v_diferenta NUMBER;
    CURSOR c_abonamente IS
        SELECT id_abonament, data_inceput, data_sfarsit
        FROM informatii_abonament_client;
BEGIN
    v_max := 0;
    v_id_abonament := NULL;
   
    FOR abonament IN c_abonamente LOOP
        v_diferenta := abonament.data_sfarsit - abonament.data_inceput;
        IF v_diferenta > v_max THEN
            v_max := v_diferenta;
            v_id_abonament := abonament.id_abonament;
            v_data_inceput := abonament.data_inceput;
            v_data_sfarsit := abonament.data_sfarsit;
        END IF;
    END LOOP;
   
    DBMS_OUTPUT.PUT_LINE('Id-ul abonamentului cu cea mai lunga perioada este: ' || v_id_abonament);
    DBMS_OUTPUT.PUT_LINE('Data inceput: ' || v_data_inceput);
    DBMS_OUTPUT.PUT_LINE('Data sfarsit: ' || v_data_sfarsit);
    DBMS_OUTPUT.PUT_LINE('Durata: ' || v_max || ' zile');
END;
/

EXECUTE cel_mai_lung_abonament;

CREATE OR REPLACE PACKAGE pachet_subprograme1 IS

    
    PROCEDURE afisare_clienti_abonamente(data_start IN DATE, data_end IN DATE);

    
    PROCEDURE nr_clienti_abonament(p_id_abonament IN NUMBER, p_nr_clienti OUT NUMBER);

    
    PROCEDURE cel_mai_lung_abonament;

END pachet_subprograme1;
/

CREATE OR REPLACE PACKAGE BODY pachet_subprograme1 IS

    
    PROCEDURE afisare_clienti_abonamente(data_start IN DATE, data_end IN DATE)
    AS
        v_count INTEGER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM clienti c
        JOIN informatii_abonament_client ia ON c.id_abonament = ia.id_abonament
        JOIN tip_abonament ta ON ia.id_tip_abonament = ta.id_tip_abonament
        WHERE ia.data_inceput BETWEEN data_start AND data_end;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista clienti in intervalul dorit!');
        ELSE
            FOR client IN (SELECT c.nume, c.prenume, c.adresa, ia.data_inceput, ia.data_sfarsit, ta.nume_abonament, ta.pret, ta.descriere
                FROM clienti c
                JOIN informatii_abonament_client ia ON c.id_abonament = ia.id_abonament
                JOIN tip_abonament ta ON ia.id_tip_abonament = ta.id_tip_abonament
                WHERE ia.data_inceput BETWEEN data_start AND data_end)
            LOOP
                DBMS_OUTPUT.PUT_LINE(client.nume || ' ' || client.prenume || ', ' || client.adresa || ', Abonament ' || client.nume_abonament || ', Pret: ' || client.pret || ' lei, Perioada: ' || client.data_inceput || ' - ' || client.data_sfarsit);
            END LOOP;
        END IF;
    END;

   
    PROCEDURE nr_clienti_abonament(p_id_abonament IN NUMBER, p_nr_clienti OUT NUMBER)
    IS
    BEGIN
        SELECT COUNT(*)
        INTO p_nr_clienti
        FROM clienti
        WHERE id_abonament = p_id_abonament;
        DBMS_OUTPUT.PUT_LINE('Numarul de clienti cu abonamentul cu id-ul '||p_id_abonament||' este: '||p_nr_clienti);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nu exista abonament cu id-ul specificat');
    END;

    
    PROCEDURE cel_mai_lung_abonament
    IS
        v_max NUMBER;
        v_id_abonament informatii_abonament_client.id_abonament%TYPE;
        v_data_inceput informatii_abonament_client.data_inceput%TYPE;
        v_data_sfarsit informatii_abonament_client.data_sfarsit%TYPE;
        v_diferenta NUMBER;
        CURSOR c_abonamente IS
            SELECT id_abonament, data_inceput, data_sfarsit
            FROM informatii_abonament_client;
    BEGIN
        v_max := 0;
        v_id_abonament := NULL;

        FOR abonament IN c_abonamente LOOP
            v_diferenta := abonament.data_sfarsit - abonament.data_inceput;
            IF v_diferenta > v_max THEN
                v_max := v_diferenta;
                v_id_abonament := abonament.id_abonament;
                v_data_inceput := abonament.data_inceput;
                v_data_sfarsit := abonament.data_sfarsit;
            END IF;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Id-ul abonamentului cu cea mai lunga perioada este: ' || v_id_abonament);
        DBMS_OUTPUT.PUT_LINE('Data inceput: ' || v_data_inceput);
        DBMS_OUTPUT.PUT_LINE('Data sfarsit: ' || v_data_sfarsit);
        DBMS_OUTPUT.PUT_LINE('Durata: ' || v_max || ' zile');
    END;

END pachet_subprograme1;
/

BEGIN
    pachet_subprograme1.afisare_clienti_abonamente('01-JAN-2020', '31-JAN-2020');
END;
/



-- 1. numarul de clienti cu numele dat ca parametru 
CREATE OR REPLACE FUNCTION numar_clienti_cu_numele
(nume_client IN VARCHAR2) 
RETURN NUMBER 
IS
    nr_clienti NUMBER := 0;
    CURSOR c_clienti IS SELECT COUNT(*) AS nr_clienti FROM clienti WHERE nume = nume_client;
BEGIN
    OPEN c_clienti;
    FETCH c_clienti INTO nr_clienti;
    CLOSE c_clienti;
    DBMS_OUTPUT.PUT_LINE('Numarul de clienti cu numele ' || nume_client || ' este: ' || nr_clienti);
    RETURN nr_clienti;
END;
/

DECLARE
    nr_clienti NUMBER;
    nr_clienti2 NUMBER;
BEGIN
    nr_clienti := numar_clienti_cu_numele('Dinca');
    nr_clienti2 := numar_clienti_cu_numele('Cristian');
END;
/

-- 2. creeaza o functie trainer_max_specializari care sa returneze un sir de caractere cu numele trainerului cu cele mai multe specializari, si numele lui
CREATE OR REPLACE PROCEDURE trainer_max_specializari1
IS
    v_nume_trainer VARCHAR2(20);
    v_max_specializari NUMBER(20);
BEGIN
    SELECT t.nume || ' ' || t.prenume, COUNT(ts.id_specializare) INTO v_nume_trainer, v_max_specializari
    FROM traineri t
    INNER JOIN trainer_specializare ts ON t.id_trainer = ts.id_trainer
    GROUP BY t.nume, t.prenume
    HAVING COUNT(ts.id_specializare) = (SELECT MAX(COUNT(id_specializare)) FROM trainer_specializare GROUP BY id_trainer);

    DBMS_OUTPUT.PUT_LINE('Trainerul cu cele mai multe specializari este: ' || v_nume_trainer || ' cu numarul de specializari: ' || v_max_specializari) ;
    
    
END;
/


BEGIN
    trainer_max_specializari1;
END;
/



-- 3. numarul de clase la care a participat clientul cu id-ul dat ca parametru
CREATE OR REPLACE FUNCTION numar_clase_client(p_id_client IN clienti.id_client%TYPE)
RETURN NUMBER
IS
    v_nr_clase NUMBER;
    v_id_client number;
BEGIN
    SELECT id_client
    into v_id_client
    FROM clienti
    WHERE p_id_client = id_client;
    
    
    SELECT COUNT(*)
    INTO v_nr_clase
    FROM client_programare cp
    JOIN clienti c ON cp.id_client = c.id_client
    JOIN informatii_programare_clasa ipc ON cp.id_programare_clasa = ipc.id_programare_clasa
    WHERE c.id_client = p_id_client;
    
    
    
    DBMS_OUTPUT.PUT_LINE('Numarul de clase la care a participat clientul cu ID ' || p_id_client || ' este ' || v_nr_clase);
    
    RETURN v_nr_clase;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista nicio programare la care a participat clientul cu ID ' || p_id_client);
        RETURN NULL;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(numar_clase_client(1));
    DBMS_OUTPUT.PUT_LINE(numar_clase_client(300)); 
END;
/

-- declansatori
-- --Sa se creeze un trigger asupra tabelei Tip_abonament, prin care, la modificarea valorii id_produs din tabela parinte,
--aceasta sa se modifice automat si in inregistrarile corespondente
--din tabela copil


CREATE OR REPLACE TRIGGER trg_update_tip_ab_cascada
BEFORE UPDATE OF id_tip_abonament ON tip_abonament
FOR EACH ROW
DECLARE
    affected_rows NUMBER;
BEGIN
    
    UPDATE informatii_abonament_client
    SET id_tip_abonament = :NEW.id_tip_abonament
    WHERE id_tip_abonament = :OLD.id_tip_abonament;
END;
/

UPDATE tip_abonament
SET id_tip_abonament=100
WHERE id_tip_abonament=2;
/

select * from informatii_abonament_client;
select * from tip_abonament;
/

-- sa se creeze un declansator prin care sa se impiedice adaugarea unei noi
-- specializari pentru un trainer daca are deja 3 specializari

CREATE OR REPLACE TRIGGER trg_check_trainer_specializare
BEFORE INSERT ON trainer_specializare
FOR EACH ROW
DECLARE
    v_trainer_id traineri.id_trainer%TYPE;
    v_specializari_count NUMBER;
BEGIN
    -- Obținem id-ul trainerului pentru care se adaugă specializarea
    SELECT id_trainer INTO v_trainer_id FROM traineri WHERE id_trainer = :NEW.id_trainer_specializare;
    
    -- Numărăm specializările existente pentru trainer
    SELECT COUNT(*) INTO v_specializari_count FROM trainer_specializare WHERE id_trainer = v_trainer_id;
    
    -- Verificăm dacă numărul de specializări este deja 3
    IF v_specializari_count >= 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Trainerul are deja 3 specializări. Nu se poate adăuga o nouă specializare.');
    END IF;
END;
/

insert into specializare(id_specializare, nume_specializare, descriere)
values(4,'box','Sport in care doi adversari lupta între ei, pe ring, după anumite reguli, cu pumnii îmbracati in manusi speciale.');

insert into trainer_specializare(id_trainer_specializare,id_trainer,id_specializare)
values(1,1,4);


-- sa se verifice daca sala este full cand se adauga un client la programare
CREATE OR REPLACE TRIGGER trg_adaugare_programari
BEFORE INSERT ON client_programare
FOR EACH ROW
DECLARE
    numar_clienti NUMBER;
    dimensiune_sala NUMBER;
BEGIN
    SELECT COUNT(*) INTO numar_clienti
    FROM client_programare
    WHERE id_programare_clasa = :NEW.id_programare_clasa;
    
    SELECT dimensiune INTO dimensiune_sala
    FROM sala
    WHERE id_sala = (SELECT id_sala FROM informatii_programare_clasa WHERE id_programare_clasa = :NEW.id_programare_clasa);
    
    IF numar_clienti > dimensiune_sala THEN
        
        RAISE_APPLICATION_ERROR(-20001, 'Sala este ocupată la maxim.');
    END IF;

END;
/

insert into sala(id_sala, dimensiune)
values(5,1);

insert into informatii_programare_clasa(id_programare_clasa, id_specializare, id_sala, data_zi, ora_inceput, ora_sfarsit)
values(100,3,5,to_date('28/01/2023', 'DD/MM/YYYY'),to_date('15:30', 'HH24:MI'),to_date('17:30', 'HH24:MI'));

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(800,1,100);

insert into client_programare(id_client_programare,id_client,id_programare_clasa)
values(801,2,100);
