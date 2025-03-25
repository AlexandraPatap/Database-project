--VERIFICAREA CONSTRANGERILOR PENTRU FIECARE TABELA IN PARTE

-----------GARA-----------

//verific PRIMARY KEY
insert into gara values(1,'Bucuresti');
/*
insert into gara values(1,'Bucuresti')
Error report -
ORA-00001: unique constraint (TEMA.GARA_PK) violated
*/

//verific NOT NULL pt oras
insert into gara values(null,null);

/*
insert into gara values(null,null)
Error at Command Line : 12 Column : 30
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."GARA"."ORAS")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------DEPARTAMENT-----------

//verific PRIMARY KEY
insert into departament values(101,'finante',1);

/*
insert into departament values(101,'finante',1)
Error report -
ORA-00001: unique constraint (TEMA.DEPARTAMENT_PK) violated
*/

//verific FOREIGN KEY pt gara
update departament set id_gara = 2 where id_departament=101;

/*
update departament set id_gara = 2 where id_departament=101
Error report -
ORA-02291: integrity constraint (TEMA.DEPARTAMENT_GARA_FK) violated - parent key not found
*/

//verific NOT NULL pt nume_departament
insert into departament values(null,null,1);

/*
insert into departament values(null,null,1)
Error at Command Line : 46 Column : 37
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."DEPARTAMENT"."NUME_DEPARTAMENT")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt id_gara
insert into departament values(101,'finante',null);

/*
insert into departament values(101,'finante',null)
Error at Command Line : 29 Column : 46
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."DEPARTAMENT"."ID_GARA")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------ANGAJAT-----------

//verific PRIMARY KEY
insert into angajat values(6020822225629,'Borcan','Madalina','controlor',101);

/*
insert into angajat values(6020822225629,'Borcan','Madalina','controlor',101)
Error report -
ORA-00001: unique constraint (TEMA.ANGAJAT_PK) violated
*/

//verific FOREIGN KEY pt departament
update angajat set id_departament=22 where cnp_angajat=6020822225629;

/*
update angajat set id_departament=22 where cnp_angajat=6020822225629
Error report -
ORA-02291: integrity constraint (TEMA.ANGAJAT_DEPARTAMENT_FK) violated - parent key not found
*/

//verific CHECK pentru nume, astfel incat acesta sa fie format doar din litere
insert into angajat values(6020822225769,'Borc66?an','Madalina','controlor',101);

/*
Error report -
ORA-02290: check constraint (TEMA.ANGAJAT_NUME_CK) violated
*/

//verific CHECK pentru prenume, astfel incat acesta sa fie format doar din litere
insert into angajat values(6020822225769,'Borcan','Mada66? lina','controlor',101);

/*
Error report -
ORA-02290: check constraint (TEMA.ANGAJAT_PRENUME_CK) violated
*/

//verific NOT NULL pt cnp_angajat
insert into angajat values(null,'Borcan','Madalina','controlor',101);

/*
insert into angajat values(null,'Borcan','Madalina','controlor',101)
Error at Command Line : 93 Column : 28
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."ANGAJAT"."CNP_ANGAJAT")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt nume
insert into angajat values(6020822225629,null,'Madalina','controlor',101);

/*
insert into angajat values(6020822225629,null,'Madalina','controlor',101)
Error at Command Line : 106 Column : 42
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."ANGAJAT"."NUME")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt prenume
insert into angajat values(6020822225629,'Borcan',null,'controlor',101);

/*
insert into angajat values(6020822225629,'Borcan',null,'controlor',101)
Error at Command Line : 119 Column : 51
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."ANGAJAT"."PRENUME")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt meserie
insert into angajat values(6020822225629,'Borcan','Madalina',null,101);

/*
insert into angajat values(6020822225629,'Borcan','Madalina',null,101)
Error at Command Line : 132 Column : 62
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."ANGAJAT"."MESERIE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt id_departament
insert into angajat values(6020822225629,'Borcan','Madalina','controlor',null);

/*
insert into angajat values(6020822225629,'Borcan','Madalina','controlor',null)
Error at Command Line : 145 Column : 74
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."ANGAJAT"."ID_DEPARTAMENT")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------DETALII ANGAJAT-----------

//verific PRIMARY KEY 
insert into detalii_angajat values (6020822225629,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'));

/*
insert into detalii_angajat values (6020822225629,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'))
Error report -
ORA-00001: unique constraint (TEMA.DETALII_ANGAJAT_PK) violated
*/

