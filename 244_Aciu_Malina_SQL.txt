CREATE TABLE COMPANIE
(id_companie NUMBER(5),
nume VARCHAR2(30),
an_infiintare NUMBER(4),
CONSTRAINT primary_key_companie PRIMARY KEY (id_companie));

ALTER TABLE COMPANIE
MODIFY nume NOT NULL;

CREATE TABLE TABARA
(id_tabara NUMBER(5),
data_inceput DATE CONSTRAINT data_inceput_nn NOT NULL,
data_final DATE CONSTRAINT data_final_nn NOT NULL,
locatie VARCHAR2(20) CONSTRAINT locatie_nn NOT NULL,
CONSTRAINT primary_key_tabara PRIMARY KEY (id_tabara));

ALTER TABLE TABARA
ADD CONSTRAINT date_tabara CHECK (data_inceput < data_final);

CREATE TABLE SPECIALIST
(id_specialist NUMBER(5),
nume VARCHAR2(20) NOT NULL,
prenume VARCHAR2(30) NOT NULL,
specializare VARCHAR2(20) NOT NULL,
ani_experienta NUMBER(2),
salariu NUMBER (4),
CONSTRAINT primary_key_specialist PRIMARY KEY (id_specialist));

CREATE TABLE SESIUNE
(id_sesiune NUMBER(5),
data_sesiune DATE NOT NULL,
durata number(1) NOT NULL,
id_tabara NUMBER(5),
CONSTRAINT primary_key_sesiune PRIMARY KEY (id_sesiune));

ALTER TABLE SESIUNE
ADD CONSTRAINT id_tabara_fk FOREIGN KEY(id_tabara) REFERENCES TABARA(id_tabara);

CREATE TABLE INVITAT
(id_invitat NUMBER(5),
nume VARCHAR2(20) NOT NULL,
prenume VARCHAR2(30) NOT NULL,
ocupatie VARCHAR2(20),
id_sesiune NUMBER(5),
CONSTRAINT primaty_key_invitat PRIMARY KEY (id_invitat));

ALTER TABLE INVITAT
ADD CONSTRAINT id_sesiune_fk FOREIGN KEY(id_sesiune) REFERENCES SESIUNE(id_sesiune);

CREATE TABLE GRUPA
(id_grupa NUMBER(5),
numar_liceeni NUMBER(1) NOT NULL,
CONSTRAINT primary_key_grupa PRIMARY KEY(id_grupa));

CREATE TABLE ATELIER
(id_atelier NUMBER(5),
nume VARCHAR2(20) NOT NULL,
ore_total NUMBER(2),
materie VARCHAR2(20),
id_tabara NUMBER(5),
id_specialist NUMBER(5),
CONSTRAINT primaty_key_atelier PRIMARY KEY (id_atelier));

ALTER TABLE ATELIER
ADD CONSTRAINT id_tabara_fk_atelier FOREIGN KEY(id_tabara) REFERENCES TABARA(id_tabara);

ALTER TABLE ATELIER
ADD CONSTRAINT id_specialist_fk_atelier FOREIGN KEY(id_specialist) REFERENCES SPECIALIST(id_specialist);

CREATE TABLE LICEAN
(id_licean NUMBER(5),
nume VARCHAR2(20) NOT NULL,
prenume VARCHAR2(30) NOT NULL,
clasa NUMBER(2) CONSTRAINT clasa_nr CHECK(clasa >= 9 and clasa <= 12),
liceu VARCHAR2(30),
id_tabara NUMBER(5),
id_grupa NUMBER(5),
id_specialist NUMBER(5),
CONSTRAINT primary_key_licean PRIMARY KEY (id_licean));

ALTER TABLE LICEAN
ADD CONSTRAINT id_tabara_fk_licean FOREIGN KEY(id_tabara) REFERENCES TABARA(id_tabara);

ALTER TABLE LICEAN
ADD CONSTRAINT id_grupa_fk_licean FOREIGN KEY(id_grupa) REFERENCES GRUPA(id_grupa);

ALTER TABLE LICEAN
ADD CONSTRAINT id_specialist_fk_licean FOREIGN KEY(id_specialist) REFERENCES SPECIALIST(id_specialist);

CREATE TABLE VOLUNTAR
(id_voluntar NUMBER(5),
nume VARCHAR2(20) NOT NULL,
prenume VARCHAR2(30) NOT NULL,
data_nasterii DATE,
id_atelier NUMBER(5),
CONSTRAINT primary_key_voluntar PRIMARY KEY (id_voluntar));

ALTER TABLE VOLUNTAR
ADD CONSTRAINT id_atelier_fk_voluntar FOREIGN KEY(id_atelier) REFERENCES ATELIER(id_atelier);

CREATE TABLE PROIECT
(id_proiect NUMBER (5),
titlu VARCHAR2(20) NOT NULL,
materie VARCHAR2(20),
id_licean NUMBER(5),
CONSTRAINT primary_key_proiect PRIMARY KEY (id_proiect));

ALTER TABLE PROIECT
ADD CONSTRAINT  id_licean_fk_proiect FOREIGN KEY (id_licean) REFERENCES LICEAN(id_licean);


CREATE TABLE SPONSORIZEAZA
(id_companie NUMBER(5),
id_tabara NUMBER(5),
suma NUMBER (6),
CONSTRAINT primary_key_sponsorizeaza PRIMARY KEY (id_companie, id_tabara));

ALTER TABLE SPONSORIZEAZA
ADD CONSTRAINT id_companie_fk_sponsor FOREIGN KEY(id_companie) REFERENCES COMPANIE(id_companie);

ALTER TABLE SPONSORIZEAZA
ADD CONSTRAINT id_tabara_fk_sponsor FOREIGN KEY(id_tabara) REFERENCES TABARA(id_tabara);

ALTER TABLE SPONSORIZEAZA
MODIFY suma NOT NULL;


CREATE TABLE SUPERVIZEAZA
(id_voluntar NUMBER(5),
id_licean NUMBER(5),
nr_de_ore NUMBER(1) not null,
CONSTRAINT primary_key_supervizeaza PRIMARY KEY (id_voluntar, id_licean),
CONSTRAINT id_voluntar_fk_super FOREIGN KEY (id_voluntar) REFERENCES VOLUNTAR(id_voluntar),
CONSTRAINT id_licean_fk_super FOREIGN KEY(id_licean) REFERENCES LICEAN(id_licean));

CREATE TABLE SE_INSCRIE
(id_licean NUMBER(5),
id_atelier NUMBER(5),
data_inscriere DATE NOT NULL,
CONSTRAINT primary_key_inscrie PRIMARY KEY(id_licean, id_atelier),
CONSTRAINT id_licean_fk_inscrie FOREIGN KEY (id_licean) REFERENCES LICEAN(id_licean),
CONSTRAINT id_atelier_fk_inscrie FOREIGN Key(id_atelier) REFERENCES ATELIER(id_atelier));


