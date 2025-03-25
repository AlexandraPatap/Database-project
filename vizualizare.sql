-------SELECTIA MERSURILOR DE TREN EXISTENTE

select * from mers_trenuri;

-------AFISAREA NUMARULUI DE TRENURI DE PLECARE SI NUMARULUI TRENURI DE SOSIRE IN GARA

select count(m.nr_tren) as "NUMAR TRENURI SOSIRE"
from mers_trenuri m join tren t on m.nr_tren=t.nr_tren 
where t.id_gara != (
        select id_gara
        from gara
        where oras='Iasi'
        );
select count(m.nr_tren) as "NUMAR TRENURI PLECARE"
from mers_trenuri m join tren t on m.nr_tren=t.nr_tren 
where t.id_gara = (
        select id_gara
        from gara
        where oras='Iasi'
        );

-------PROCENT OCUPARE PENTRU MERSURILE DE TREN PENTRU FIECARE TREN

select m.id_mers, m.nr_tren, t.capacitate, m.locuri_ocupate, t.capacitate-m.locuri_ocupate as "LOCURI LIBERE", (m.locuri_ocupate/t.capacitate)*100 as "PROCENT OCUPARE"
from tren t join  mers_trenuri m on m.nr_tren=t.nr_tren
order by m.nr_tren , m.id_mers ;

-------SUMELE TOTALE DE BILETE PENTRU FIECARE MERS DE TREN

select m.id_mers, t.nr_tren, sum(r.plata) as "SUMA BILETELOR"
from tren t join mers_trenuri m on t.nr_tren=m.nr_tren
            join rezervare r on m.id_mers=r.id_mers
group by m.id_mers, t.nr_tren
order by sum(r.plata) desc;

-------NUMARUL DE TRENURI DETINUT DE FIECARE COMPANIE IN FIECARE GARA

select g.oras, t.companie, count(t.nr_tren) as "NUMAR TRENURI"
from tren t join gara g on t.id_gara=g.id_gara
group by g.oras, t.companie
order by t.companie;

-------PASAGERII SI CE REZERVARI AU FACUTE LA TRENURI

select p.nume, p.prenume, t.nr_tren, r.nr_vagon, r.nr_loc, m.data
from tren t join mers_trenuri m on t.nr_tren=m.nr_tren
       join rezervare r on r.id_mers=m.id_mers
       join pasager p on p.cnp_pasager=r.cnp_pasager
order by p.nume asc, t.nr_tren desc;

-------PASAGERII DE LA UN MERS DE TREN SI CE LOC IN TREN AU
----103

select p.nume, p.prenume, t.nr_tren, r.nr_vagon, r.nr_loc, m.data
from tren t join mers_trenuri m on t.nr_tren=m.nr_tren
       join rezervare r on r.id_mers=m.id_mers
       join pasager p on p.cnp_pasager=r.cnp_pasager
where m.id_mers=103
order by p.nume asc, t.nr_tren desc;

-------ANGAJATII PE FIECARE TREN DIN CARE DEPARTAMENT FAC PARTE SI CE MESERIE AU

select t.nr_tren, d.nume_departament, t.cnp_angajat, a.nume, a.prenume, a.meserie
from tren t join angajat a on t.cnp_angajat=a.cnp_angajat
            join departament d on a.id_departament=d.id_departament
order by t.nr_tren;

-------ANULAREA UNUI TREN

//aceasta actiune se face printr-o tranzactie
//intai vom sterge toate rezervarile la mersul de tren ales 
//ulterior vom cauta pasagerii ce au rezervare la acel mers de tren si nu mai au alte rezervari si ii vom sterge din baza de date
//la final vom sterge si mersul de tren

--pas 1: preluam mersul de tren ce se anuleaza
accept v_id_mers prompt 'Introduceti indexul mersului de tren ce se va anula:';
    
begin
    --pas 2: cautam si stergem rezervarile facute la mersul de tren
    delete from rezervare
    where id_mers = &v_id_mers;
    
    --pas 3: cautam pasagerii fara alte rezervari si ii stergem
    delete from pasager
    where cnp_pasager in (
            select cnp_pasager
            from rezervare 
            where cnp_pasager not in(
                select cnp_pasager
                from rezervare
                where id_mers != &v_id_mers
            )
            group by cnp_pasager
            having count(*) = 1
    );
    
    --pas 4: stergem mersul de tren
    delete from mers_trenuri
    where id_mers = &v_id_mers;
    
    --commit tranzactie
    commit;
end;


-------ANGAJAREA UNUI NOU ANGAJAT SI INLOCUIREA CELUI VECHI

//angajarea unui nou angajat se realizeaza printr-o tranzactie
//mai intai cautam sa vedem ce angajat inlocuim , introducem de la tastatura cnp_angajat ce va fi concediat
//ulterior inseram un nou angajat cu detaliile aferente 
//dupa inlocuim vechiul angajat cu noul angajat
//la final stergem angajatul vechi

 --pas 1: cautam vechiul angajat care lucreaza deja
accept v_cnp_vechi prompt 'Introduceti cnp_angajat ce va fi concediat:';
declare
    v_cnp_angajat angajat.cnp_angajat%TYPE;
begin
    --pas 2: inseram un nou angajat si detaliile aferente acestuia
    insert into angajat values(6801202227853, 'Ceaun','Maria','femeie de serviciu',101)
    returning cnp_angajat into v_cnp_angajat;
    insert into detalii_angajat values(6801202227853,0738925860,TO_DATE('02/12/1980','DD/MM/YYYY'));

    --pas 3: inlocuim vechiul angajat cu cel nou
    update tren
    set cnp_angajat = v_cnp_angajat
    where cnp_angajat = &v_cnp_vechi;

    --pas 4: stergem vechiul angajat si detaliile aferente acestuia
    delete from detalii_angajat
    where cnp_angajat = &v_cnp_vechi;
    delete from angajat
    where cnp_angajat = &v_cnp_vechi;

    --commit tranzactie
    commit;
end;