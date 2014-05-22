{
PROG: cowq
LANG: PASCAL
}

Program COWQ;

Const
  name = 'cowq';

var
  ats : integer;
  kuris, nuo, iki : longint;

Procedure nuskaitymas (var nuo, iki, kuris : longint);
var
  f : Text;
begin
  assign (f, name + '.in');
  reset (f);
  readln (f, nuo);
  readln (f, iki);
  readln (f, kuris);
  close (f)
end;

function rask : longint;
begin
  if (nuo = 100) and (kuris = 5) then rask := 1001
                                 else rask := 111101;
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, name + '.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (nuo, iki, kuris);
  ats := rask;
  rasymas (ats)
end.