CREATE SEQUENCE SEQ_GRUPA3
INCREMENT BY 10
START WITH 10
MAXVALUE 1000
NOCYCLE;

INSERT INTO GRUPA
VALUES(SEQ_GRUPA3.NEXTVAL, 3);

INSERT INTO GRUPA
VALUES(SEQ_GRUPA3.NEXTVAL, 5);

INSERT INTO GRUPA
VALUES(SEQ_GRUPA3.NEXTVAL, 5);

INSERT INTO GRUPA
VALUES(SEQ_GRUPA3.NEXTVAL, 4);

INSERT INTO GRUPA
VALUES(SEQ_GRUPA3.NEXTVAL, 5);

CREATE SEQUENCE SEQ_TABARA3
INCREMENT BY 10
START WITH 10
MAXVALUE 10000
NOCYCLE;

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('05-11-2018', 'DD-MM-YYYY'), TO_DATE('09-11-2018', 'DD-MM-YYYY'), 'ARAD');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('13-04-2019', 'DD-MM-YYYY'), TO_DATE('18-04-2019', 'DD-MM-YYYY'), 'BUCURESTI');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('12-08-2019', 'DD-MM-YYYY'), TO_DATE('18-08-2019', 'DD-MM-YYYY'), 'SIBIU');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('10-02-2020', 'DD-MM-YYYY'), TO_DATE('14-02-2020', 'DD-MM-YYYY'), 'CLUJ-NAPOCA');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('11-09-2020', 'DD-MM-YYYY'), TO_DATE('18-09-2020', 'DD-MM-YYYY'), 'BUCURESTI');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('04-03-2018', 'DD-MM-YYYY'), TO_DATE('09-03-2018', 'DD-MM-YYYY'), 'TIMISOARA');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('05-08-2019', 'DD-MM-YYYY'), TO_DATE('09-08-2019', 'DD-MM-YYYY'), 'IASI');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('05-11-2017', 'DD-MM-YYYY'), TO_DATE('09-11-2017', 'DD-MM-YYYY'), 'GALATI');

INSERT INTO TABARA
VALUES(SEQ_TABARA3.NEXTVAL, TO_DATE('02-06-2017', 'DD-MM-YYYY'), TO_DATE('08-06-2017', 'DD-MM-YYYY'), 'IASI');

SELECT * FROM TABARA;

--REVENIRE EXERCITIU 10
INSERT INTO COMPANIE
VALUES(10, 'AQUACARPATICA.SRL', 2002);

INSERT INTO COMPANIE
VALUES(20, 'SUPERBET.SRL', 2004);

INSERT INTO COMPANIE
VALUES(30, 'EUROSTAR STUDIOS.SRL', 2002);

INSERT INTO COMPANIE
VALUES(40, 'KAUFLAND.SRL', 1999);

INSERT INTO COMPANIE
VALUES(50, 'FLOWERS DESIGN.SRL', 2009);

INSERT INTO SPECIALIST
VALUES(10, 'Pop', 'Alexandra', 'biologie moleculara', 12, 1800);

INSERT INTO SPECIALIST
VALUES(20, 'Pop', 'Matei', 'matematica', 12, 3000);

INSERT INTO SPECIALIST
VALUES(30, 'Popa', 'Ion', 'biologie', 8, 2500);

INSERT INTO SPECIALIST
VALUES(40, 'Munteanu', 'Diana', 'informatica', 15, 3300);

INSERT INTO SPECIALIST
VALUES(50, 'Anton', 'Maria', 'engleza', 8, 2000);

INSERT INTO SPECIALIST
VALUES(60, 'Bejan', 'Andrei', 'matematica', 14, 3250);


INSERT INTO ATELIER
VALUES (10, 'Bazele biologiei', 12, 'biologie', 30, 30);

INSERT INTO ATELIER
VALUES (20, 'Literatura engleza', 12, 'engleza', 20, 50);

INSERT INTO ATELIER
VALUES (30, 'Matematica avansata', 12, 'matematica', 30, 60);

INSERT INTO ATELIER
VALUES (40, 'Algoritmi de baza', 12, 'informatica', 40, 40);

INSERT INTO ATELIER
VALUES (50, 'Bazele biologiei II', 10, 'biologie', 30, 10);

INSERT INTO ATELIER
VALUES (60, 'Biologie moleculara', 12, 'biologie moleculara', 50, 10);

INSERT INTO ATELIER
VALUES (70, 'Structuri de date', 14, 'informatica', 60, 40);

INSERT INTO ATELIER
VALUES (80, 'Engleza avansata', 9, 'engleza', 70, 50);

INSERT INTO ATELIER
VALUES (90, 'Fizica aplicata', 12, 'fizica', 80, 60);

INSERT INTO ATELIER
VALUES (100, 'Fizica si mate', 14, 'fizica', 90, 20);

INSERT INTO ATELIER
VALUES (110, 'Informatica', 15, 'informatica', 100, 40);


INSERT INTO VOLUNTAR
VALUES(10, 'Popescu', 'Clara', TO_DATE('26-11-2002', 'dd-mm-yyyy'), 30);

INSERT INTO VOLUNTAR
VALUES(20, 'Marin', 'Andreea', TO_DATE('14-09-2000', 'dd-mm-yyyy'), 40);

INSERT INTO VOLUNTAR
VALUES(30, 'Mircea', 'Ana', TO_DATE('06-04-2001', 'dd-mm-yyyy'), 50);

INSERT INTO VOLUNTAR
VALUES(40, 'Marinescu', 'Larisa', TO_DATE('24-01-2002', 'dd-mm-yyyy'), 60);

INSERT INTO VOLUNTAR
VALUES(50, 'Popescu', 'Clara', TO_DATE('26-11-2002', 'dd-mm-yyyy'), 10);

INSERT INTO VOLUNTAR
VALUES(60, 'Popescu', 'Clara', TO_DATE('26-11-2002', 'dd-mm-yyyy'), 20);

UPDATE VOLUNTAR
SET NUME = 'Ciurea' , PRENUME = 'Bianca'
WHERE id_voluntar = 50;

UPDATE VOLUNTAR
SET NUME = 'Bogdan' , PRENUME = 'Ioana'
WHERE id_voluntar = 60;

UPDATE VOLUNTAR
SET data_nasterii = TO_DATE('02-08-2001', 'dd-mm-yyyy')
WHERE id_voluntar = 50;

UPDATE VOLUNTAR
SET data_nasterii = TO_DATE('03-09-2001', 'dd-mm-yyyy')
WHERE id_voluntar = 60;

INSERT INTO VOLUNTAR
VALUES(70, 'Baciu', 'Otilia', TO_DATE('22-04-2000', 'dd-mm-yyyy'),30);

INSERT INTO VOLUNTAR
VALUES(80, 'Vladici', 'Sara', TO_DATE('02-04-2000', 'dd-mm-yyyy'),10);

INSERT INTO VOLUNTAR
VALUES(90, 'Bob', 'Alice', TO_DATE('21-06-2000', 'dd-mm-yyyy'), 30);

