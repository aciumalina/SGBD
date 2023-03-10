--EXERCITIUL 1
DECLARE 
TYPE t_ind IS TABLE OF employees.employee_id%TYPE INDEX BY PLS_INTEGER;
coduri t_ind;
salariu_angajat_initial employees.salary%type;
salariu_angajat_ulterior employees.salary%type;
BEGIN
    with auxiliar as (select employee_id, commission_pct FROM employees order by salary)
    SELECT employee_id 
    BULK COLLECT INTO coduri
    from auxiliar
    where rownum <= 5 and commission_pct is null;
FOR i IN 1..5 LOOP
    select salary into salariu_angajat_initial
    from employees where
    employee_id = coduri(i);
    
    update employees
    set salary = salary + (salary * 5)/100
    where employee_id = coduri(i);
    
    select salary into salariu_angajat_ulterior
    from employees where
    employee_id = coduri(i);
    
    dbms_output.put_line('Angajatul cu codul ' || coduri(i) || ' a avut salariul ' || salariu_angajat_initial || ' si a fost actualizat la ' || salariu_angajat_ulterior);

DBMS_OUTPUT.NEW_LINE;
END LOOP;
END;

--EXERCITIUL 2

create type tip_orase_mac is table of varchar2(100);

create table excursie_mac
(cod_excursie number(4),
denumire VARCHAR2(20),
orase tip_orase_mac,
status VARCHAR2(20) constraint verif_status check(status in ('disponibila', 'anulata')))
nested table orase store as tabel_orase_mac;

--a
insert into excursie_mac values (10, 'Excursie Vara', tip_orase_mac('Brasov', 'Sibiu'), 'disponibila');

insert into excursie_mac values(20, 'Excursie Iarna', tip_orase_mac('Sinaia', 'Predeal', 'Busteni'), 'anulata');

insert into excursie_mac values(30, 'Tabara', tip_orase_mac('Timisoara', 'Arad', 'Oradea'), 'disponibila');

insert into excursie_mac values(40, 'Weekend Getaway', tip_orase_mac('Iasi', 'Piatra Neamt'), 'anulata');

insert into excursie_mac values (50, 'Girls Trip', tip_orase_mac('Milano', 'Rimini' ,'Roma'), 'disponibila');

--b.1 adaugare oras nou in lista

declare
    cod number(4) := &cod;
    
begin
    insert into table(select orase from excursie_mac where cod_excursie = cod) values ('&oras_nou');

end;  

--b.2 adaugare oras nou, al doilea din lista

declare
    cod number(4) := &cod;
    auxiliar tip_orase_mac := tip_orase_mac();
    copie tip_orase_mac := tip_orase_mac();
begin
    select orase
    into copie
    from excursie_mac
    where cod_excursie = cod;
    
    for i in 1..copie.count+1 loop
        auxiliar.extend();
        if i = 1 then auxiliar(i) := copie(i);
        elsif i = 2 then auxiliar(i) := '&oras_nou';
        else auxiliar(i) := copie(i-1);
        end if;
    end loop;
    
    update excursie_mac
    set orase = auxiliar
    where cod_excursie = cod;
    
end;

--b.3 inversare ordine a doua orase date
declare
     cod number(4) := &cod;
     oras1 varchar(100) := '&oras1';
     oras2 varchar2(100) := '&oras2';
     copie tip_orase_mac := tip_orase_mac();
     
begin
    select orase into copie from excursie_mac where cod_excursie = cod;
    
    for i in 1..copie.count loop
        if copie(i) = oras1 then copie(i) := oras2;
        elsif copie(i) = oras2 then copie(i) := oras1;
        end if;
    end loop;
    
    update excursie_mac set orase = copie where cod_excursie = cod;
    
end;


--b.4 eliminare oras specificat
declare
     cod number(4) := &cod;
     oras varchar(100) := '&oras';
     copie tip_orase_mac := tip_orase_mac();
     auxiliar tip_orase_mac := tip_orase_mac();
     indice number(2) := 1;
begin
    select orase into copie from excursie_mac where cod_excursie = cod;

    for i in 1..copie.count loop
        if copie(i) != oras then 
        auxiliar.extend;
        auxiliar(indice) := copie(i);
        indice := indice + 1;
        end if;
    end loop;
    
    update excursie_mac set orase = auxiliar where cod_excursie = cod;
end;

--c
declare
     cod number(4) := &cod;
     copie tip_orase_mac := tip_orase_mac();
begin
    select orase into copie from excursie_mac where cod_excursie = cod;
    
    dbms_output.put_line('Nr orase vizitate: ' || copie.count);
    for i in copie.first..copie.last loop
        dbms_output.put_line(copie(i));
    end loop;
    
end;

--d
declare 
    type vector is varray(5) of number;
    coduri vector := vector();
    copie tip_orase_mac := tip_orase_mac();
begin
    select cod_excursie bulk collect into coduri from excursie_mac;
    for i in coduri.first..coduri.last loop
        dbms_output.put_line(coduri(i));
        select orase into copie from excursie_mac where cod_excursie = coduri(i);
        for i in copie.first..copie.last loop
            dbms_output.put_line(copie(i));
        end loop;
    end loop;
        
end;

--e
declare
    type vector is varray(5) of number;
    excursii_de_anulat vector := vector();
    coduri vector := vector();
    minim_orase number(3) := 100;
    indice number(2) := 1;
    copie tip_orase_mac := tip_orase_mac();