//verific FOREIGN KEY pt angajat
insert into detalii_angajat values (6020822225620,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'));

/*
insert into detalii_angajat values (6020822225620,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'))
Error report -
ORA-02291: integrity constraint (TEMA.DETALII_ANGAJAT_ANGAJAT_FK) violated - parent key not found
*/

//verific UNIQUE pentru telefon
update detalii_angajat set nr_telefon=0757465861 where cnp_angajat=5910619225734;

/*
update detalii_angajat set nr_telefon=0757465861 where cnp_angajat=5910619225734
Error report -
ORA-00001: unique constraint (TEMA.DETALII_ANGAJAT_NR_TELEFON_UN) violated
*/

//verific CHECK pentru data_nasterii ca angajatul sa fie major
update detalii_angajat set data_nasterii=TO_DATE('20/11/2024','DD/MM/YYYY') where cnp_angajat=5910619225734;

/*
Error report -
SQL Error: ORA-20001: Angajat minor, varsta nesesara 18 ani
ORA-06512: at "TEMA.TRG_BIU_DETALII_ANGAJAT", line 4
ORA-04088: error during execution of trigger 'TEMA.TRG_BIU_DETALII_ANGAJAT'
*/

//verific NOT NULL pt cnp_angajat
insert into detalii_angajat values (null,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'));

/*
insert into detalii_angajat values (null,0756392691,TO_DATE('22/08/2002','DD/MM/YYYY'))
Error at Command Line : 198 Column : 37
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."DETALII_ANGAJAT"."CNP_ANGAJAT")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt nr_telefon
insert into detalii_angajat values (6020822225629,null,TO_DATE('22/08/2002','DD/MM/YYYY'));

/*
insert into detalii_angajat values (6020822225629,null,TO_DATE('22/08/2002','DD/MM/YYYY'))
Error at Command Line : 211 Column : 51
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."DETALII_ANGAJAT"."NR_TELEFON")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt data_nasterii
insert into detalii_angajat values (6020822225629,0756392691,null);

/*
insert into detalii_angajat values (6020822225629,0756392691,null)
Error at Command Line : 224 Column : 62
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."DETALII_ANGAJAT"."DATA_NASTERII")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------TREN-----------

//verific PRIMARY KEY
insert into tren values (5641,'CFR',3,1,5910619225734);

/*
insert into tren values (5641,'CFR',3,1,5910619225734)
Error report -
ORA-00001: unique constraint (TEMA.TREN_PK) violated
*/

//verific FOREIGN KEY pt angajat
insert into tren values (5341,'CFR',3,1,5910619225722);

/*
insert into tren values (5341,'CFR',3,1,5910619225722)
Error report -
ORA-02291: integrity constraint (TEMA.TREN_ANGAJAT_FK) violated - parent key not found
*/

//verific FOREIGN KEY pt gara
insert into tren values (5341,'CFR',3,2,5910619225734);

/*
insert into tren values (5341,'CFR',3,2,5910619225734)
Error report -
ORA-02291: integrity constraint (TEMA.TREN_GARA_FK) violated - parent key not found
*/

//verific NOT NULL pt nr_tren
insert into tren values (null,'CFR',3,1,5910619225734);

/*
insert into tren values (null,'CFR',3,1,5910619225734)
Error at Command Line : 267 Column : 26
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."TREN"."NR_TREN")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt companie
insert into tren values (5641,null,3,1,5910619225734);

/*
insert into tren values (5641,null,3,1,5910619225734)
Error at Command Line : 280 Column : 31
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."TREN"."COMPANIE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt capacitate
insert into tren values (5641,'CFR',null,1,5910619225734);

/*
insert into tren values (5641,'CFR',null,1,5910619225734)
Error at Command Line : 293 Column : 37
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."TREN"."CAPACITATE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt id_gara
insert into tren values (5641,'CFR',3,null,5910619225734);

/*
insert into tren values (5641,'CFR',3,null,5910619225734)
Error at Command Line : 306 Column : 39
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."TREN"."ID_GARA")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt cnp_angajat
insert into tren values (5641,'CFR',3,1,null);

/*
insert into tren values (5641,'CFR',3,1,null)
Error at Command Line : 319 Column : 41
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."TREN"."CNP_ANGAJAT")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------MERS TRENURI-----------


//verific PRIMARY KEY
insert into mers_trenuri values(103, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,2,5641);

/*
insert into mers_trenuri values(103, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,2,5641)
Error report -
ORA-00001: unique constraint (TEMA.MERS_TRENURI_PK) violated
*/

//verific FOREIGN KEY pt tren
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,2,5625);

/*
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,2,5625)
Error at Command Line : 138 Column : 13
Error report -
SQL Error: ORA-01403: no data found
ORA-06512: at "TEMA.TRG_BIU_MERS_TRENURI", line 4
ORA-04088: error during execution of trigger 'TEMA.TRG_BIU_MERS_TRENURI'
01403. 00000 -  "no data found"
*Cause:    No data was found from the objects.
*Action:   There was no data from the objects which may be due to end of fetch.
*/

//verific o constrangere CHECK care a devenit doar TRIGGER pt verificarea cantitatii trenului sa nu fie depasita
DECLARE
    v_id_mers mers_trenuri.id_mers%TYPE;
    v_nr_rezervare rezervare.nr_rezervare%TYPE;
    v_cnp_pasager rezervare.cnp_pasager%TYPE;
BEGIN
    -- Inserare rezervare
    INSERT INTO rezervare 
    VALUES (NULL, TO_DATE('30/12/2024', 'DD/MM/YYYY'), 2, 3, 10, 6130202225348, 100)
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

/*
Error report -
ORA-20001: Capacitate tren depasita
ORA-06512: at "TEMA.TRG_BIU_MERS_TRENURI", line 7
ORA-04088: error during execution of trigger 'TEMA.TRG_BIU_MERS_TRENURI'
ORA-06512: at line 17
*/

//verific CHECK pentru data, astfel incat aceasta sa fie o data mai mare sau egala cu ziua curenta
insert into mers_trenuri values(null, TO_DATE('02/01/2025 10:43','DD/MM/YYYY HH24:MI'),0,2,5622);

/*
Error report -
SQL Error: ORA-20001: data invalida
ORA-06512: at "TEMA.TRG_BIU_MERS_TREN_DATA", line 4
ORA-04088: error during execution of trigger 'TEMA.TRG_BIU_MERS_TREN_DATA'
*/

//verific NOT NULL pt data
insert into mers_trenuri values(null, null,0,2,5641);

/*
insert into mers_trenuri values(null, null,0,2,5641)
Error at Command Line : 383 Column : 39
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."MERS_TRENURI"."DATA")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt locuri_ocupate
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),null,2,5641);

/*
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),null,2,5641)
Error at Command Line : 396 Column : 88
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."MERS_TRENURI"."LOCURI_OCUPATE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt peron
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,null,5641);

/*
insert into mers_trenuri values(null, TO_DATE('26/12/2024 19:43','DD/MM/YYYY HH24:MI'),0,null,5641)
Error at Command Line : 409 Column : 90
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."MERS_TRENURI"."PERON")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------PASAGER-----------

//verific PRIMARY KEY
insert into pasager values(6020202225372,'Pricop','Amalia',90);

/*
insert into pasager values(6020202225372,'Pricop','Amalia',90)
Error report -
ORA-00001: unique constraint (TEMA.PASAGER_PK) violated
*/

//verific CHECK pentru nume, astfel incat acesta sa fie format doar din litere
insert into pasager values(6020202225342,'Prio5?p','Amalia',90);

/*
Error report -
ORA-02290: check constraint (TEMA.PASAGER_NUME_CK) violated
*/

//verific CHECK pentru prenume, astfel incat acesta sa fie format doar din litere
insert into pasager values(6020202225342,'Pricop','Am?55 alia',90);

/*
Error report -
ORA-02290: check constraint (TEMA.PASAGER_PRENUME_CK) violated
*/

//verific NOT NULL pt cnp_pasager
insert into pasager values(null,'Pricop','Amalia',90);

/*
insert into pasager values(null,'Pricop','Amalia',90)
Error at Command Line : 434 Column : 28
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."PASAGER"."CNP_PASAGER")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt nume
insert into pasager values(6020202225333,null,'Amalia',90);

/*
insert into pasager values(6020202225333,null,'Amalia',90)
Error at Command Line : 447 Column : 42
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."PASAGER"."NUME")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt prenume
insert into pasager values(6020202225372,'Pricop',null,90);

/*
insert into pasager values(6020202225372,'Pricop',null,90)
Error at Command Line : 460 Column : 51
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."PASAGER"."PRENUME")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt reducere
insert into pasager values(6020202225372,'Pricop','Amalia',null);

/*
insert into pasager values(6020202225372,'Pricop','Amalia',null)
Error at Command Line : 473 Column : 60
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."PASAGER"."REDUCERE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/


-----------REZERVARE-----------

//verific PRIMARY KEY
insert into rezervare values(10000001,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,103);

/*
insert into rezervare values(10000001,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,103)
Error report -
ORA-00001: unique constraint (TEMA.REZERVARE_PK) violated
*/

//verific FOREIGN KEY pt pasager
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225322,103);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225322,103)
Error report -
ORA-02291: integrity constraint (TEMA.REZERVARE_PASAGER_FK) violated - parent key not found
*/