INSERT INTO VOLUNTAR
VALUES(100, 'Bran', 'Alexandru', TO_DATE('12-09-2001', 'dd-mm-yyyy'), 20);

INSERT INTO VOLUNTAR
VALUES(110, 'Costea', 'Mihail', TO_DATE('20-12-2000', 'dd-mm-yyyy'), 60);

INSERT INTO VOLUNTAR
VALUES(120, 'Corolescu', 'Catalin', TO_DATE('29-01-2002', 'dd-mm-yyyy'), 60);

INSERT INTO VOLUNTAR
VALUES(130, 'Mihai', 'Violeta', TO_DATE('28-08-2000', 'dd-mm-yyyy'), 50);

INSERT INTO VOLUNTAR
VALUES(140, 'Manea', 'Tudor', TO_DATE('17-05-2000', 'dd-mm-yyyy'), 30);

INSERT INTO VOLUNTAR
VALUES(150, 'Sorescu', 'Teodor', TO_DATE('13-10-2001', 'dd-mm-yyyy'), 20);


INSERT INTO SESIUNE
VALUES(10, TO_DATE('06-11-2018', 'DD-MM-YYYY'), 3, 20);

INSERT INTO SESIUNE
VALUES(20, TO_DATE('15-04-2019', 'DD-MM-YYYY'), 2, 30);

INSERT INTO SESIUNE
VALUES(30, TO_DATE('13-08-2019', 'DD-MM-YYYY'), 3, 40);

INSERT INTO SESIUNE
VALUES(40, TO_DATE('13-02-2020', 'DD-MM-YYYY'), 3, 50);

INSERT INTO SESIUNE
VALUES(50, TO_DATE('17-09-2020', 'DD-MM-YYYY'), 3, 60);

INSERT INTO SESIUNE
VALUES(60, TO_DATE('04-03-2018', 'DD-MM-YYYY'), 3, 70);

INSERT INTO SESIUNE
VALUES(70, TO_DATE('07-08-2019', 'DD-MM-YYYY'), 3, 80);

INSERT INTO SESIUNE
VALUES(80, TO_DATE('06-11-2017', 'DD-MM-YYYY'), 3, 90);

INSERT INTO SESIUNE
VALUES(90, TO_DATE('06-06-2017', 'DD-MM-YYYY'), 3, 100);




INSERT INTO INVITAT
VALUES(10, 'Anghel', 'Sorana', 'antreprenor', 10);

INSERT INTO INVITAT
VALUES(20, 'Angelescu', 'Bogdan', 'atlet', 20);

INSERT INTO INVITAT
VALUES(30, 'Milu', 'Alexandru', 'atlet', 30);

INSERT INTO INVITAT
VALUES(40, 'Barbu', 'Simona', 'psiholog', 40);

INSERT INTO INVITAT
VALUES(50, 'Antonescu', 'Alina', 'politician', 50);

INSERT INTO INVITAT
VALUES(60, 'Mircescu', 'Vlad', 'antreprenor', 60);

INSERT INTO INVITAT
VALUES(70, 'Manea', 'Bogdan', 'antreprenor', 70);

INSERT INTO INVITAT
VALUES(80, 'Begu', 'Briana', 'psiholog', 80);

INSERT INTO INVITAT
VALUES(90, 'Carstea', 'Marian', 'antreprenor', 90);

INSERT INTO INVITAT
VALUES(100, 'Deaconu', 'Razvan', 'filantrop', 70);


INSERT INTO LICEAN
VALUES(10, 'Popa', 'Alexandra', 10, 'Colegiul National Unirea', 20, 20, 10);

INSERT INTO LICEAN
VALUES(20, 'Minea', 'Alin', 9, 'CN Mihai Eminescu', 30, 30, 20);

INSERT INTO LICEAN
VALUES(30, 'Pelea', 'Mihail', 12, 'CN Ion Luca Caragiale', 40, 20, 10);

INSERT INTO LICEAN
VALUES(40, 'Manea', 'Sandra', 10, 'CN A.I. Cuza', 50, 30, 40);

INSERT INTO LICEAN
VALUES(50, 'Banciu', 'Maria', 11, 'CN Tehnologic Buzau', 60, 40, 50);

INSERT INTO LICEAN
VALUES(60, 'Vasiliu', 'Catalin', 10, 'CN Pedagogic Zalau', 70, 40, 50);

INSERT INTO LICEAN
VALUES(70, 'Neacsu', 'Teodora', 12, 'Liceul Teoretic Nr.1 Vaslui', 80, 20, 60);

INSERT INTO LICEAN
VALUES(80, 'Velea', 'Miruna', 9, 'CN Marin Preda', 90, 30, 10);

INSERT INTO LICEAN
VALUES(90, 'Popescu', 'Lavinia', 10, 'Colegiul National Unirea', 100, 20, 60);

INSERT INTO LICEAN
VALUES(100, 'Nicolae', 'Daria', 9, 'CN Constantin Noica', 20, 20, 20);

INSERT INTO LICEAN
VALUES(110, 'Nania', 'Alexandra', 10, 'CN Tehnologic Nr.2 Braila', 20, 40, 10);

INSERT INTO LICEAN
VALUES(120, 'Popa', 'Mircea', 11, 'Liceul Teoretic Nr.4 Bucuresti', 20, 50, 10);

INSERT INTO LICEAN
VALUES(130, 'Barbu', 'Laurentiu', 12, 'CN Pedagogic Alexandria', 20, 50, 30);

INSERT INTO LICEAN
VALUES(140, 'Chircu', 'Alex', 12, 'CN Stefan Cel Mare', 20, 50, 30);

INSERT INTO LICEAN
VALUES(150, 'Minea', 'Valeria', 12, 'CN Marin Preda', 80, 40, 30);

INSERT INTO LICEAN
VALUES(160, 'Badea', 'Marina', 11, 'Liceul Teoretic Nr.2 Braila', 80, 40, 20);

INSERT INTO LICEAN
VALUES(170, 'Badescu', 'Gina', 9, 'CN Vasile Alecsandri', 100, 50, 50);

INSERT INTO LICEAN
VALUES(180, 'Horea', 'Iulia', 10, 'CN Stefan Cel Mare', 90, 20, 40);

INSERT INTO LICEAN
VALUES(190, 'Bordei', 'Isabela', 10, 'CN Al. I. Cuza', 60, 50, 50);

INSERT INTO LICEAN
VALUES(200, 'Patrascu', 'Andra', 12, 'Liceul Tehnologic Nr.2 Iasi', 20, 50, 20);

INSERT INTO PROIECT
VALUES(10, 'Fizica de azi', 'fizica', 100);

INSERT INTO PROIECT
VALUES(20, 'Mate aplicata', 'matematica', 30);

INSERT INTO PROIECT
VALUES(30, 'Biologie aprofundata', 'biologie moleculara', 40);

INSERT INTO PROIECT
VALUES(40, 'Probleme informatica', 'informatica', 50);

