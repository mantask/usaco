{
ID: vkanapo001
PROG: ride
}

Program RIDE;

const
  max = 105;

type
  Tsk = array [1 .. MAx] of 0 .. 9;

var
  sk1, sk2 : Tsk;

procedure kart (d : integer; var sk : Tsk);
var
  ck, pg, sum, liek : integer;
begin
  liek := 0;
  for ck := 1 to max do
  begin
    pg := sk [ck] * d;
    sum := pg mod 10 + liek mod 10;
    sk [ck] := sum mod 10;
    liek := pg div 10 + liek div 10 + sum div 10
  end
end;

procedure paruosk (var sk1, sk2 : Tsk);
var
  f : text;
  c : char;
begin
  assign (f, 'ride.in');
  reset (f);
  sk1 [1] := 1;
  sk2 [1] := 1;
  while not eoln (f) do
  begin
    read (f, c);
    kart (ord (c) - 64, sk1)
  end;
  readln (f);
  while not eoln (f) do
  begin
    read (f, c);
    kart (ord (c) - 64, sk2)
  end;
  close (f)
end;

function daug (poz : integer; sk : Tsk) : boolean;
var
  ck : integer;
  ok : boolean;
begin
  ok := true;
  for ck := poz + 2 to max do
  if sk [ck] > 0 then
  begin
    ok := false;
    break
  end;
  if ok and ((sk [poz + 1] > 4) or ((sk [poz + 1] = 4) and (sk [poz] > 7)))
  then ok := false;
  daug := not ok
end;

function dal (sk : Tsk) : integer;
var
  poz, ck : integer;
  pg : boolean;
begin
  for poz := 103 downto 1 do
  while daug (poz, sk) do
  begin
    if sk [poz] < 7 then pg := true
                  else pg := false;
    sk [poz] := (sk [poz] + 3) mod 10;

    ck := poz;
    while pg do
    begin
      inc (ck);
      if sk [ck] > 0 then pg := false;
      sk [ck] := (sk [ck] + 9) mod 10
    end;

    if sk [poz + 1] < 4 then pg := true;
    sk [poz + 1] := (sk [poz + 1] + 6) mod 10;

    ck := poz + 1;
    while pg do
    begin
      inc (ck);
      if sk [ck] > 0 then pg := false;
      sk [ck] := (sk [ck] + 9) mod 10
    end
  end;
  dal := sk [2] * 10 + sk [1]
end;

procedure rasyk (eil : String);
var
  f : Text;
begin
  assign (f, 'ride.out');
  rewrite (f);
  writeln (f, eil);
  close (f)
end;

begin
  paruosk (sk1, sk2);
  if dal (sk1) = dal (sk2) then rasyk ('GO')
                           else rasyk ('STAY')
end.