//verific FOREIGN KEY pt mers_trenuri
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,123);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,123)
Error report -
ORA-02291: integrity constraint (TEMA.REZERVARE_MERS_TRENURI_FK) violated - parent key not found
*/

//verific CHECK pentru ca data_rezervare sa fie mai mica sau egala cu data curenta
//deoarece cateodata poate nu se fac toate inserarile de rezervari la zi si se adauga toate in aceiasi zi in baza de date
//data trebuie sa fie o data din trecut
//data din rezervare este data la care s-a cumparat biletul nu data pentru care mers de tren s-a cumparat bilet
insert into rezervare values(null,TO_DATE('20/01/2025 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,103);

/*
Error report -
SQL Error: ORA-20001: data invalida
ORA-06512: at "TEMA.TRG_BIU_REZERVARE", line 4
ORA-04088: error during execution of trigger 'TEMA.TRG_BIU_REZERVARE'
*/

//verific NOT NULL pt data_rezervare
insert into rezervare values(null,null,1,2,10,6020202225372,103);

/*
insert into rezervare values(null,null,1,2,10,6020202225372,103)
Error at Command Line : 516 Column : 35
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."DATA_REZERVARE")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt nr_vagon
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),null,2,10,6020202225372,103);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),null,2,10,6020202225372,103)
Error at Command Line : 529 Column : 84
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."NR_VAGON")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt nr_loc
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,null,10,6020202225372,103);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,null,10,6020202225372,103)
Error at Command Line : 542 Column : 86
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."NR_LOC")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt plata
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,null,6020202225372,103);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,null,6020202225372,103)
Error at Command Line : 555 Column : 88
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."PLATA")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt cnp_pasager
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,null,103);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,null,103)
Error at Command Line : 568 Column : 91
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."CNP_PASAGER")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/

//verific NOT NULL pt id_mers
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,null);

/*
insert into rezervare values(null,TO_DATE('08/12/2024 19:43','DD/MM/YYYY HH24:MI'),1,2,10,6020202225372,null)
Error at Command Line : 581 Column : 105
Error report -
SQL Error: ORA-01400: cannot insert NULL into ("TEMA"."REZERVARE"."ID_MERS")
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
*/