begin
    select cod_excursie bulk collect into coduri from excursie_mac;
    for i in coduri.first..coduri.last loop
        select orase into copie from excursie_mac where cod_excursie = coduri(i);
        if copie.count < minim_orase 
            then minim_orase := copie.count;
            excursii_de_anulat.delete;
            excursii_de_anulat.extend;
            excursii_de_anulat(indice) := coduri(i);
            indice := indice + 1;
        elsif copie.count = minim_orase then
            excursii_de_anulat.extend;
            excursii_de_anulat(indice) := coduri(i);
            indice := indice + 1;
        end if;
    end loop;
    
    for i in excursii_de_anulat.first..excursii_de_anulat.last loop
        update excursie_mac
        set status = 'anulata'
        where cod_excursie = excursii_de_anulat(i);
    end loop;
    
end;

select * from excursie_mac;


--EXERCITIUL 3

create or replace type tip_orase_cam is varray(100) of varchar2(100);

create table excursie_cam (
cod_excursie number(4),
denumire VARCHAR2(20),
orase tip_orase_cam,
status VARCHAR2(20) constraint verificare_status check(status in ('disponibila', 'anulata')
));

--a
insert into excursie_cam values (10, 'Excursie Vara', tip_orase_cam('Brasov', 'Sibiu'), 'disponibila');

insert into excursie_cam values(20, 'Excursie Iarna', tip_orase_cam('Sinaia', 'Predeal', 'Busteni'), 'anulata');

insert into excursie_cam values(30, 'Tabara', tip_orase_cam('Timisoara', 'Arad', 'Oradea'), 'disponibila');

insert into excursie_cam values(40, 'Weekend Getaway', tip_orase_cam('Iasi', 'Piatra Neamt'), 'anulata');

insert into excursie_cam values (50, 'Girls Trip', tip_orase_cam('Milano', 'Rimini' ,'Roma'), 'disponibila');


select * from excursie_cam;

--b.1 adaugare nou oras in vector

declare 
    cod number(4) := &cod;
    copie tip_orase_cam := tip_orase_cam();
    
begin
    select orase
    into copie
    from excursie_cam
    where cod_excursie = cod;
    
    copie.extend;
    copie(copie.count) := '&oras';
    
    update excursie_cam
    set orase=copie
    where cod_excursie = cod;

end;

--b.2
declare
    cod number(4) := &cod;
    copie tip_orase_cam := tip_orase_cam();
    auxiliar tip_orase_cam := tip_orase_cam();
    
begin
    select orase
    into copie
    from excursie_cam
    where cod_excursie = cod;
    
    for i in 1..copie.count+1 loop
        auxiliar.extend();
        if i = 1 then auxiliar(i) := copie(i);
        elsif i = 2 then auxiliar(i) := '&oras_nou';
        else auxiliar(i) := copie(i-1);
        end if;
    end loop;
    
    update excursie_cam
    set orase = auxiliar
    where cod_excursie = cod;
end;


--b.3 inversare ordine orase
declare
     cod number(4) := &cod;
     oras1 varchar(100) := '&oras1';
     oras2 varchar2(100) := '&oras2';
     copie tip_orase_cam := tip_orase_cam();
     
begin
    select orase into copie from excursie_cam where cod_excursie = cod;
    
    for i in 1..copie.count loop
        if copie(i) = oras1 then copie(i) := oras2;
        elsif copie(i) = oras2 then copie(i) := oras1;
        end if;
    end loop;
    
    update excursie_cam set orase = copie where cod_excursie = cod;
    
end;

--b.4 eliminare oras specificat
declare
     cod number(4) := &cod;
     oras varchar(100) := '&oras';
     copie tip_orase_cam := tip_orase_cam();
     auxiliar tip_orase_cam := tip_orase_cam();
     indice number(2) := 1;
begin
    select orase into copie from excursie_cam where cod_excursie = cod;

    for i in 1..copie.count loop
        if copie(i) != oras then 
        auxiliar.extend;
        auxiliar(indice) := copie(i);
        indice := indice + 1;
        end if;
    end loop;
    
    update excursie_cam set orase = auxiliar where cod_excursie = cod;
end;

--c
declare
     cod number(4) := &cod;
     copie tip_orase_cam := tip_orase_cam();
begin
    select orase into copie from excursie_cam where cod_excursie = cod;
    
    dbms_output.put_line('Nr orase vizitate: ' || copie.count);
    for i in copie.first..copie.last loop
        dbms_output.put_line(copie(i));
    end loop;
    
end;

--d
declare 
    type vector is varray(5) of number;
    coduri vector := vector();
    copie tip_orase_cam := tip_orase_cam();
begin
    select cod_excursie bulk collect into coduri from excursie_cam;
    for i in coduri.first..coduri.last loop
        dbms_output.put_line(coduri(i));
        select orase into copie from excursie_cam where cod_excursie = coduri(i);
        for i in copie.first..copie.last loop
            dbms_output.put_line(copie(i));
        end loop;
    end loop;        
end;

--e
declare
    type vector is varray(5) of number;
    excursii_de_anulat vector := vector();
    coduri vector := vector();
    minim_orase number(3) := 100;
    indice number(2) := 1;
    copie tip_orase_cam := tip_orase_cam();
begin
    select cod_excursie bulk collect into coduri from excursie_cam;
    for i in coduri.first..coduri.last loop
        select orase into copie from excursie_cam where cod_excursie = coduri(i);
        if copie.count < minim_orase 
            then minim_orase := copie.count;
            excursii_de_anulat.delete;
            excursii_de_anulat.extend;
            excursii_de_anulat(indice) := coduri(i);
            indice := indice + 1;
        elsif copie.count = minim_orase then
            excursii_de_anulat.extend;
            excursii_de_anulat(indice) := coduri(i);
            indice := indice + 1;
        end if;
    end loop;
    
    for i in excursii_de_anulat.first..excursii_de_anulat.last loop
        update excursie_cam
        set status = 'anulata'
        where cod_excursie = excursii_de_anulat(i);
    end loop;
end;
