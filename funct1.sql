CREATE OR REPLACE FUNCTION wartosc_auta(p_id_pojazdu IN NUMBER)
	RETURN NUMBER 
	IS koszt number(15)
	CURSOR pojazd IS
		select id_pojazdu,id_czesci,ilosc,wartosc
		from pojazdy
		left join (naprawa left join (czesci_uzyte (left join czesci references(ID_CZESCI))REFERENCES (ID_NAPRAWY)) REFERENCES (id_pojazdu))
		where id_pojazdu=p_id_pojazdu
	
	begin
		open pojazd;
		fetch pojazd into dane;
		close pojazd;
		
		for c1 in dane:
		LOOP
			koszt= koszt + c1.ilosc*c1.wartosc;
		END LOOP
		
		RETURN koszt
	END
