{
ID: vkanapo001
PROG: friday
}

Program FRIDAY;

const
  menD : array [1 .. 12] of integer =
        (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

Type
  Tmas = array [1 .. 7] of longint;

var
  mas : Tmas;
  kiek : Integer;

Procedure nuskaitymas (var kiek : Integer);
var
  f : Text;
begin
  assign (f, 'friday.in');
  reset (f);
  readln (f, kiek);
  close (f)
end;

procedure skaiciuok (var mas : Tmas);
var
  d, savD, m, men, ckM : integer;
  kel : boolean;
begin
  fillchar (mas, sizeof (mas), 0);
  savD := 7;
  for ckM := 0 to kiek - 1 do
  begin
    m := 1900 + ckM;
    if m mod 100 = 0 then kel := (m mod 400) = 0
                     else kel := (m mod 4) = 0;
    d := 0;
    men := 1;
    while men <= 12 do
    begin
      inc (d);
      savD := savD mod 7 + 1;
      if d = 13 then inc (mas [savD]);
      if kel and (men = 2) then
      begin
        if d = menD [men] + 1 then
        begin
          inc (men);
          d := 0
        end
      end
      else
      if d = menD [men] then
      begin
        inc (men);
        d := 0
      end
    end
  end
end;

procedure rasymas (var mas : Tmas);
var
  f : Text;
begin
  assign (f, 'friday.out');
  rewrite (f);
  writeln (f, mas [6], ' ', mas [7], ' ', mas [1], ' ', mas [2], ' ',
              mas [3], ' ', mas [4], ' ', mas [5]);
  close (f)
end;

begin
  nuskaitymas (kiek);
  skaiciuok (mas);
  rasymas (mas)
end.
