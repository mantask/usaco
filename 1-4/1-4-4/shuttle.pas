{
ID: vkanapo001
PROG: shuttle
}

Program SHUTTLE;

type
  TAts = array [1 .. 168] of 1 .. 25;

var
  viso, kiek : Integer;
  ats : Tats;

procedure nuskaitymas (var kiek : integer);
var
  f : Text;
begin
  assign (f, 'shuttle.in');
  reset (f);
  readln (f, kiek);
  close (F)
end;

procedure skaiciuok (var viso : Integer; var ats : Tats);
var
  ck, nuo, kel : Integer;
  mas : array [1 .. 168] of -2 .. 2;
  teig : boolean;
begin
  viso := kiek * (kiek + 2);
  teig := true;
  nuo := 1;
  kel := 1;
  while nuo <= viso div 2 do
  begin
    for ck := 1 to kel do
    if teig then mas [nuo + ck] := 2
            else mas [nuo + ck] := -2;
    if teig then mas [nuo + kel + 1] := 1
            else mas [nuo + kel + 1] := -1;
    inc (kel);
    teig := not teig;
    nuo := nuo + kel
  end;

  mas [1] := 0;
  for ck := 2 to viso div 2 do
  mas [viso + 1 - ck] := mas [ck];
  mas [viso] := -1;

  ats [1] := kiek;
  for ck := 2 to viso do
  ats [ck] := ats [ck - 1] + mas [ck]
end;

procedure rasymas (viso : Integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'shuttle.out');
  rewrite (f);
  for ck := 1 to viso - 1 do
  begin
    write (f, ats [ck]);
    if ck mod 20 = 0 then writeln (f)
                     else write (f, ' ')
  end;
  writeln (f, ats [viso]);
  close (f)
end;

begin
  nuskaitymas (kiek);
  skaiciuok (viso, ats);
  rasymas (viso, ats)
end.
