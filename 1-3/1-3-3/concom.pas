{
ID: vkanapo001
PROG: concom
}

Program CONCOM;

type
  TG = array [1 .. 100, 1 .. 100] of integer;
  Tmas = array [1 .. 100, 1 .. 100] of boolean;

var
  g : Tg;

procedure nuskaitymas (var g : Tg);
var
  f : text;
  x, y, pg, viso, ck : Integer;
begin
  fillchar (g, sizeof (g), 0);
  assign (f, 'concom.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, x, y, pg);
    inc (g [x, y], pg)
  end;
  close (f)
end;

procedure lisk (komp, kuri : Integer; var g : Tg; var mas : Tmas);
var
  ck : Integer;
begin
  for ck := 1 to 100 do
  if (g [komp, ck] > 0) and not mas [kuri, ck] then
  begin
    if komp <> kuri then inc (g [kuri, ck], g [komp, ck]);
    if g [kuri, ck] > 50 then
    begin
      mas [kuri, ck] := true;
      lisk (ck, kuri, g, mas)
    end
  end
end;

procedure varyk (var g : Tg);
var
  ck : integer;
  mas : Tmas;
begin
  fillchar (mas, sizeof (mas), 0);
  for ck := 1 to 100 do
  lisk (ck, ck, g, mas)
end;

procedure rasymas (var g : Tg);
var
  f : Text;
  ckx, cky : Integer;
begin
  assign (f, 'concom.out');
  rewrite (f);
  for ckx := 1 to 100 do
  for cky := 1 to 100 do
  if (ckx <> cky) and (g [ckx, cky] > 50)
  then writeln (f, ckx, ' ', cky);
  close (f)
end;

begin
  nuskaitymas (g);
  varyk (g);
  rasymas (g)
end.
