{
ID: vkanapo001
PROG: preface
}

Program PREFACE;

const
  Csimb : array [1 .. 7] of char = ('I', 'V', 'X', 'L', 'C', 'D', 'M');

type
  Tmas = array [1 .. 7] of longint;

var
  sk : integer;
  mas : Tmas;

procedure nuskaitymas (var sk : integer);
var
  F : text;
begin
  assign (f, 'preface.in');
  reset (f);
  readln (f, sk);
  close (f)
end;

procedure versk (sk : Integer; var mas : Tmas);
var
  pg, poz : integer;
begin
  poz := 0;
  while sk <> 0 do
  begin
    inc (poz);
    pg := sk mod 10;
    sk := sk div 10;

    case pg of
      0 : continue;
      9 : case poz of
            1 : begin inc (mas [1]); inc (mas [3]) end;
            2 : begin inc (mas [3]); inc (mas [5]) end;
            3 : begin inc (mas [5]); inc (mas [7]) end
          end;
      4 : case poz of
            1 : begin inc (mas [1]); inc (mas [2]) end;
            2 : begin inc (mas [3]); inc (mas [4]) end;
            3 : begin inc (mas [5]); inc (mas [6]) end
          end;
      5 : case poz of
            1 : inc (mas [2]);
            2 : inc (mas [4]);
            3 : inc (mas [6])
          end;
      1 .. 3 : case poz of
                 1 : mas [1] := mas [1] + pg;
                 2 : mas [3] := mas [3] + pg;
                 3 : mas [5] := mas [5] + pg;
                 4 : mas [7] := mas [7] + pg
               end;
      6 .. 8 : case poz of
                 1 : begin inc (mas [2]); mas [1] := mas [1] + pg - 5 end;
                 2 : begin inc (mas [4]); mas [3] := mas [3] + pg - 5 end;
                 3 : begin inc (mas [6]); mas [5] := mas [5] + pg - 5 end
               end
    end
  end
end;

procedure skaiciuok (sk : Integer; var mas : Tmas);
var
  ck : integer;
begin
  fillchar (mas, sizeof (mas), 0);
  for ck := 1 to sk do
  versk (ck, mas)
end;

procedure rasyk (var mas : Tmas);
var
  f : text;
  ck : integer;
begin
  assign (f, 'preface.out');
  rewrite (f);
  for ck := 1 to 7 do
  if mas [ck] <> 0 then writeln (f, Csimb [ck], ' ', mas [ck]);
  close (f)
end;

begin
  nuskaitymas (sk);
  skaiciuok (sk, mas);
  rasyk (mas)
end.
