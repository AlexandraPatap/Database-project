insert into gara values (null,'Iasi');
insert into gara values (null,'Pascani');
insert into gara values (null,'Targu Frumos');
insert into gara values (null,'Bacau');
insert into gara values (null,'Galati');

insert into departament values (null,'logistica',1);
insert into departament values (null,'hr',1);
insert into departament values (null,'finante',11);
insert into departament values (null,'hr',11);
insert into departament values (null,'finante',21);

insert into angajat values (6020822225629, 'Popescu','Ana','femeie de serviciu',101);
insert into detalii_angajat values(6020822225629,0757465861,TO_DATE('22/08/2002','DD/MM/YYYY'));

insert into angajat values (5910619225734, 'Baciu','Bogdan','sofer',101);
insert into detalii_angajat values(5910619225734,0755425862,TO_DATE('19/06/1991','DD/MM/YYYY'));

insert into angajat values (5900303228726, 'Ionescu','Mihai','controlor',123);
insert into detalii_angajat values(5900303228726,0755435726,TO_DATE('03/03/1990','DD/MM/YYYY'));

insert into angajat values (5010313226751, 'Pavel','Andrei','mecanic',101);
insert into detalii_angajat values(5010313226751,0746770978,TO_DATE('13/03/2001','DD/MM/YYYY'));

insert into angajat values (6990223226823, 'Petrescu','Elena','sofer',101);
insert into detalii_angajat values(6990223226823,0735893224,TO_DATE('23/02/1999','DD/MM/YYYY'));

insert into tren values (5641,'CFR',3,1,5910619225734);
insert into tren values (1662,'CFR',152,1,6020822225629);
insert into tren values (5622,'Regio Calatori',262,11,5900303228726);
insert into tren values (1763,'CFR',230,1,6990223226823);
insert into tren values (5418,'CFR',160,41,5910619225734);

insert into mers_trenuri values(null, TO_DATE('05/01/2025 19:43','DD/MM/YYYY HH24:MI'),0,2,5641);
insert into mers_trenuri values(null, TO_DATE('09/01/2025 16:51','DD/MM/YYYY HH24:MI'),0,4,1662);
insert into mers_trenuri values(null, TO_DATE('10/01/2025 18:46','DD/MM/YYYY HH24:MI'),0,1,5641);
insert into mers_trenuri values(null, TO_DATE('26/01/2025 12:55','DD/MM/YYYY HH24:MI'),0,3,1763);
insert into mers_trenuri values(null, TO_DATE('05/02/2025 8:00','DD/MM/YYYY HH24:MI'),0,1,5418);

insert into pasager values(6020202225372,'Pricop','Amalia',90);
insert into pasager values(6130202225348,'Borcan','Vasile',100);
insert into pasager values(5890714116297,'Vasilescu','Marcel',0);
insert into pasager values(5031230226782,'Georgescu','Bogdan',90);
insert into pasager values(6920822225914,'Morariu','Antonia',0);
insert into pasager values(5820712222585,'Popescu','Marius',0);

//pentru a insera in tabela rezervare, suntem nevoiti sa facem un insert in tabela rezervare, 
//un update in tabela mers_trenuri si un update in tabela rezervare 
//astfel vom folosi tranzactii pentru fiecare inserare

//am folosit %TYPE pentru ca fiecare variabila in parte sa fie de acelasi tip cu atributul pe care il va stoca
//am declarat o variabila pentru ca mai tarziu sa verific daca s-a facut insertul pentru un mers de tren existent
DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('08/12/2024','DD/MM/YYYY'),1,2,10,6020202225372,100)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('28/11/2024 18:46','DD/MM/YYYY HH24:MI'),2,5,8.5,6130202225348,102)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('19/11/2024 19:43','DD/MM/YYYY HH24:MI'),1,1,10,5890714116297,100)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('21/12/2024','DD/MM/YYYY'),1,1,10,5031230226782,100)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('20/12/2024','DD/MM/YYYY'),1,1,10,6920822225914,102)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('12/12/2024 10:43','DD/MM/YYYY HH24:MI'),2,22,8.5,6020202225372,101)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE 
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('28/11/2024 18:46','DD/MM/YYYY HH24:MI'),2,5,22,6130202225348,103)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('28/12/2024 18:46','DD/MM/YYYY HH24:MI'),2,7,22,6920822225914,103)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;

DECLARE
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (null,TO_DATE('01/01/2025','DD/MM/YYYY'),2,7,8.5,5820712222585,101)
    RETURNING nr_rezervare, cnp_pasager INTO v_nr_rezervare, v_cnp_pasager;

    -- Ob?inere id_mers corespunzãtor rezervãrii
    SELECT id_mers 
    INTO v_id_mers
    FROM rezervare 
    WHERE nr_rezervare = v_nr_rezervare;

    -- Verificare dacã existã mersul trenului
    IF v_id_mers IS NOT NULL THEN
        -- Actualizare locuri ocupate
        UPDATE mers_trenuri
        SET locuri_ocupate = locuri_ocupate + 1
        WHERE id_mers = v_id_mers;

        -- Actualizare plata
        UPDATE rezervare
        SET plata = plata - (
            SELECT p.reducere 
            FROM pasager p
            WHERE cnp_pasager = v_cnp_pasager
        ) * plata / 100
        WHERE nr_rezervare = v_nr_rezervare;

    ELSE
        -- Dacã nu existã, rollback tranzac?ie
        ROLLBACK;
    END IF;

    -- Commit tranzac?ie principalã
    COMMIT;
END;