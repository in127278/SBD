CREATE OR REPLACE PROCEDURE komu_podwyzka(val)
	
	begin
		select pesel,count( data)
		from osoba
		left join naprawa  REFERENCES (pesel)
		where EXTRACT(MONTH FROM DATE data) = val
		group by pesel
	end
	
	