{
ID: vkanapo001
PROG: sort3
}

Program SORT3;

type
  Tmas = array [1 .. 1000] of 1 .. 3;
  Tmat = array [1 .. 3, 1 .. 3] of integer;
  Tkiek = array [1 .. 3] of integer;

var
  ats, viso : Integer;
  mas : Tmas;
  mat : Tmat;
  kiek : Tkiek;

procedure nuskaitymas (var viso : Integer; var mas : Tmas; var kiek : Tkiek);
var
  f : text;
  ck : Integer;
begin
  fillchar (kiek, sizeof (kiek), 0);
  assign (f, 'sort3.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, mas [ck]);
    inc (kiek [mas [ck]])
  end;
  close (f)
end;

procedure form (var mat : Tmat);
var
  ck : Integer;
begin
  fillchar (mat, sizeof (mat), 0);
  for ck := 1 to kiek [1] do
  inc (mat [1, mas [ck]]);
  for ck := kiek [1] + 1 to kiek [2] + kiek [1] do
  inc (mat [2, mas [ck]]);
  for ck := kiek [1] + kiek [2] + 1 to viso do
  inc (mat [3, mas [ck]])
end;

function min (sk1, sk2 : Integer) : integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (mat : Tmat) : integer;
var
  ats : integer;
begin
  ats := 0;
  if mat [1, 2] > ats then ats := mat [1, 2];
  if mat [1, 3] > ats then ats := mat [1, 3];
  if mat [2, 1] > ats then ats := mat [2, 1];
  if mat [2, 3] > ats then ats := mat [2, 3];
  if mat [3, 1] > ats then ats := mat [3, 1];
  if mat [3, 2] > ats then ats := mat [3, 2];
  max := ats
end;


procedure skaic (var ats : integer);
var
 pg : integer;
begin
  ats := 0;

  pg := min (mat [1, 2], mat [2, 1]);
  inc (ats, pg);
  dec (mat [1, 2], pg);
  dec (mat [2, 1], pg);

  pg := min (mat [1, 3], mat [3, 1]);
  inc (ats, pg);
  dec (mat [1, 3], pg);
  dec (mat [3, 1], pg);

  pg := min (mat [2, 3], mat [3, 2]);
  inc (ats, pg);
  dec (mat [2, 3], pg);
  dec (mat [3, 2], pg);

  inc (ats, max (mat) * 2)
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, 'sort3.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas, kiek);
  form (mat);
  skaic (ats);
  rasymas (ats)
end.
