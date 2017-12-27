-- Generated by Oracle SQL Developer Data Modeler 17.3.0.261.1541
--   at:        2017-12-27 16:42:52 CET
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



CREATE TABLE czesci (
    id_czesci    CHAR(10 CHAR) NOT NULL,
    wartosc      FLOAT NOT NULL,
    producent    CHAR(10 CHAR),
    model_auta   CHAR(10 CHAR),
    nazwa        CHAR(10 CHAR),
    ilosc        INTEGER NOT NULL
);

ALTER TABLE czesci ADD CONSTRAINT czesci_pk PRIMARY KEY ( id_czesci );

CREATE TABLE czesci_uzyte (
    czesci_id_czesci          CHAR(10 CHAR) NOT NULL,
    naprawa_id_naprawy        INTEGER NOT NULL,
    ilosc                     INTEGER NOT NULL,
    naprawa_pracownik_pesel   CHAR(11) NOT NULL,
    naprawa_pojazd_vim        CHAR(15) NOT NULL
);

ALTER TABLE czesci_uzyte
    ADD CONSTRAINT czesci_uzyte_pk PRIMARY KEY ( czesci_id_czesci,
    naprawa_id_naprawy,
    naprawa_pracownik_pesel,
    naprawa_pojazd_vim );

CREATE TABLE hrt (
    nazwa   CHAR(10 CHAR) NOT NULL
);

ALTER TABLE hrt ADD CONSTRAINT hrt_pk PRIMARY KEY ( nazwa );

