{
ID: vkanapo001
PROG: milk
}

Program MILK;

type
  Telem = record
    kiek, kain : longint
  end;
  Tpien = array [1 .. 5000] of Telem;

var
  ats, viso, kiekis : longint;
  pien : Tpien;

procedure nuskaitymas (var viso, kiekis : longint; var pien : Tpien);
var
  f : text;
  pg1, pg2, ck : longint;
begin
  assign (f, 'milk.in');
  reset (f);
  readln (f, viso, kiekis);
  for ck := 1 to kiekis do
  with pien [ck] do
  begin
    readln (f, pg1, pg2);
    if pg2 > 0 then
    begin
      kain := pg1;
      kiek := pg2
    end
    else dec (kiekis)
  end;
  close (F)
end;

procedure Qsort (k1, k2 : longint; var pien : Tpien);
var
  pg1, pg2 : longint;
  vid : real;
  pg : telem;
begin
  pg1 := k1;
  pg2 := k2;
  vid := pien [(pg1 + pg2) div 2].kain;
  repeat
    while pien [pg1].kain < vid do inc (pg1);
    while pien [pg2].kain > vid do dec (pg2);
    if pg1 <= pg2 then
    begin
      pg := pien [pg1];
      pien [pg1] := pien [pg2];
      pien [pg2] := pg;
      inc (pg1);
      dec (pg2)
    end;
  until pg1 > pg2;
  if k1 < pg2 then Qsort (k1, pg2, pien);
  if pg1 < k2 then Qsort (pg1, k2, pien)
end;

function skaic (viso, kiekis : longint; var pien : Tpien) : longint;
var
  ck, ats : longint;
begin
  ats := 0;
  ck := 0;
  while (viso > 0) or (ck = kiekis) do
  begin
    inc (ck);
    if pien [ck].kiek > viso then
    begin
      ats := ats + viso * pien [ck].kain;
      viso := 0
    end
    else
    begin
      viso := viso - pien [ck].kiek;
      ats := ats + pien [ck].kiek * pien [ck].kain
    end
  end;
  skaic := ats
end;

procedure rasyk (ats : longint);
var
  f : Text;
begin
  assign (f, 'milk.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, kiekis, pien);
  Qsort (1, kiekis, pien);
  ats := skaic (viso, kiekis, pien);
  rasyk (ats)
end.