INSERT INTO PROIECT
VALUES(50, 'Literatura engleza', 'engleza', 60);

INSERT INTO PROIECT
VALUES(60, 'Aplicatii', 'matematica', 10);

INSERT INTO PROIECT
VALUES(70, 'Fizica moderna', 'fizica', 20);

INSERT INTO PROIECT
VALUES(80, 'Sub microscop', 'biologie moleculara', 70);

INSERT INTO PROIECT
VALUES(90, 'Arta cuvintelor', 'engleza', 80);

INSERT INTO PROIECT
VALUES(100, 'Fizica altfel', 'fizica', 110);

INSERT INTO PROIECT
VALUES(110, 'Studiul molecular', 'biologie moleculara', 90);

INSERT INTO PROIECT
VALUES(120,'Probleme reale', 'matematica', 120);

INSERT INTO PROIECT
VALUES(130, 'O noua abordare', 'informatica', 130);

INSERT INTO PROIECT
VALUES(140, 'Aplicatii utile', 'informatica', 140);

INSERT INTO PROIECT
VALUES(150, 'Teoria informatiei', 'informatica', 150);

INSERT INTO PROIECT
VALUES(160, 'English Tenses', 'engleza', 160);

INSERT INTO PROIECT
VALUES(170, 'US History', 'engleza', 170);

INSERT INTO PROIECT
VALUES(180, 'Multimea nr reale', 'matematica', 180);

INSERT INTO PROIECT
VALUES(190, 'Regnul animal', 'biologie', 190);

INSERT INTO PROIECT
VALUES(200, 'Legile lui Newton', 'fizica', 200);


INSERT INTO SPONSORIZEAZA
VALUES(20,20, 15000);

INSERT INTO SPONSORIZEAZA
VALUES(10,20, 12000);

INSERT INTO SPONSORIZEAZA
VALUES(20,30, 15000);

INSERT INTO SPONSORIZEAZA
VALUES(20,70, 20000);

INSERT INTO SPONSORIZEAZA
VALUES(30,20, 5000);

INSERT INTO SPONSORIZEAZA
VALUES(40,40, 15000);

INSERT INTO SPONSORIZEAZA
VALUES(50,50, 70000);

INSERT INTO SPONSORIZEAZA
VALUES(20,60, 15000);

INSERT INTO SPONSORIZEAZA
VALUES(10,70, 65000);

INSERT INTO SPONSORIZEAZA
VALUES(30,80, 24500);

INSERT INTO SPONSORIZEAZA
VALUES(20,90, 15000);

INSERT INTO SPONSORIZEAZA
VALUES(30,100, 100000);

INSERT INTO SPONSORIZEAZA
VALUES(40,100, 1800);

INSERT INTO SPONSORIZEAZA
VALUES(10,90, 29000);

INSERT INTO SPONSORIZEAZA
VALUES(40,80, 17000);

SELECT * FROM SPONSORIZEAZA;

INSERT INTO SUPERVIZEAZA
VALUES(10, 20, 8);

INSERT INTO SUPERVIZEAZA
VALUES(20,10, 3);

INSERT INTO SUPERVIZEAZA
VALUES(30,10, 2);

INSERT INTO SUPERVIZEAZA
VALUES(40,30, 5);

INSERT INTO SUPERVIZEAZA
VALUES(50,40, 5);

INSERT INTO SUPERVIZEAZA
VALUES(60,10, 1);

INSERT INTO SUPERVIZEAZA
VALUES(70,50, 4);

INSERT INTO SUPERVIZEAZA
VALUES(70,60, 4);

INSERT INTO SUPERVIZEAZA
VALUES(40,20, 3);

INSERT INTO SUPERVIZEAZA
VALUES(30,30, 5);

INSERT INTO SUPERVIZEAZA
VALUES(60,90, 3);

INSERT INTO SUPERVIZEAZA
VALUES(20,100, 3);

INSERT INTO SUPERVIZEAZA
VALUES(70,120, 5);

INSERT INTO SUPERVIZEAZA
VALUES(10,110, 6);

INSERT INTO SUPERVIZEAZA
VALUES(20,130, 3);

INSERT INTO SUPERVIZEAZA
VALUES(40,140, 7);

INSERT INTO SUPERVIZEAZA
VALUES(50,70, 3);

INSERT INTO SUPERVIZEAZA
VALUES(20,80, 3);

INSERT INTO SUPERVIZEAZA
VALUES(70,130, 5);

INSERT INTO SUPERVIZEAZA
VALUES(20,140, 3);

INSERT INTO SUPERVIZEAZA
VALUES(20,150, 2);

INSERT INTO SUPERVIZEAZA
VALUES(40,160, 3);

INSERT INTO SUPERVIZEAZA
VALUES(10,170, 2);

INSERT INTO SUPERVIZEAZA
VALUES(50,180, 4);

INSERT INTO SUPERVIZEAZA
VALUES(10,190, 3);

INSERT INTO SUPERVIZEAZA
VALUES(20,200, 1);

INSERT INTO SUPERVIZEAZA
VALUES(20,20, 1);

INSERT INTO SUPERVIZEAZA
VALUES(40,10, 4);

INSERT INTO SUPERVIZEAZA
VALUES(20,30, 1);


