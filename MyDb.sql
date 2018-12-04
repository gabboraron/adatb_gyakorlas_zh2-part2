select * from dolgozo;
select * from dolgozo2;

delete from dolgozo2 where jutalek is null;

--prim-e
create or replace function  prim(szam int) return int as
begin
    if(2 > szam) then
        return 0;
    end if;
    for i in 2..sqrt(szam) loop
        if(mod(szam, i) = 0) then
            return 0;
        end if;
    end loop;
    return 1;
end prim;

select prim(83) from dual;

----------
--lnko 

create or replace function lnko(szam1 int, szam2 int) return int as
    i int;
begin    
    if(szam1 > szam2) then
        FOR i in reverse 1..szam1 loop
            if((mod(szam1,i) = 0 ) and (mod(szam2,i) = 0)) then
                return i;
            end if;
        end loop;
    else
        FOR i in reverse 1..szam2 loop
            if((mod(szam1,i) = 0) and (mod(szam2,i) = 0)) then
                return i;
            end if;
        end loop;    
    end if;
    return 666;
end;

select lnko(80,100) from dual;


---fact
create or replace  function  fact(sz int) return int as
begin 
    if(sz = 1) then 
        return 1;
    else
        return sz*fact(sz-1);
    end if;
end;


select fact(5) from dual;



-- string keresese
create or replace function strsearch(str1 string, str2 string) return int as
    res int := 0;
begin
   for i in 1..length(str1)-length(str2)+1 loop
    if substr(str1, i, length(str2)) = str2 then
        res := res +1;
    end if;
   end loop;
   return res;
end;


select strsearch('alma fa alom','al') from dual;

--szovegbol osszeg
create or replace function osszeg(str varchar2) return number is
    res int := 0;
    i int;
    subs varchar(10);
begin
    for i in 1..length(str) loop
        if substr(str, i, 1) != '+' then
            subs := subs || substr(str, i, 1);
        else
            res := res + TO_NUMBER(subs);
            subs := '';
        end if;
    end loop;
    res := res + TO_NUMBER(subs);
    return res;
end;

select osszeg ('5+6+15') from dual;


--
select * from dolgozo2;
insert into dolgozo2 (oazon, dkod, dnev, belepes, fizetes) values (10, 1, 'KOVACS', sysdate, (select avg(fizetes) from dolgozo2 where oazon = 10));

update dolgozo2 set fizetes=fizetes*1.2 where oazon = 30;
---

accept idx  NUMBER prompt  'ADJ MAR VALAMIT (szam): ';

----

create or replace function kat_atlag(kat integer) return number is
    cursor curs1 is select* from dolgozo join fiz_kategoria on fizetes between also and felso where kategoria = kat;
    rec curs1%ROWTYPE;
    osszeg int := 0;
    db int := 0;
begin
    for rec in curs1 loop
        osszeg := osszeg + rec.fizetes;
        db := db +1;
    end loop;
    return osszeg/db;
end;
select * from fiz_kategoria;
select kat_atlag(5) from dual;