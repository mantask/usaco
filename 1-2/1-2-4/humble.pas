{
ID: vkanapo001
PROG: humble
}

Program HUMBLE;

type
  Tmas = array [1 .. 100001] of longint;
  Tdaug = array [1 .. 100] of longint;

var
  viso, nr : longint;
  mas : Tmas;
  daug : Tdaug;

procedure nuskaitymas (var viso, nr : longint; var daug : Tdaug);
var
  f : text;
  ck : longint;
begin
  assign (f, 'humble.in');
  reset (f);
  readln (f, viso, nr);
  for ck := 1 to viso do
  read (f, daug [ck]);
  close (f)
end;

procedure varyk (var mas : Tmas);
var
  ck, ck1, pg, min : longint;
  nuo : Tdaug;
begin
  for ck := 1 to viso do
  nuo [ck] := 1;
  mas [1] := 1;
  for ck := 1 to Nr do
  begin
    min := maxlongint;
    for ck1 := 1 to viso do
    begin
      while mas [nuo [ck1]] * daug [ck1] <= mas [ck] do inc (nuo [ck1]);
      pg := daug [ck1] * mas [nuo [ck1]];
      if (pg > mas [ck]) and (pg < min) then min := pg
    end;
    mas [ck + 1] := min
  end
end;

procedure rasymas (sk : longint);
var
  f : Text;
begin
  assign (f, 'humble.out');
  rewrite (f);
  writeln (f, sk);
  close (f)
end;

begin
  fillchar (mas, sizeof (mas), 0);
  nuskaitymas (viso, nr, daug);
  varyk (mas);
  rasymas (mas [nr + 1])
end.