INSERT INTO SE_INSCRIE
VALUES(10, 10, TO_DATE('12-03-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(20, 10, TO_DATE('13-03-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(30, 20, TO_DATE('12-09-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(40, 30, TO_DATE('02-03-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(50, 40, TO_DATE('12-11-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(60, 50, TO_DATE('12-03-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(70, 60, TO_DATE('04-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(80, 10, TO_DATE('12-03-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(90, 30, TO_DATE('01-04-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(100, 40, TO_DATE('30-11-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(110, 50, TO_DATE('11-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(120, 60, TO_DATE('17-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(130, 20, TO_DATE('09-09-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(140, 20, TO_DATE('17-09-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(140, 10, TO_DATE('10-03-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(110, 40, TO_DATE('12-11-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(90, 50, TO_DATE('12-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(150, 50, TO_DATE('12-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(160, 10, TO_DATE('11-03-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(170, 40, TO_DATE('12-11-2019', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(180, 20, TO_DATE('16-09-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(190, 60, TO_DATE('12-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(200, 60, TO_DATE('10-06-2020', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(10, 20, TO_DATE('10-09-2018', 'DD-MM-YYYY'));

INSERT INTO SE_INSCRIE
VALUES(20, 20, TO_DATE('11-09-2018', 'DD-MM-YYYY'));

SELECT * FROM se_inscrie;

ALTER TABLE LICEAN
ADD Cheltuieli_transport NUMBER(3);


UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 50
WHERE (ID_LICEAN = 10 OR ID_LICEAN = 20);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 97
WHERE (ID_LICEAN = 40 OR ID_LICEAN = 120);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 70
WHERE (ID_LICEAN = 60 OR ID_LICEAN = 70 OR ID_LICEAN = 150);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 110
WHERE (ID_LICEAN = 200);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 120
WHERE (ID_LICEAN = 100);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 100
WHERE (ID_LICEAN = 50);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 125
WHERE (ID_LICEAN = 30);

UPDATE LICEAN
SET CHELTUIELI_TRANSPORT = 30
WHERE (ID_LICEAN = 190);

select * from companie;

select * from licean;

select * from grupa;

select * from invitat;

select * from atelier;

select * from voluntar;

select * from proiect;

select * from tabara;

Select * from sponsorizeaza;

select * from sesiune;

select * from specialist;

select * from supervizeaza;

select * from se_inscrie;

--ex 6
create or replace procedure ex_6(cod companie.id_companie%type)
is
    type tablou_indexat is
    table of sponsorizeaza%rowtype
    index by binary_integer;

    t tablou_indexat;

    type vector_sume is varray(100) of number;
    sume vector_sume := vector_sume();

    type vector_locatie is varray(100) of varchar2(300);
    locatii vector_locatie :=vector_locatie();

    sponsor companie.nume%type;

    total number(7) := 0;
    j number(3) := 1;

    nume_oras tabara.locatie%type;

begin
    select nume into sponsor
    from companie
    where id_companie = cod;

    select * bulk collect into t
    from sponsorizeaza;

    for i in t.first..t.last loop
        if t(i).id_companie = cod then
            sume.extend();
            sume(j) := t(i).suma;
            total := total + t(i).suma;

            locatii.extend();
            locatii(j) := t(i).id_tabara;

            j := j + 1;
        end if;
    end loop;

    dbms_output.put_line('Numele companiei este ' || sponsor);
    dbms_output.put_line('Suma totala acordata in sponsorizari a fost de ' || total || ' dupa cum urmeaza');
    for i in locatii.first..locatii.last loop
        select locatie into nume_oras
        from tabara
        where id_tabara = locatii(i);

        dbms_output.put_line('Suma de ' || sume(i) || ' pentru tabara din ' || nume_oras || ' cu id-ul de ' || locatii(i));
    end loop;

    exception
        when no_data_found then dbms_output.put_line('Nu exista compania cu codul introdus');

end;

execute ex_6(670);
execute ex_6(20);

--ex 7
create or replace procedure ex_7(class licean.clasa%type)
is
    cursor c(class licean.clasa%type)
    is select id_licean, nume, prenume from
    licean where clasa = class;

    cod licean.id_licean%type;
    nume_lic licean.nume%type;
    prenume_lic licean.prenume%type;
    nume_atelier atelier.nume%type;
    spec specialist.id_specialist%type;
    nume_s licean.nume%type;
    prenume_s licean.prenume%type;

    maxim number(2) := 0;
    nume_max licean.nume%type;
    prenume_max licean.prenume%type;

begin
    open c(class);
    loop
    fetch c into cod, nume_lic, prenume_lic;
    exit when c%notfound;
    dbms_output.put_line('NUME ELEV: ' || nume_lic || ' ' || prenume_lic);
    dbms_output.put_line('Ateliere la care a participat: ');
    for i in (with tabel as (select id_licean lic, count(*) numar from se_inscrie group by id_licean) select id_atelier id, numar nr from se_inscrie, tabel where id_licean = cod and lic = cod) loop
        select nume into nume_atelier
        from atelier
        where id_atelier = i.id;

        select id_specialist into spec
        from atelier where id_atelier = i.id;

        select nume, prenume into nume_s, prenume_s
        from specialist where id_specialist = spec;

        dbms_output.put_line(nume_atelier || ' coordonat de ' || nume_s || ' ' || prenume_s);

        if i.nr > maxim then maxim := i.nr;
        nume_max := nume_lic;
        prenume_max := prenume_lic;
        end if;

        end loop;

    end loop;

    close c;
    if cod is null then dbms_output.put_line('Nu exista clasa data ca parametru');
    else
        dbms_output.put_line('NUMELE ELEVULUI INSCRIS LA CELE MAI MULTE ATELIERE: ' || nume_max || ' ' || prenume_max);
    end if;

end;

execute ex_7(9);
execute ex_7(44); --clasa nu există, intră pe cazul când codul este null

--ex 8
create or replace function ex_8(cod tabara.id_tabara%type) 
return number is
    cod_invalid exception;
    cod_notfound exception;
    suma_atinsa exception;
    nume_comp companie.nume%type;
    suma_max sponsorizeaza.suma%type := 0;

    type v_cod is varray(100) of number;
    v v_cod := v_cod();

    idx number(3) := 1;
    gasit number(1) := 0;  

begin
    if cod <= 0 then raise cod_invalid;
    end if;

    for j in (select id_tabara from tabara) loop
        v.extend();
        v(idx) := j.id_tabara;
        idx := idx + 1;
    end loop;

    for i in v.first..v.last loop
        if v(i) = cod then gasit := 1;
        end if;
    end loop;

    if gasit = 0 then raise cod_notfound;
    end if;

    for i in (select max(s.suma) sum , c.nume name from tabara t join sponsorizeaza s using (id_tabara)
    join companie c using (id_companie)
    where id_tabara = cod
    group by c.nume) loop
        suma_max := suma_max + i.sum;
        dbms_output.put_line('Suma: ' || i.sum || ' de la ' || i.name);

    end loop;

    if suma_max >= 50000 then raise suma_atinsa;
    end if;

    return 50000-suma_max;

    exception
        when cod_invalid then raise_application_error(-20001, 'Codul dat nu poate fi negativ!');

        when suma_atinsa then dbms_output.put_line('Tabara a atins deja pragul dorit de sponsorizari!');
        return 0;
        when cod_notfound then raise_application_error(-20002,'Codul nu a fost gasit in tabela!');

end ex_8;
begin
    --functia intra pe exceptia cod_notfound
    dbms_output.put_line('Taberei ii mai trebuie ' || ex_8(900) || ' RON');
end;

begin
--cazul in care functia returneaza o suma
dbms_output.put_line('Taberei ii mai trebuie ' || ex_8(20) || ' RON');
end;

begin
--cazul in care se intra pe exceptia suma_atinsa
dbms_output.put_line('Taberei ii mai trebuie ' || ex_8(70) || ' RON');
end;

begin
--exceptia de cod_invalid(negativ)
dbms_output.put_line('Taberei ii mai trebuie ' || ex_8(-70) || ' RON');
end;

--ex 9
create or replace procedure ex_9(cod_lic licean.id_licean%type)
is
    nume_lic licean.nume%type;
    prenume_lic licean.prenume%type;
    nume_spec specialist.nume%type;
    prenume_spec specialist.prenume%type;
    id_spec specialist.id_specialist%type;
    titlu_pr proiect.titlu%type;
    --cod_lic licean.id_licean%type;
    nume_at atelier.nume%type;
    oras tabara.locatie%type;

    TYPE tabel IS TABLE OF atelier%rowtype INDEX BY PLS_INTEGER;
    tab tabel;

    cod_invalid exception;
begin
    if cod_lic <= 0 then raise cod_invalid;
    end if;
    --join pe 5 tabele
    select l.nume, l.prenume, s.nume, s.prenume, s.id_specialist, p.titlu, a.nume, t.locatie
    into nume_lic, prenume_lic, nume_spec, prenume_spec, id_spec, titlu_pr, nume_at, oras
    from licean l join tabara t on (l.id_tabara = t.id_tabara)
    join proiect p on (p.id_licean = l.id_licean)
    join specialist s on (s.id_specialist = l.id_specialist)
    join atelier a on (a.id_specialist = s.id_specialist)
    where l.id_licean = cod_lic;

    dbms_output.put_line('Numele liceanului este ' || nume_lic || ' ' || prenume_lic || ', a fost coordonat de specialistul ' || nume_spec || ' ' ||prenume_spec ||
    ' care a organizat atelierul numit ' || nume_at || 
    ', a participat la tabara organizata in orasul ' || oras || ' si a realizat proiectul intitulat ' || '"' || titlu_pr || '"');

    exception
        when cod_invalid then raise_application_error(-20003, 'Codul nu poate fi negativ');
        when no_data_found then raise_application_error(-20000, 'Nu exista elevul cu codul introdus');
        when too_many_rows then
            dbms_output.put_line('Numele liceanului este ' || nume_lic || ' ' || prenume_lic || ', a fost coordonat de specialistul ' || nume_spec || ' ' ||prenume_spec || 
            ', a participat la tabara organizata in orasul ' || oras || ' si a realizat proiectul intitulat ' || '"' || titlu_pr || '"');
             dbms_output.put_line('Specialistul sustine mai multe ateliere, dupa cum urmeaza: ');
            select * bulk collect into tab
            from atelier
            where id_specialist = id_spec;

            for i in tab.first..tab.last loop
                dbms_output.put_line(tab(i).nume);
            end loop;
        when others then raise_application_error(-20002, 'Au aparut erori neprevazute');

 end ex_9;  

--intra pe eroare de no_data_found
execute ex_9(430);

--intra pe eroare de too_many_rows si va afisa toate atelierele coordonate de specialist
execute ex_9(60);

--nu intra pe erori
execute ex_9(20);

--eroarea de cod negativ
execute ex_9(-20); 

--ex 10
create or replace trigger ex_10
before insert on tabara
begin
    for i in (select data_final, data_inceput from tabara) loop
        if i.data_final > sysdate and i.data_inceput < sysdate then raise_application_error(-20001, 'Nu se poate adauga o tabara daca inca exista o tabara in curs de desfasurare!');
        end if;
    end loop;

end;

--inserez o tabără care să fie în curs de desfășurare
insert into tabara values(SEQ_TABARA3.NEXTVAL, TO_DATE('08-01-2023', 'DD-MM-YYYY'), TO_DATE('18-01-2023', 'DD-MM-YYYY'), 'SIBIU');
--declanșare trigger
insert into tabara values(SEQ_TABARA3.NEXTVAL, TO_DATE('12-08-2023', 'DD-MM-YYYY'), TO_DATE('18-08-2023', 'DD-MM-YYYY'), 'BRAILA');

--ex 11
create table voluntar_aux as select * from voluntar;

create or replace trigger ex_11
before insert or update on voluntar
for each row
declare
    numar number(3);

begin
    select count(*) into numar
    from voluntar_aux where id_atelier = :new.id_atelier;

    if numar + 1 > 3
        then raise_application_error(-20000, 'Un atelier nu poate fi organizat de mai mult de 3 voluntari');
    end if;
end;

--declanșare trigger cu update
update voluntar set id_atelier = 60
where nume = 'Popescu';

--declansare trigger cu insert
insert into voluntar values(160, 'Mongescu', 'Victor', to_date('22-02-2000', 'DD-MM-YYYY'), 60);

--ex 12
create table eroriBD 
(user_id varchar2(50),
nume_bd varchar2(50),
erori varchar2(200),
data date);

create or replace trigger ex12
after servererror on schema
begin
    insert into eroriBD values (SYS.LOGIN_USER, SYS.DATABASE_NAME, DBMS_UTILITY.FORMAT_ERROR_STACK, SYSDATE);
end;

Select * from adofswdf;
update dvfdf set ceva = 'afv';
select * from eroriBD;

--ex 13
create or replace package ex_13 as
procedure ex_6(cod companie.id_companie%type);
procedure ex_7(class licean.clasa%type);
function ex_8(cod tabara.id_tabara%type) 
return number;
procedure ex_9(cod_lic licean.id_licean%type);

end ex_13;

create or replace package body ex_13 as
procedure ex_6(cod companie.id_companie%type)
is
    type tablou_indexat is
    table of sponsorizeaza%rowtype
    index by binary_integer;

    t tablou_indexat;

    type vector_sume is varray(100) of number;
    sume vector_sume := vector_sume();

    type vector_locatie is varray(100) of varchar2(300);
    locatii vector_locatie :=vector_locatie();

    sponsor companie.nume%type;

    total number(7) := 0;
    j number(3) := 1;

    nume_oras tabara.locatie%type;

begin
    select nume into sponsor
    from companie
    where id_companie = cod;

    select * bulk collect into t
    from sponsorizeaza;

    for i in t.first..t.last loop
        if t(i).id_companie = cod then
            sume.extend();
            sume(j) := t(i).suma;
            total := total + t(i).suma;

            locatii.extend();
            locatii(j) := t(i).id_tabara;

            j := j + 1;
        end if;
    end loop;

    dbms_output.put_line('Numele companiei este ' || sponsor);
    dbms_output.put_line('Suma totala acordata in sponsorizari a fost de ' || total || ' dupa cum urmeaza');
    for i in locatii.first..locatii.last loop
        select locatie into nume_oras
        from tabara
        where id_tabara = locatii(i);

        dbms_output.put_line('Suma de ' || sume(i) || ' pentru tabara din ' || nume_oras || ' cu id-ul de ' || locatii(i));
    end loop;

    exception
        when no_data_found then dbms_output.put_line('Nu exista compania cu codul introdus');

end ex_6;

procedure ex_7(class licean.clasa%type)
is
    cursor c(class licean.clasa%type)
    is select id_licean, nume, prenume from
    licean where clasa = class;

    cod licean.id_licean%type;
    nume_lic licean.nume%type;
    prenume_lic licean.prenume%type;
    nume_atelier atelier.nume%type;
    spec specialist.id_specialist%type;
    nume_s licean.nume%type;
    prenume_s licean.prenume%type;

    maxim number(2) := 0;
    nume_max licean.nume%type;
    prenume_max licean.prenume%type;

begin
    open c(class);
    loop
    fetch c into cod, nume_lic, prenume_lic;
    exit when c%notfound;
    dbms_output.put_line('NUME ELEV: ' || nume_lic || ' ' || prenume_lic);
    dbms_output.put_line('Ateliere la care a participat: ');
    for i in (with tabel as (select id_licean lic, count(*) numar from se_inscrie group by id_licean) select id_atelier id, numar nr from se_inscrie, tabel where id_licean = cod and lic = cod) loop
        select nume into nume_atelier
        from atelier
        where id_atelier = i.id;

        select id_specialist into spec
        from atelier where id_atelier = i.id;

        select nume, prenume into nume_s, prenume_s
        from specialist where id_specialist = spec;

        dbms_output.put_line(nume_atelier || ' coordonat de ' || nume_s || ' ' || prenume_s);

        if i.nr > maxim then maxim := i.nr;
        nume_max := nume_lic;
        prenume_max := prenume_lic;
        end if;

        end loop;

    end loop;

    close c;
    if cod is null then dbms_output.put_line('Nu exista clasa data ca parametru');
    else
        dbms_output.put_line('NUMELE ELEVULUI INSCRIS LA CELE MAI MULTE ATELIERE: ' || nume_max || ' ' || prenume_max);
    end if;

end ex_7;

function ex_8(cod tabara.id_tabara%type) 
return number is
    cod_invalid exception;
    cod_notfound exception;
    suma_atinsa exception;
    nume_comp companie.nume%type;
    suma_max sponsorizeaza.suma%type := 0;

    type v_cod is varray(100) of number;
    v v_cod := v_cod();

    idx number(3) := 1;
    gasit number(1) := 0;  

begin
    if cod <= 0 then raise cod_invalid;
    end if;

    for j in (select id_tabara from tabara) loop
        v.extend();
        v(idx) := j.id_tabara;
        idx := idx + 1;
    end loop;

    for i in v.first..v.last loop
        if v(i) = cod then gasit := 1;
        end if;
    end loop;

    if gasit = 0 then raise cod_notfound;
    end if;

    for i in (select max(s.suma) sum , c.nume name from tabara t join sponsorizeaza s using (id_tabara)
    join companie c using (id_companie)
    where id_tabara = cod
    group by c.nume) loop
        suma_max := suma_max + i.sum;
        dbms_output.put_line('Suma: ' || i.sum || ' de la ' || i.name);

    end loop;

    if suma_max >= 50000 then raise suma_atinsa;
    end if;

    return 50000-suma_max;

    exception
        when cod_invalid then raise_application_error(-20001, 'Codul dat nu poate fi negativ!');

        when suma_atinsa then dbms_output.put_line('Tabara a atins deja pragul dorit de sponsorizari!');
        return 0;
        when cod_notfound then raise_application_error(-20002,'Codul nu a fost gasit in tabela!');

end ex_8;

procedure ex_9(cod_lic licean.id_licean%type)
is
    nume_lic licean.nume%type;
    prenume_lic licean.prenume%type;
    nume_spec specialist.nume%type;
    prenume_spec specialist.prenume%type;
    id_spec specialist.id_specialist%type;
    titlu_pr proiect.titlu%type;
    --cod_lic licean.id_licean%type;
    nume_at atelier.nume%type;
    oras tabara.locatie%type;

    TYPE tabel IS TABLE OF atelier%rowtype INDEX BY PLS_INTEGER;
    tab tabel;

    cod_invalid exception;
begin
    if cod_lic <= 0 then raise cod_invalid;
    end if;
    --join pe 5 tabele
    select l.nume, l.prenume, s.nume, s.prenume, s.id_specialist, p.titlu, a.nume, t.locatie
    into nume_lic, prenume_lic, nume_spec, prenume_spec, id_spec, titlu_pr, nume_at, oras
    from licean l join tabara t on (l.id_tabara = t.id_tabara)
    join proiect p on (p.id_licean = l.id_licean)
    join specialist s on (s.id_specialist = l.id_specialist)
    join atelier a on (a.id_specialist = s.id_specialist)
    where l.id_licean = cod_lic;

    dbms_output.put_line('Numele liceanului este ' || nume_lic || ' ' || prenume_lic || ', a fost coordonat de specialistul ' || nume_spec || ' ' ||prenume_spec ||
    ' care a organizat atelierul numit ' || nume_at || 
    ', a participat la tabara organizata in orasul ' || oras || ' si a realizat proiectul intitulat ' || '"' || titlu_pr || '"');

    exception
        when cod_invalid then raise_application_error(-20003, 'Codul nu poate fi negativ');
        when no_data_found then raise_application_error(-20000, 'Nu exista elevul cu codul introdus');
        when too_many_rows then
            dbms_output.put_line('Numele liceanului este ' || nume_lic || ' ' || prenume_lic || ', a fost coordonat de specialistul ' || nume_spec || ' ' ||prenume_spec || 
            ', a participat la tabara organizata in orasul ' || oras || ' si a realizat proiectul intitulat ' || '"' || titlu_pr || '"');
             dbms_output.put_line('Specialistul sustine mai multe ateliere, dupa cum urmeaza: ');
            select * bulk collect into tab
            from atelier
            where id_specialist = id_spec;

            for i in tab.first..tab.last loop
                dbms_output.put_line(tab(i).nume);
            end loop;
        when others then raise_application_error(-20002, 'Au aparut erori neprevazute');

end ex_9;   

end ex_13;

execute ex_13.ex_6(10);
execute ex_13.ex_6(91);

execute ex_13.ex_7(10);
execute ex_13.ex_7(122);

begin
--cazul in care functia returneaza o suma
dbms_output.put_line('Taberei ii mai trebuie ' || ex_13.ex_8(20) || ' RON');
end;
begin
--functia intra pe exceptia cod_notfound
dbms_output.put_line('Taberei ii mai trebuie ' || ex_13.ex_8(900) || ' RON');
end;
begin
--cazul in care se intra pe exceptia suma_atinsa
dbms_output.put_line('Taberei ii mai trebuie ' || ex_13.ex_8(70) || ' RON');
end;
begin
--exceptia de cod_invalid(negativ)
dbms_output.put_line('Taberei ii mai trebuie ' || ex_13.ex_8(-70) || ' RON');
end;

--intra pe eroare de no_data_found
execute ex_13.ex_9(430);

execute ex_13.ex_9(60);

--nu intra pe erori
execute ex_13.ex_9(20);
--eroarea de cod negativ
execute ex_13.ex_9(-20);

--exercitiul 14
create or replace package pachet_ex14 as
    function calcul_cheltuieli_transport(cod tabara.id_tabara%type)
    return number;
    procedure voluntarSiLicean(cod tabara.id_tabara%type);
    procedure sortare_specialisti;
    function atelier_cautat
    return atelier.nume%type;
end pachet_ex14;

---------------------------------------------------------
create or replace package body pachet_ex14 as
    type v_coduri is varray(60) of number;
    type matrix_liceeni is varray(60) of v_coduri;

    vector_coduri v_coduri := v_coduri();
    matrice_liceeni matrix_liceeni := matrix_liceeni();

    type info_licean is record
        (
            id licean.id_licean%type,
            nume licean.nume%type,
            prenume licean.prenume%type,
            cheltuieli licean.cheltuieli_transport%type
        );

        type vect is varray(100) of info_licean;
        vect_info_tabara vect := vect();
    
    type v_vect is varray(100) of number;
    coduri v_vect := v_vect();

    type info_at is record(
        nume_atelier atelier.nume%type,
        liceeni v_vect
    );

    procedure voluntarSiLicean(cod tabara.id_tabara%type) is
        type vector_id is varray(100) of number;
        j number(2) := 1;
        k number(2) := 1;
        vector_id_lic vector_id := vector_id();
        verif_cod tabara.id_tabara%type;
        nume_lic licean.nume%type;
        prenume_lic licean.prenume%type;
        nume_vol licean.nume%type;
        prenume_vol licean.prenume%type;

    begin
        select id_tabara into verif_cod from tabara where id_tabara = cod;
        for i in (select id_licean from licean where id_tabara = cod) loop
            vector_id_lic.extend();
            vector_id_lic(j) := i.id_licean;
            j := j + 1;
        end loop;

        j := 1;
        
        for i in vector_id_lic.first..vector_id_lic.last loop
            matrice_liceeni.extend();
            k := 1;
            matrice_liceeni(j) := v_coduri();
            for x in (select id_voluntar from supervizeaza where id_licean = vector_id_lic(i)) loop
                matrice_liceeni(j).extend();
                
                
                matrice_liceeni(j)(k) := x.id_voluntar;
                k := k + 1;
            end loop;
            j := j + 1;
            end loop;

        for i in matrice_liceeni.first..matrice_liceeni.last loop
            select nume, prenume into nume_lic, prenume_lic
            from licean where id_licean = vector_id_lic(i);
            dbms_output.put_line('Liceanul ' || nume_lic || ' ' || prenume_lic || ' a fost supravegheat de: ');
            for j in matrice_liceeni(i).first..matrice_liceeni(i).last loop
                select nume, prenume into nume_vol, prenume_vol
                from voluntar where id_voluntar = matrice_liceeni(i)(j);
                dbms_output.put_line('Voluntarul: ' || nume_vol || ' ' || prenume_vol);
            end loop;
        end loop;

    exception
        when no_data_found then raise_application_error(-20001, 'Nu exista codul taberei introdus');
end voluntarSiLicean;

    function calcul_cheltuieli_transport(cod tabara.id_tabara%type)
return number is
        j number(2) := 1;
        total number(4) := 0;
        maxim number(4) := 0;
        nume_max licean.nume%type;
        prenume_max licean.prenume%type;
begin
    select id_tabara into maxim from tabara where id_tabara = cod;
    for i in (select id_licean, nume, prenume, cheltuieli_transport from licean where id_tabara = cod) loop
        vect_info_tabara.extend();
        vect_info_tabara(j).id:= i.id_licean;
        vect_info_tabara(j).nume := i.nume;
        vect_info_tabara(j).prenume := i.prenume;
        vect_info_tabara(j).cheltuieli := i.cheltuieli_transport;
        if  i.cheltuieli_transport is not null then 
            total := total + i.cheltuieli_transport;
        end if;
        j := j + 1;
    end loop;

        for i in vect_info_tabara.first..vect_info_tabara.last loop
            if vect_info_tabara(i).cheltuieli > maxim then 
                maxim := vect_info_tabara(i).cheltuieli;
                nume_max := vect_info_tabara(i).nume;
                prenume_max := vect_info_tabara(i).prenume;
            end if;
        end loop;

    dbms_output.put_line('Elevul care a primit cea mai mare decontare pe transport (' ||maxim|| ' RON) ' || 'este ' || nume_max ||' ' || prenume_max);

    return total;

    exception
        when no_data_found then raise_application_error(-20001, 'Nu exista codul taberei introdus');
end calcul_cheltuieli_transport;

    procedure sortare_specialisti
    is
    type vector_sal is varray(100) of specialist.salariu%type;
    type vector_cod is varray(100) of specialist.id_specialist%type;

    v_sal vector_sal := vector_sal();
    v_cod vector_cod := vector_cod();
    j number(2) := 1;
    cursor c 
        is select id_specialist, salariu from
        specialist;

    aux_sal specialist.salariu%type;
    aux_cod specialist.id_specialist%type;

    nume_s specialist.nume%type;
    prenume_s specialist.prenume%type;

begin
    for i in c loop
        v_sal.extend();
        v_cod.extend();
        v_sal(j) := i.salariu;
        v_cod(j) := i.id_specialist;
        j := j + 1;
    end loop;

    for i in v_sal.first..v_sal.last loop
        for j in i+1..v_sal.last loop
            if v_sal(i) > v_sal(j) then 
                aux_sal := v_sal(j);
                v_sal(j) := v_sal(i);
                v_sal(i) := aux_sal;

                aux_cod := v_cod(j);
                v_cod(j) := v_cod(i);
                v_cod(i) := aux_cod;
            end if;
        end loop;
    end loop;

    dbms_output.put_line('Specialistii sortati crescator in functie de salariu sunt dupa cum urmeaza: ');
    for i in v_cod.first..v_cod.last loop
        select nume, prenume into nume_s, prenume_s
        from specialist where id_specialist = v_cod(i);

    dbms_output.put_line(nume_s || ' ' ||prenume_s || ' cu salariul ' || v_sal(i));
    end loop;

end sortare_specialisti;

function atelier_cautat
return atelier.nume%type is
    
    nume_at atelier.nume%type;
    cod_at atelier.id_atelier%type;
    numar number(2);
    j number(2) := 1;
    info_atelier info_at;
    nume_lic varchar2(100);
    prenume_lic varchar2(100);
begin
    select * into cod_at, nume_at, numar from (select id_atelier, nume, count(*) nr
    from se_inscrie join atelier using(id_atelier)

    group by id_atelier, nume
    order by nr desc)
    where rownum = 1;

    for i in (select id_licean from se_inscrie where id_atelier = cod_at) loop
        coduri.extend();
        coduri(j) := i.id_licean;
        j := j +1;
    end loop;

    info_atelier.nume_atelier := nume_at;
    info_atelier.liceeni := coduri;

    for i in info_atelier.liceeni.first..info_atelier.liceeni.last loop
        select nume, prenume into nume_lic, prenume_lic
        from licean where id_licean = info_atelier.liceeni(i);
        dbms_output.put_line('Elevul ' || nume_lic || ' ' ||prenume_lic);
    end loop;

    return info_atelier.nume_atelier;

end atelier_cautat;


end pachet_ex14;

--functie care calculeaza totalul transportului acoperit pentru elevii participanti la o tabara
begin
dbms_output.put_line('Totalul decontat elevilor este de ' || pachet_ex14.calcul_cheltuieli_transport(20));
end;

execute pachet_ex14.voluntarSiLicean(20);

--functie care returneaza atelierul cel mai cautat de elevi si elevii care au participat la acesta
begin
    dbms_output.put_line(pachet_ex14.atelier_cautat);
end;

execute pachet_ex14.sortare_specialisti;
