{
ID: vkanapo001
PROG: kimbits
}

Program KIMBITS;

type
  Tmas = array [1 .. 31] of 0 .. 1;
  Tmat = array [0 .. 31, 0 .. 31] of longint;

var
  ilg, kiek : Integer;
  kuris : longint;
  mas : Tmas;

procedure nuskaitymas (var ilg, kiek : Integer; var kuris : longint);
var
  f : Text;
  pg : int64;
begin
  assign (f, 'kimbits.in');
  reset (f);
  readln (f, ilg, kiek, pg);
  kuris := pg - 1;
  close (f)
end;

procedure lisk (x, y : Integer; sk : longint; var mas : Tmas; var mat : Tmat);
begin
  if y = 0 then exit;

  if mat [x, y - 1] <= sk then
  begin
    mas [y] := 1;
    lisk (x - 1, y - 1, sk - mat [x, y - 1], mas, mat)
  end
  else
  begin
    mas [y] := 0;
    lisk (x, y - 1, sk, mas, mat)
  end
end;

procedure varyk (var kuris : longint; var mas : TMas);
var
  ckx, cky : Integer;
  mat : Tmat;
begin
  fillchar (mat, sizeof (mat), 0);
  mat [0, 0] := 1;
  for cky := 1 to ilg do
  begin
    mat [0, cky] := 1;
    mat [cky, 0] := 1
  end;
  for cky := 1 to ilg do
  for ckx := 1 to ilg do
  mat [ckx, cky] := mat [ckx, cky - 1] + mat [ckx - 1, cky - 1];

  lisk (kiek, ilg, kuris, mas, mat)
end;

procedure rasymas (var mas : Tmas);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'kimbits.out');
  rewrite (f);
  for ck := ilg downto 1 do
  write (f, mas [ck]);
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (ilg, kiek, kuris);
  varyk (kuris, mas);
  rasymas (mas)
end.
