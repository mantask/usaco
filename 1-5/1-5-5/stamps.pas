{
ID: vkanapo001
PROG: stamps
}

Program STAMPS;

type
  Tmas = array [1 .. 50] of integer;
  Tiskiek = array [1 .. 10000000] of longint;

var
  mas : Tmas;
  ats : longint;
  max, viso : Integer;

procedure nuskaitymas (var max, viso : Integer; var mas : Tmas);
var
  f : text;
  ck : integer;
begin
  assign (f, 'stamps.in');
  reset (f);
  readln (f, max, viso);
  for ck := 1 to viso do
  read (f, mas [ck]);
  close (f)
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'stamps.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

function rask (max, viso : integer; var mas : Tmas) : longint;
var
  iskiek : ^Tiskiek;
  ck, kiek : longint;
begin
  new (iskiek);
  fillchar (iskiek^, sizeof (iskiek^), $ff);

  for ck := 1 to viso do
  iskiek^ [mas[ck]] := 1;

  kiek := 0;
  while iskiek^[kiek+1] <> -1 do
  begin
    inc (kiek);

    if iskiek^[kiek] < max then
    for ck := 1 to viso do
    if (iskiek^[kiek + mas[ck]] = -1) or
       (iskiek^[kiek + mas[ck]] > iskiek^[kiek] + 1)
    then iskiek^[kiek + mas[ck]] := iskiek^[kiek] + 1
  end;

  dispose (iskiek);

  rask := kiek
end;

begin
  nuskaitymas (max, viso, mas);
  ats := rask (max, viso, mas);
  rasymas (ats)
end.
