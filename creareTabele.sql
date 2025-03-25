CREATE TABLE angajat (
    cnp_angajat    NUMBER(13) NOT NULL,
    nume           VARCHAR2(15) NOT NULL,
    prenume        VARCHAR2(15) NOT NULL,
    meserie        VARCHAR2(30) NOT NULL,
    id_departament NUMBER(3) NOT NULL
)
LOGGING;

ALTER TABLE angajat
    ADD CONSTRAINT angajat_nume_ck CHECK ( REGEXP_LIKE ( nume,
                                                         '^[A-Za-z]+$' ) );

ALTER TABLE angajat
    ADD CONSTRAINT angajat_prenume_ck CHECK ( REGEXP_LIKE ( prenume,
                                                            '^[A-Za-z]+$' ) );
                                                            
ALTER TABLE angajat ADD CONSTRAINT angajat_pk PRIMARY KEY ( cnp_angajat );

CREATE TABLE departament (
    id_departament   NUMBER(3) NOT NULL,
    nume_departament VARCHAR2(20) NOT NULL,
    id_gara          NUMBER(3) NOT NULL
)
LOGGING;

ALTER TABLE departament ADD CONSTRAINT departament_pk PRIMARY KEY ( id_departament );

CREATE TABLE detalii_angajat (
    cnp_angajat   NUMBER(13) NOT NULL,
    nr_telefon    NUMBER(10) NOT NULL,
    data_nasterii DATE NOT NULL
)
LOGGING;

ALTER TABLE detalii_angajat
    ADD CONSTRAINT detalii_data_nasterii_ck CHECK ( months_between(TO_DATE('28.10.2024', 'DD.MM.YYYY'), data_nasterii) / 12 > 18 );

CREATE UNIQUE INDEX detalii_angajat__idx ON
    detalii_angajat (
        cnp_angajat
    ASC )
        LOGGING;

ALTER TABLE detalii_angajat ADD CONSTRAINT detalii_angajat_pk PRIMARY KEY ( cnp_angajat );

ALTER TABLE detalii_angajat ADD CONSTRAINT detalii_angajat_nr_telefon_un UNIQUE ( nr_telefon );

CREATE TABLE gara (
    id_gara NUMBER(3) NOT NULL,
    oras    VARCHAR2(15 CHAR) NOT NULL
)
LOGGING;

ALTER TABLE gara
    ADD CONSTRAINT gara_oras_ck CHECK ( REGEXP_LIKE ( oras,
                                                      '^[A-Z a-z]+$' ) );
                                                      
ALTER TABLE gara ADD CONSTRAINT gara_pk PRIMARY KEY ( id_gara );

CREATE TABLE mers_trenuri (
    id_mers        NUMBER(3) NOT NULL,
    data           DATE NOT NULL,
    locuri_ocupate NUMBER(3) NOT NULL,
    peron          NUMBER(2) NOT NULL,
    nr_tren        NUMBER(4)
)
LOGGING;

ALTER TABLE mers_trenuri
    ADD CONSTRAINT mers_trenuri_data_ck CHECK ( data >= TO_DATE('28.10.2024', 'DD.MM.YYYY') );

ALTER TABLE mers_trenuri ADD CONSTRAINT mers_trenuri_pk PRIMARY KEY ( id_mers );

CREATE TABLE pasager (
    cnp_pasager NUMBER(13) NOT NULL,
    nume        VARCHAR2(15) NOT NULL,
    prenume     VARCHAR2(15) NOT NULL,
    reducere    NUMBER(3) NOT NULL
)
LOGGING;

ALTER TABLE pasager
    ADD CONSTRAINT pasager_nume_ck CHECK ( REGEXP_LIKE ( nume,
                                                         '^[A-Za-z]+$' ) );

ALTER TABLE pasager
    ADD CONSTRAINT pasager_prenume_ck CHECK ( REGEXP_LIKE ( prenume,
                                                            '^[A-Za-z]+$' ) );

ALTER TABLE pasager ADD CONSTRAINT pasager_pk PRIMARY KEY ( cnp_pasager );

CREATE TABLE rezervare (
    nr_rezervare   NUMBER(8) NOT NULL,
    data_rezervare DATE NOT NULL,
    nr_vagon       NUMBER(2) NOT NULL,
    nr_loc         NUMBER(3) NOT NULL,
    plata          NUMBER(4, 2) NOT NULL,
    cnp_pasager    NUMBER(13) NOT NULL,
    id_mers        NUMBER(3) NOT NULL
)
LOGGING;

ALTER TABLE rezervare
    ADD CONSTRAINT rezervare_data_ck CHECK ( data_rezervare <= TO_DATE('30.01.2025', 'DD.MM.YYYY') );

ALTER TABLE rezervare ADD CONSTRAINT rezervare_pk PRIMARY KEY ( nr_rezervare );

CREATE TABLE tren (
    nr_tren     NUMBER(4) NOT NULL,
    companie    VARCHAR2(15) NOT NULL,
    capacitate  NUMBER(3) NOT NULL,
    id_gara     NUMBER(3) NOT NULL,
    cnp_angajat NUMBER(13) NOT NULL
)
LOGGING;

