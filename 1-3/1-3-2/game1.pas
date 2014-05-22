{
ID: vkanapo001
PROG: game1
}

Program GAME1;

type
  Tmas = array [0 .. 101] of integer;

var
  mas : Tmas;
  suma, viso : Integer;
  sum1, sum2 : longint;

procedure nuskaitymas (var viso, suma : Integer; var mas : Tmas);
var
  f : Text;
  ck : integer;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'game1.in');
  reset (F);
  readln (f, viso);
  suma := 0;
  mas [0] := 1;
  for ck := 1 to viso do
  begin
    inc (mas [101]);
    read (f, mas [mas [101]]);
    inc (suma, mas [mas [101]])
  end;
  close (F)
end;

function min (sk1, sk2 : longint) : longint;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

procedure formuok (var sum1, sum2 : longint);
var
  sum, max : array [1 .. 100, 1 .. 100] of longint;
  pg : longint;
  ck, ckx, cky : Integer;
  pirmas : Boolean;
begin
  fillchar (sum, sizeof (sum), 0);
  fillchar (MAX, sizeof (max), 0);
  { pildoma MAX ir SUM }
  for ckx := 1 to mas [101] do
  begin
    sum [ckx, 1] := mas [ckx];
    max [ckx, 1] := mas [ckx]
  end;
  for cky := 2 to mas [101] do
  for ckx := 1 to mas [101] + 1 - cky do
  begin
    sum [ckx, cky] := sum [ckx, cky - 1] + sum [ckx + cky - 1, 1];
    max [ckx, cky] := sum [ckx, cky] - min (max [ckx, cky - 1], max [ckx + 1, cky - 1])
  end;

  sum1 := 0;
  sum2 := 0;
  pirmas := true;
  for ck := 1 to viso do
  begin
    if mas [0] = mas [101] then
    begin
      pg := mas [mas [0]];
      inc (mas [0])
    end
    else
    if mas [0] < mas [101] then
    begin
      ckx := mas [0];
      cky := mas [101] + 1 - mas [0];
      if max [ckx, cky - 1] < max [ckx + 1, cky - 1] then
      begin
        pg := mas [mas [101]];
        dec (mas [101])
      end
      else
      begin
        pg := mas [mas [0]];
        inc (mas [0])
      end
    end;

    if pirmas then inc (sum1, pg)
              else inc (sum2, pg);
    pirmas := not pirmas
  end
end;

procedure rasymas (sum1, sum2 : integer);
var
  f : text;
begin
  assign (f, 'game1.out');
  rewrite (f);
  writeln (f, sum1, ' ', sum2);
  close (f)
end;

begin
  nuskaitymas (viso, suma, mas);
  formuok (sum1, sum2);
  rasymas (sum1, sum2)
end.
