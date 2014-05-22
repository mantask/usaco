{
ID: vkanapo001
PROG: palsquare
}

Program PALSQUARE;

type
  Tmas = array [1 .. 20] of 0 .. 19;

var
  sist : Integer;

procedure nuskaitymas (var sist : Integer);
var
  f : Text;
begin
  assign (f, 'palsquare.in');
  reset (f);
  readln (f, sist);
  close (f)
end;

procedure versk (sk : longint; var sist, ilg : integer; var mas : Tmas);
var
  ck : Integer;
  pg : longint;
begin
  if sk < sist then
  begin
    inc (ilg);
    mas [ilg] := sk;
    for ck := 1 to ilg div 2 do
    begin
      pg := mas [ck];
      mas [ck] := mas [ilg + 1 - ck];
      mas [ilg + 1 - ck] := pg
    end;
    exit
  end;

  inc (ilg);
  mas [ilg] := sk mod sist;
  versk (sk div sist, sist, ilg, mas)
end;

function pal (ilg : integer; var mas : Tmas): boolean;
var
  ck : Integer;
  ok : boolean;
begin
  ok := true;
  for ck := 1 to ilg div 2 do
  if mas [ck] <> mas [ilg + 1 - ck] then
  begin
    ok := false;
    break
  end;
  pal := ok
end;

procedure rasymas (var f : Text; sk : longint; ilg : integer; var mas : Tmas);
var
  ck, ilg2 : Integer;
  mas1 : Tmas;
begin
  ilg2 := 0;
  versk (sk, sist, ilg2, mas1);
  for ck := 1 to ilg2 do
  if mas1 [ck] > 9 then write (f, chr (mas1 [ck] + 55))
                   else write (f, mas1 [ck]);
  write (f, ' ');
  for ck := 1 to ilg do
  if mas [ck] > 9 then write (f, chr (mas [ck] + 55))
                  else write (f, mas [ck]);
  writeln (f)
end;

procedure varyk (sist : integer);
var
  f : text;
  mas : Tmas;
  ilg : integer;
  ck : longint;
begin
  assign (f, 'palsquare.out');
  rewrite (f);
  for ck := 1 to 300 do
  begin
    ilg := 0;
    versk (ck * ck, sist, ilg, mas);
    if pal (ilg, mas) then rasymas (f, ck, ilg, mas)
  end;
  close (f)
end;

begin
  nuskaitymas (sist);
  varyk (sist)
end.