ALTER TABLE tren ADD CONSTRAINT tren_pk PRIMARY KEY ( nr_tren );

ALTER TABLE angajat
    ADD CONSTRAINT angajat_departament_fk FOREIGN KEY ( id_departament )
        REFERENCES departament ( id_departament )
    NOT DEFERRABLE;

ALTER TABLE departament
    ADD CONSTRAINT departament_gara_fk FOREIGN KEY ( id_gara )
        REFERENCES gara ( id_gara )
    NOT DEFERRABLE;

ALTER TABLE detalii_angajat
    ADD CONSTRAINT detalii_angajat_angajat_fk FOREIGN KEY ( cnp_angajat )
        REFERENCES angajat ( cnp_angajat )
    NOT DEFERRABLE;

ALTER TABLE mers_trenuri
    ADD CONSTRAINT mers_trenuri_tren_fk FOREIGN KEY ( nr_tren )
        REFERENCES tren ( nr_tren )
    NOT DEFERRABLE;

ALTER TABLE rezervare
    ADD CONSTRAINT rezervare_mers_trenuri_fk FOREIGN KEY ( id_mers )
        REFERENCES mers_trenuri ( id_mers )
    NOT DEFERRABLE;

ALTER TABLE rezervare
    ADD CONSTRAINT rezervare_pasager_fk FOREIGN KEY ( cnp_pasager )
        REFERENCES pasager ( cnp_pasager )
    NOT DEFERRABLE;

ALTER TABLE tren
    ADD CONSTRAINT tren_angajat_fk FOREIGN KEY ( cnp_angajat )
        REFERENCES angajat ( cnp_angajat )
    NOT DEFERRABLE;

ALTER TABLE tren
    ADD CONSTRAINT tren_gara_fk FOREIGN KEY ( id_gara )
        REFERENCES gara ( id_gara )
    NOT DEFERRABLE;

CREATE OR REPLACE TRIGGER Trg_biu_detalii_angajat 
    BEFORE INSERT OR UPDATE ON Detalii_angajat 
    FOR EACH ROW 
BEGIN
IF( MONTHS_BETWEEN(SYSDATE,:new.data_nasterii)/12<18 )
THEN
RAISE_APPLICATION_ERROR( -20001,
'Angajat minor, varsta nesesara 18 ani' );
END IF;
END ;
/

CREATE OR REPLACE TRIGGER Trg_biu_mers_tren_data 
    BEFORE INSERT OR UPDATE ON Mers_trenuri 
    FOR EACH ROW 
BEGIN
IF( SYSDATE >:new.data )
THEN
RAISE_APPLICATION_ERROR( -20001,
'data invalida' );
END IF;
END ;
/

CREATE OR REPLACE TRIGGER Trg_biu_mers_trenuri 
    BEFORE INSERT OR UPDATE ON Mers_trenuri 
    FOR EACH ROW 
DECLARE 
    v_capacitate tren.capacitate%type;
BEGIN
select capacitate into v_capacitate from tren where nr_tren = :new.nr_tren;
IF( :new.locuri_ocupate >  v_capacitate)
THEN
RAISE_APPLICATION_ERROR( -20001,
'Capacitate tren depasita ' );
END IF;
END; 
/

CREATE OR REPLACE TRIGGER Trg_biu_rezervare 
    BEFORE INSERT OR UPDATE ON Rezervare 
    FOR EACH ROW 
BEGIN
IF (SYSDATE <=:new.data_rezervare)
THEN
RAISE_APPLICATION_ERROR( -20001,
'data invalida' );
END IF;
END ; 
/

CREATE SEQUENCE departament_id_departament_seq START WITH 101 INCREMENT BY 11 MAXVALUE 999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER departament_id_departament_trg BEFORE
    INSERT ON departament
    FOR EACH ROW
    WHEN ( new.id_departament IS NULL )
BEGIN
    :new.id_departament := departament_id_departament_seq.nextval;
END;
/

CREATE SEQUENCE gara_id_gara_seq START WITH 1 INCREMENT BY 10 MAXVALUE 999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER gara_id_gara_trg BEFORE
    INSERT ON gara
    FOR EACH ROW
    WHEN ( new.id_gara IS NULL )
BEGIN
    :new.id_gara := gara_id_gara_seq.nextval;
END;
/

CREATE SEQUENCE mers_trenuri_id_mers_seq START WITH 100 MAXVALUE 999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER mers_trenuri_id_mers_trg BEFORE
    INSERT ON mers_trenuri
    FOR EACH ROW
    WHEN ( new.id_mers IS NULL )
BEGIN
    :new.id_mers := mers_trenuri_id_mers_seq.nextval;
END;
/

CREATE SEQUENCE rezervare_nr_rezervare_seq START WITH 10000001 INCREMENT BY 10 MAXVALUE 99999999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezervare_nr_rezervare_trg BEFORE
    INSERT ON rezervare
    FOR EACH ROW
    WHEN ( new.nr_rezervare IS NULL )
BEGIN
    :new.nr_rezervare := rezervare_nr_rezervare_seq.nextval;
END;
/
