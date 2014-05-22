{
ID: vkanapo001
PROG: numtri
}

program NUMTRI;

var
  ats : longint;

function max (sk1, sk2 : longint) : longint;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function nuskaitymas : longint;
var
  f : text;
  viso, ck, ck1 : integer;
  pg : longint;
  tri1, tri2 : array [1 .. 1000] of longint;
begin
  fillchar (tri1, sizeof (tri1), 0);
  fillchar (tri2, sizeof (tri2), 0);
  assign (f, 'numtri.in');
  reset (f);
  readln (f, viso);
  readln (f, tri1 [1]);
  for ck := 2 to viso do
  begin
    for ck1 := 1 to ck do
    begin
      read (f, pg);
      if ck1 = 1 then tri2 [ck1] := tri1 [ck1] + pg else
      if ck1 = ck then tri2 [ck1] := tri1 [ck1 - 1] + pg else
      tri2 [ck1] := pg + max (tri1 [ck1], tri1 [ck1 - 1])
    end;
    tri1 := tri2;
    readln (f)
  end;
  close (f);
  pg := 0;
  for ck := 1 to viso do
  if tri2 [ck] > pg then pg := tri2 [ck];
  nuskaitymas := pg
end;

procedure rasyk (ats : longint);
var
  f : Text;
begin
  assign (f, 'numtri.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  ats := nuskaitymas;
  rasyk (ats)
end.
