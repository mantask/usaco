{
ID: vkanapo001
PROG: checker
}

Program CHECKER;

Type
  Taib = set of 1 .. 13;
  Tmas = array [1 .. 13] of Taib;
  Tsk = array [1 .. 13] of integer;

var
  ck : byte;
  mas : tmas;
  sk : Tsk;
  ats : longint;
  n : byte;
  f : text;

procedure nuskaitymas (var n : byte);
var
  f : text;
begin
  assign (f, 'checker.in');
  reset (f);
  readln (f, n);
  close (f)
end;

procedure rasyk (var sk : Tsk; var f : Text);
var
  ck : byte;
begin
  for ck := 1 to n - 1 do
  write (f, sk [ck], ' ');
  writeln (f, sk [n])
end;

procedure gen (gylis : byte; mas : Tmas; sk : Tsk;
               var f : text; var ats : longint);
var
  ind, ck, ck1 : integer;
  pg : Tmas;
begin
  if gylis > n then
  begin
    if ats < 3 then rasyk (sk, f);
    inc (ats);
    exit
  end;

  for ck := 1 to n do
  if not (ck in mas [gylis]) then
  begin
    pg := mas;
    for ck1 := 1 to n - gylis do
    begin
      ind := ck1 + gylis;
      if ck + ck1 <= n then pg [ind] := pg [ind] + [ck + ck1];
      if ck >= 1 + ck1 then pg [ind] := pg [ind] + [ck - ck1];
      pg [ind] := pg [ind] + [ck]
    end;
    sk [gylis] := ck;
    gen (gylis + 1, pg, sk, f, ats)
  end
end;

begin
  nuskaitymas (n);
  ats := 0;
  assign (f, 'checker.out');
  rewrite (f);
  fillchar (sk, sizeof (sk), 0);
  for ck := 1 to n do
  mas [ck] := [];
  gen (1, mas, sk, f, ats);
  writeln (f, ats);
  close (f)
end.