CREATE TABLE klient (
    pesel    CHAR(11) NOT NULL,
    nr_tel   CHAR(9 CHAR) NOT NULL,
    miasto   CLOB NOT NULL
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( pesel );

CREATE TABLE mycie_pojazdu (
    data              DATE NOT NULL,
    pracownik_pesel   CHAR(11) NOT NULL,
    pojazd_vim        CHAR(15) NOT NULL
);

ALTER TABLE mycie_pojazdu ADD CONSTRAINT mycie_pojazdu_pk PRIMARY KEY ( pojazd_vim );

CREATE TABLE naprawa (
    id_naprawy        INTEGER NOT NULL,
    data              DATE NOT NULL,
    pracownik_pesel   CHAR(11) NOT NULL,
    pojazd_vim        CHAR(15) NOT NULL
);

ALTER TABLE naprawa
    ADD CONSTRAINT naprawa_pk PRIMARY KEY ( id_naprawy,
    pracownik_pesel,
    pojazd_vim );

CREATE TABLE osoba (
    pesel      CHAR(11) NOT NULL,
    imie       CHAR(15 CHAR) NOT NULL,
    nazwisko   CHAR(20 CHAR) NOT NULL,
    typ        CHAR(1 CHAR) NOT NULL
);

ALTER TABLE osoba ADD CONSTRAINT osoba_pk PRIMARY KEY ( pesel );

CREATE TABLE pojazd (
    vim              CHAR(15) NOT NULL,
    marka            CHAR(10 CHAR) NOT NULL,
    model            CHAR(10 CHAR),
    kolor            CHAR(10 CHAR),
    data_produkcji   DATE,
    przebieg         NUMBER(1,1),
    rodzaj_pojazdu   CHAR(10 CHAR),
    poj_silinka      FLOAT(1),
    moc              FLOAT(1)
);

ALTER TABLE pojazd ADD CONSTRAINT pojazd_pk PRIMARY KEY ( vim );

CREATE TABLE pracownik (
    pesel    CHAR(11) NOT NULL,
    pensja   FLOAT NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( pesel );

CREATE TABLE przeglad (
    id_przegladu      INTEGER NOT NULL,
    data              DATE NOT NULL,
    pracownik_pesel   CHAR(11) NOT NULL,
    pojazd_vim        CHAR(15) NOT NULL
);

ALTER TABLE przeglad ADD CONSTRAINT przeglad_pk PRIMARY KEY ( id_przegladu,
pojazd_vim );

CREATE TABLE umowa (
    id_umowy       INTEGER NOT NULL,
    data           DATE NOT NULL,
    klient_pesel   CHAR(11) NOT NULL,
    cena           FLOAT NOT NULL,
    pojazd_vim     CHAR(15) NOT NULL
);

ALTER TABLE umowa ADD CONSTRAINT umowa_pk PRIMARY KEY ( id_umowy,
pojazd_vim );

CREATE TABLE wiersz_zam (
    zamowienie_id_zam      INTEGER NOT NULL,
    czesci_id_czesci       CHAR(10 CHAR) NOT NULL,
    ile                    INTEGER NOT NULL,
    zamowienie_hrt_nazwa   CHAR(10 CHAR) NOT NULL
);

ALTER TABLE wiersz_zam
    ADD CONSTRAINT wiersz_zam_pk PRIMARY KEY ( zamowienie_id_zam,
    zamowienie_hrt_nazwa,
    czesci_id_czesci );

CREATE TABLE zamowienie (
    id_zam            INTEGER NOT NULL,
    data_zam          DATE NOT NULL,
    data_dostawy      DATE,
    pracownik_pesel   CHAR(11) NOT NULL,
    hrt_nazwa         CHAR(10 CHAR) NOT NULL
);

ALTER TABLE zamowienie ADD CONSTRAINT zamowienie_pk PRIMARY KEY ( id_zam,
hrt_nazwa );

ALTER TABLE czesci_uzyte
    ADD CONSTRAINT czesci_uzyte_czesci_fk FOREIGN KEY ( czesci_id_czesci )
        REFERENCES czesci ( id_czesci );

ALTER TABLE czesci_uzyte
    ADD CONSTRAINT czesci_uzyte_naprawa_fk FOREIGN KEY ( naprawa_id_naprawy,
    naprawa_pracownik_pesel,
    naprawa_pojazd_vim )
        REFERENCES naprawa ( id_naprawy,
        pracownik_pesel,
        pojazd_vim );

ALTER TABLE klient
    ADD CONSTRAINT klient_osoba_fk FOREIGN KEY ( pesel )
        REFERENCES osoba ( pesel );

ALTER TABLE mycie_pojazdu
    ADD CONSTRAINT mycie_pojazdu_pojazd_fk FOREIGN KEY ( pojazd_vim )
        REFERENCES pojazd ( vim );

ALTER TABLE mycie_pojazdu
    ADD CONSTRAINT mycie_pojazdu_pracownik_fk FOREIGN KEY ( pracownik_pesel )
        REFERENCES pracownik ( pesel );

ALTER TABLE naprawa
    ADD CONSTRAINT naprawa_pojazd_fk FOREIGN KEY ( pojazd_vim )
        REFERENCES pojazd ( vim );

ALTER TABLE naprawa
    ADD CONSTRAINT naprawa_pracownik_fk FOREIGN KEY ( pracownik_pesel )
        REFERENCES pracownik ( pesel );

ALTER TABLE pracownik
    ADD CONSTRAINT pracownik_osoba_fk FOREIGN KEY ( pesel )
        REFERENCES osoba ( pesel );

ALTER TABLE przeglad
    ADD CONSTRAINT przeglad_pojazd_fk FOREIGN KEY ( pojazd_vim )
        REFERENCES pojazd ( vim );

ALTER TABLE przeglad
    ADD CONSTRAINT przeglad_pracownik_fk FOREIGN KEY ( pracownik_pesel )
        REFERENCES pracownik ( pesel );

ALTER TABLE umowa
    ADD CONSTRAINT umowa_klient_fk FOREIGN KEY ( klient_pesel )
        REFERENCES klient ( pesel );

ALTER TABLE umowa
    ADD CONSTRAINT umowa_pojazd_fk FOREIGN KEY ( pojazd_vim )
        REFERENCES pojazd ( vim );

ALTER TABLE wiersz_zam
    ADD CONSTRAINT wiersz_zam_czesci_fk FOREIGN KEY ( czesci_id_czesci )
        REFERENCES czesci ( id_czesci );

ALTER TABLE wiersz_zam
    ADD CONSTRAINT wiersz_zam_zamowienie_fk FOREIGN KEY ( zamowienie_id_zam,
    zamowienie_hrt_nazwa )
        REFERENCES zamowienie ( id_zam,
        hrt_nazwa );

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_hrt_fk FOREIGN KEY ( hrt_nazwa )
        REFERENCES hrt ( nazwa );

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_pracownik_fk FOREIGN KEY ( pracownik_pesel )
        REFERENCES pracownik ( pesel );

CREATE OR REPLACE TRIGGER arc_fkarc_1_klient BEFORE
    INSERT OR UPDATE OF pesel ON klient
    FOR EACH ROW
DECLARE
    d   CHAR(1 CHAR);
BEGIN
    SELECT
        a.typ
    INTO
        d
    FROM
        osoba a
    WHERE
        a.pesel =:new.pesel;

    IF
        ( d IS NULL OR d <> 'K' )
    THEN
        raise_application_error(-20223,'FK KLIENT_OSOBA_FK in Table KLIENT violates Arc constraint on Table OSOBA - discriminator column TYP doesn''t have value ''K'''
);
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_pracownik BEFORE
    INSERT OR UPDATE OF pesel ON pracownik
    FOR EACH ROW
DECLARE
    d   CHAR(1 CHAR);
BEGIN
    SELECT
        a.typ
    INTO
        d
    FROM
        osoba a
    WHERE
        a.pesel =:new.pesel;

    IF
        ( d IS NULL OR d <> 'P' )
    THEN
        raise_application_error(-20223,'FK PRACOWNIK_OSOBA_FK in Table PRACOWNIK violates Arc constraint on Table OSOBA - discriminator column TYP doesn''t have value ''P'''
);
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0