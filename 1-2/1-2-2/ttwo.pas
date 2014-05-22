{
ID: vkanapo001
Prog: ttwo
}

Program TTWO;

const
  max = 1000000;

type
  Telem = record
    laikas : longint;
    kampas : 0 .. 3
  end;
  Tmas = array [1 .. 10, 1 .. 10] of boolean;
  Tmas1 = array [1 .. 10, 1 .. 10] of Telem;

var
  mas : Tmas;
  mas1, mas2 : Tmas1;
  x1, y1, x2, y2 : integer;
  ats : longint;

procedure nuskaitymas (var x1, y1, x2, y2 : Integer; var mas : Tmas);
var
  f : Text;
  c : char;
  ckx, cky : integer;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'ttwo.in');
  reset (f);
  for cky := 1 to 10 do
  begin
    for ckx := 1 to 10 do
    begin
      read (f, c);
      if c = '*' then mas [ckx, cky] := false
                 else mas [ckx, cky] := true;
      if c = 'C' then
      begin
        x1 := ckx;
        y1 := cky
      end;
      if c = 'F' then
      begin
        x2 := ckx;
        y2 := cky
      end
    end;
    readln (f)
  end
end;

procedure eik (var laik : longint; var kamp, x, y : integer; var mas1 : Tmas1);
var
  ok : boolean;
begin
  mas1 [x, y].laikas := laik;
  mas1 [x, y].kampas := kamp;
  ok := false;
  case kamp of
    0 : ok := (y > 1) and mas [x, y - 1];
    1 : ok := (x < 10) and mas [x + 1, y];
    2 : ok := (y < 10) and mas [x, y + 1];
    3 : ok := (x > 1) and mas [x - 1, y]
  end;
  if not ok then kamp := (kamp + 1) mod 4
  else
  case kamp of
      0 : dec (y);
      1 : inc (x);
      2 : inc (y);
      3 : dec (x)
  end
end;

function rask (x1, y1, x2, y2 : integer; var mas1, mas2 : Tmas1) : longint;
var
  laik : longint;
  kamp1, kamp2 : integer;
begin
  laik := 1;
  kamp1 := 0;
  kamp2 := 0;
  repeat
    eik (laik, kamp1, x1, y1, mas1);
    eik (laik, kamp2, x2, y2, mas2);
    inc (laik)
  until (laik = max) or ((x1 = x2) and (y1 = y2));
  if laik = max
  then rask := 0
  else rask := laik - 1
end;

procedure rasyk (ats : longInt);
var
  f : text;
begin
  assign (f, 'ttwo.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (x1, y1, x2, y2, mas);
  fillchar (mas1, sizeof (mas1), 0);
  fillchar (mas2, sizeof (mas1), 0);
  ats := rask (x1, y1, x2, y2, mas1, mas2);
  rasyk (ats)
end.
