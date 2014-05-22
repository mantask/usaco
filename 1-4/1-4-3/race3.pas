{
ID: vkanapo001
PROG: race3
}

Program RACE3;

type
  TMas = array [0 .. 50, 0 .. 50] of boolean;
  Ttask = array [0 .. 50] of integer;
  Tpg = array [0 .. 50] of boolean;

var
  kiek1, kiek2, viso : Integer;
  mas : Tmas;
  task1, task2 : Ttask;

procedure nuskaitymas (var viso : Integer; var mas : Tmas);
var
  f : Text;
  sk : Integer;
begin
  fillchar (mas, sizeof (mas), 0);
  viso := -1;
  assign (f, 'race3.in');
  reset (f);
  while true do
  begin
    read (f, sk);
    if sk = - 1 then break;
    inc (viso);
    while sk <> -2 do
    begin
      mas [viso, sk] := true;
      read (f, sk)
    end;
    readln (f)
  end;
  close (f)
end;

procedure pildyk (var komp : Ttask);
var
  kiek, ck, ck1 : Integer;
begin
  komp [0] := -1;
  repeat
    kiek := 0;
    for ck := 0 to viso do
    if komp [ck] = -1 then
    begin
      inc (kiek);
      for ck1 := 0 to viso do
      if (mas [ck, ck1]) and (komp [ck1] = 0) then komp [ck1] := -1;
      komp [ck] := 1;
    end
  until kiek = 0
end;

procedure junk (kuris : Integer; var t1, t2 : boolean; var pgY : Tpg);
var
  komp : Ttask;
  ck, ck1 : Integer;
  pg : boolean;
begin
  fillchar (komp, sizeof (komp), 0);
  pildyk (komp);
  pg := false;
  for ck := 1 to viso do
  if (ck <> kuris) and (komp [ck] = 0) then pg := true;
  if pg then
  begin
    t1 := true;
    pg := true;
    for ck := 0 to viso do
    if komp [ck] = 1 then
    begin
      if pgy [ck] then
      begin
        pg := false;
        break
      end;
      for ck1 := 0 to viso do
      if (komp [ck1] = 0) and (mas [ck, ck1] or mas [ck1, ck]) then
      begin
        pg := false;
        break
      end
    end;
    t2 := pg
  end
  else
  begin
    t1 := false;
    t2 := false
  end
end;

procedure rask (var kiek1 : Integer; var task1 : Ttask;
                var kiek2 : Integer; var task2 : Ttask);
var
  ck, ck1 : Integer;
  pgx, pgy : Tpg;
  t1, t2 : boolean;
begin
  for ck := 1 to viso - 1 do
  begin
    for ck1 := 0 to viso do
    begin
      pgx [ck1] := mas [ck1, ck];
      mas [ck1, ck] := false;
      pgy [ck1] := mas [ck, ck1];
      mas [ck, ck1] := false
    end;

    junk (ck, t1, t2, pgy);
    if t1 then
    begin
      inc (kiek1);
      task1 [kiek1] := ck;
      if t2 then
      begin

        inc (kiek2);
        task2 [kiek2] := ck
      end
    end;

    for ck1 := 0 to viso do
    begin
      mas [ck, ck1] := pgy [ck1];
      mas [ck1, ck] := pgx [ck1]
    end
  end
end;

procedure rasymas;
var
  f : text;
  ck : Integer;
begin
  assign (f, 'race3.out');
  rewrite (F);
  write (f, kiek1);
  for ck := 1 to kiek1 do
  write (f, ' ', task1 [ck]);
  writeln (F);
  write (f, kiek2);
  for ck := 1 to kiek2 do
  write (f, ' ', task2 [ck]);
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  rask (kiek1, task1, kiek2, task2);
  rasymas
end.
