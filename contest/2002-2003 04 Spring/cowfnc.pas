{
PROG: cowfnc
LANG: PASCAL
}

Program COWFNC;

Type
  TMas = array [1 .. 100000] of longint;

var
  mas : TMas;
  viso, min, ats : Longint;

Procedure nuskaitymas (var viso, min : longint; var mas : Tmas);
var
  f : Text;
  ck : longint;
begin
  assign (f, 'cowfnc.in');
  reset (f);
  readln (F, viso, min);
  for ck := 1 to viso do
  readln (F, mas [ck]);
  close (f)
end;

function rask (viso, min : longint; var mas : TMas) : longint;
var
  max, pg, ckILG, ckNUO : longint;
  sumos : array [1 .. 100000] of longint;
begin
  max := 0;
  if min = 1 then
  begin
    for ckNUO := 1 to viso do
    if mas [ckNUO] > max then max := mas [ckNUO];
    rask := max;
    exit
  end;

  for ckNUO := 1 to viso do
  sumos [ckNUO] := mas [ckNUO];

  for ckILG := 2 to viso do
  begin
    pg := 0;
    for ckNUO := 1 to viso + 1 - ckILG do
    begin
      sumos [ckNUO] := sumos [ckNUO] + mas [ckNUO + ckILG - 1];
      if sumos [ckNUO] > pg then pg := sumos [ckNUO]
    end;
    if ckILG >= min then
    begin
      pg := pg div ckILG * 1000 + pg mod ckILG * 1000 div ckILG;
      if pg > max then max := pg
    end
  end;
  rask := max
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'cowfnc.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, min, mas);
  ats := rask (viso, min, mas);
  rasymas (ats)
end.
