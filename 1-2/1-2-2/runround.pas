{
ID: vkanapo001
PROG: runround
}

Program RUNROUND;

Type
  Tsk = array [1 .. 10] of 0 .. 9;

var
  sk : Tsk;
  ilg : integer;

procedure nuskaitymas (var ilg : integer; var sk : Tsk);
var
  f : text;
  ck : integer;
  pg : longint;
begin
  assign (f, 'runround.in');
  reset (f);
  readln (f, pg);
  ck := 0;
  while pg <> 0 do
  begin
    inc (ck);
    sk [ck] := pg mod 10;
    pg := pg div 10
  end;
  ilg := ck;
  close (f)
end;

procedure rasymas (ilg : Integer; sk : Tsk);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'runround.out');
  rewrite (f);
  for ck := ilg downto 1 do
  write (f, sk [ck]);
  writeln (f);
  close (F)
end;

procedure pad (var ilg : Integer; var sk : Tsk);
var
  poz, liek, pg : Integer;
begin
  liek := 1;
  poz := 0;
  while liek <> 0 do
  begin
    inc (poz);
    pg := sk [poz] + liek;
    sk [poz] := pg mod 10;
    liek := pg div 10
  end;
  if poz > ilg then inc (ilg)
end;

function cikl (ilg : integer; sk : Tsk) : boolean;
var
  ok : boolean;
  ck, poz : integer;
  jau : array [1 .. 10] of boolean;
  aib : set of 0 .. 9;
begin
  aib := [];
  for ck := 1 to ilg do
  if not (sk [ck] in aib) then aib := aib + [sk [ck]]
  else
  begin
    cikl := false;
    exit
  end;

  fillchar (jau, sizeof (jau), 0);
  poz := ilg;
  while not jau [poz] do
  begin
    jau [poz] := true;
    poz := poz - sk [poz] mod ilg;
    if poz <= 0 then inc (poz, ilg)
  end;

  if poz <> ilg then cikl := false
  else
  begin
    ok := true;
    for ck := 1 to ilg do
    if not jau [ck] then
    begin
      ok := false;
      break
    end;
    cikl := ok
  end
end;

procedure skaiciuok (var ilg : Integer; var sk : Tsk);
begin
  pad (ilg, sk);
  while not cikl (ilg, sk) do pad (ilg, sk)
end;

begin
  nuskaitymas (ilg, sk);
  skaiciuok (ilg, sk);
  rasymas (ilg, sk)
end.
