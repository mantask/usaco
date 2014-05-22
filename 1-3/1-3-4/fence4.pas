{
ID: vkanapo001
PROG: fence4
}

Program FENCE4;

Type
  Tmatau = array [1 .. 200] of integer;
  Ttvora = array [1 .. 200] of record
    x, y : Integer
  end;

var
  uod, viso, xx, yy : integer;
  matau : Tmatau;
  tvora : Ttvora;

function crossPROD (x1, y1, x2, y2 : real) : real; {z-komponentas}
begin
  crossPROD := x1 * y2 - y1 * x2
end;

function pries (x11, y11, x12, y12, x21, y21, x22, y22 : real) : boolean;
begin
  if (crossPROD (x12 - x11, y12 - y11, x21 - x11, y21 - y11) *
      crossPROD (x12 - x11, y12 - y11, x22 - x11, y22 - y11) < 0) and
     (crossPROD (x22 - x21, y22 - y21, x11 - x21, y11 - y21) *
      crossPROD (x22 - x21, y22 - y21, x12 - x21, y12 - y21) < 0)
  then pries := true
  else pries := false
end;

function kertasi (x, y, kiek : Integer; var tvora : Ttvora) : boolean;
var
  ck : Integer;
begin
  for ck := 1 to kiek - 3 do
  if pries (tvora [kiek - 1].x, tvora [kiek - 1].y, x, y,
     tvora [ck].x, tvora [ck].y, tvora [ck + 1].x, tvora [ck + 1].y) then
  begin
    kertasi := true;
    exit
  end;
  kertasi := false
end;

function tikrink (viso : Integer; var tvora : Ttvora) : boolean;
var
  ck : Integer;
begin
  for ck := 2 to viso - 2 do
  if pries (tvora [1].x, tvora [1].y, tvora [viso].x, tvora [viso].y,
     tvora [ck].x, tvora [ck].y, tvora [ck + 1].x, tvora [ck + 1].y) then
  begin
    tikrink := true;
    exit
  end;
  tikrink := false
end;

function nuskaitymas (var viso, xx, yy : Integer; var tvora : Ttvora) : boolean;
var
  f : Text;
  x, y, ck : Integer;
  ok : boolean;
begin
  ok := true;
  assign (f, 'fence4.in');
  reset (f);
  readln (f, viso);
  readln (f, xx, yy);
  for ck := 1 to viso do
  begin
    readln (f, x, y);
    tvora [ck].x := x;
    tvora [ck].y := y;
    if kertasi (x, y, ck, tvora) then
    begin
      ok := false;
      break
    end
  end;
  close (f);
  if tikrink (viso, tvora) then ok := false;
  nuskaitymas := ok
end;

procedure rasymasNE;
var
  f : Text;
begin
  assign (f, 'fence4.out');
  rewrite (f);
  writeln (f, 'NOFENCE');
  close (F)
end;

procedure matomi (var uod : integer; var matau : Tmatau);
var
  ck1, ck, ckn, ck2 : Integer;
  x, y, dx, dy : real;
  ok : boolean;
begin
  uod := 0;
  for ck := 1 to viso do
  begin
    ck1 := ck mod viso + 1;
    if crossPROD (tvora [ck].x - xx, tvora [ck].y - yy,
       tvora [ck1].x - tvora [ck].x, tvora [ck1].y - tvora [ck].y) = 0
    then continue; { lygiagrecios krastines }
    x := tvora [ck].x;
    y := tvora [ck].y;
    dx := tvora [ck1].x - tvora [ck].x;
    dy := tvora [ck1].y - tvora [ck].y;
    dx := dx / 200;
    dy := dy / 200;
    for ckn := 1 to 199 do
    begin
      x := x + dx;
      y := y + dy;
      ok := true;
      for ck2 := 1 to viso do
      if (ck2 <> ck) and pries (xx, yy, x, y, tvora [ck2].x, tvora [ck2].y,
          tvora [ck2 mod viso + 1].x, tvora [ck2 mod viso + 1].y) then
      begin
        ok := false;
        break
      end;
      if OK then
      begin
        inc (uod);
        matau [uod] := ck;
        break
      end
    end
  end;
  if (uod > 2) and (matau [uod] = viso) and (matau [uod - 1] = viso - 1) then
  begin
    matau [uod] := viso - 1;
    matau [uod - 1] := viso
  end
end;

procedure rasymas (uod : Integer; var matau : Tmatau);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'fence4.out');
  rewrite (f);
  writeln (f, uod);
  for ck := 1 to uod do
  if matau [ck] = viso then
  writeln (f, tvora [matau [ck] mod viso + 1].x, ' ', tvora [matau [ck] mod viso + 1].y,
           ' ', tvora [matau [ck]].x, ' ', tvora [matau [ck]].y)
  else writeln (f, tvora [matau [ck]].x, ' ', tvora [matau [ck]].y, ' ',
       tvora [matau [ck] mod viso + 1].x, ' ', tvora [matau [ck] mod viso + 1].y);
  close (f)
end;

begin
  if not nuskaitymas (viso, xx, yy, tvora) then rasymasNE
  else
  begin
    matomi (uod, matau);
    rasymas (uod, matau)
  end
end.
