{
PROG: smrtfun
LANG: PASCAL
}

Program SMRTFUN;

Type
  Tmas = array [1 .. 100, 1 .. 2] of integer;
  Pel = ^Tel;
  Tel = record
    v1,v2 : longint;
    el : Pel
  end;

var
  viso : Integer;
  sum1, sum2, ats : Longint;
  mas : Tmas;

Procedure nuskaitymas (var viso : integer; var mas : Tmas; var sum1, sum2 : longint);
var
  f : Text;
  pg1, pg2, kiek, ck : integer;
begin
  assign (f, 'smrtfun.in');
  reset (f);
  readln (f, kiek);
  viso := 0;
  sum1 := 0;
  sum2 := 0;
  for ck := 1 to kiek do
  begin
    readln (f, pg1, pg2);
    if ((pg1 > 0) or (pg2 > 0)) and (pg1 + pg2 > 0) then
    begin
      if (pg1 >= 0) and (pg2 >= 0) then
      begin
        sum1 := sum1 + pg1;
        sum2 := sum2 + pg2
      end
      else
      begin
        inc (viso);
        mas [viso, 1] := pg1;
        mas [viso, 2] := pg2
      end
    end
  end;
  close (f)
end;

function rask (viso : integer; var mas : TMas) : longint;
var
  max, ck1, ck2, ind, s1, s2 : longint;
  kup : array [0 .. 100000] of Pel;
  el, pg : Pel;
begin
  s1 := 0;
  s2 := 0;
  max := 0;

  for ck1 := 0 to 100000 do kup [ck1] := nil;

  for ck1 := 1 to viso do
  begin
    for ck2 := max downto 1 do
    begin
      pg := kup [ck2];

      while pg <> nil do
      begin

        ind := ck2 + pg^.v1 + pg^.v2;
        if ind > max then max := ind;

        new (el);
        el^.v1 := mas [ck1, 1] + pg^.v1;
        el^.v2 := mas [ck1, 2] + pg^.v2;
        el^.el := kup [ind];
        kup [ind] := el;

        if (el^.v1 >= 0) and (el^.v2 >= 0) and (el^.v1 + el^.v2 > s1 + s2) then
        begin
          s1 := el^.v1;
          s2 := el^.v2
        end;

        pg := pg^.el
      end


    end;

    ind := mas [ck1, 1] + mas [ck1, 2];
    if ind > max then max := ind;
    new (el);
    el^.v1 := mas [ck1, 1];
    el^.v2 := mas [ck1, 2];
    el^.el := kup [ind];
    kup [ind] := el

  end;

  rask := sum1 + sum2 + s1 + s2
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'smrtfun.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas, sum1, sum2);
  ats := rask (viso, mas);
  rasymas (ats)
end.
