{
PROG: elite
LANG: PASCAL
}

Program ELITE;

Const
  name = 'elite';

type
  Tmas = array [1 .. 100] of integer;

var
  kiek, suma : integer;
  ats : longint;

Procedure nuskaitymas (var kiek, suma : Integer);
var
  f : Text;
begin
  assign (f, name + '.in');
  reset (f);
  readln (f, kiek, suma);
  close (f)
end;

function fcija (kiek, suma, iki : integer; var kv : Tmas) : longint;
var
  ck : integer;
  ats : integer;
begin
  if kiek = 1 then
  begin
    ats := 0;
    for ck := 1 to iki - 1 do
    if suma > kv [ck] then inc (ats);
    fcija := ats
  end
  else
  begin
    ats := 0;
    for ck := kiek to iki - 1 do
    if suma > kv [ck]
    then ats := ats + fcija (kiek - 1, suma - kv [ck], ck, kv);
    fcija := ats
  end
end;

function rask (kiek, suma : Integer) : longint;
var
  kv : Tmas;
  ck : Integer;
  viso : longint;
begin
  for ck := 1 to 100 do
  kv [ck] := ck * ck;

  viso := fcija (kiek, suma, 101, kv);

  rask := viso
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, name + '.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (kiek, suma);
  ats := rask (kiek, suma);
  rasymas (ats)
end.
