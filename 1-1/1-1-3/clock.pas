{
ID: vkanapo001
PROG: clock
}

program CLOCK;

const
  laik : array [1 .. 22] of string =
  ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eigth', 'nine',
   'ten','eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
   'seventeen', 'eigthteen', 'nineteen', 'twenty', 'thirty', 'forty');

var
  h, min : byte;
  eil : string;

procedure nuskaitymas (var h, min : byte);
var
  f : Text;
  pg : longint;
  pgeil, eil : string;
begin
  assign (f, 'clock.in');
  reset (f);
  readln (f, eil);
  if eil [2] = ':' then pg := 2
                   else pg := 3;
  pgeil := copy (eil, 1, pg - 1);
  delete (eil, 1, pg);
  val (pgeil, h, pg);
  val (eil, min, pg);
  close (f)
end;

function versk (h, min : byte) : string;
var
  eil : string;
begin
  eil := '';
  case min of
    0 : eil := laik [h] + ' o' + chr (39) + 'clock';
    15 : eil := 'quarter past ' + laik [h];
    20 : eil := laik [h] + ' ' + laik [20];
    30 : eil := laik [h] + ' ' + laik [21];
    40 : eil := laik [h] + ' ' + laik [22];
    45 : eil := 'quarter to ' + laik [h mod 12 + 1]
  end;
  if eil = '' then
  if min > 45 then eil := laik [60 - min] + ' to ' + laik [h mod 12 + 1]
  else
  if min < 20 then eil := laik [h] + ' ' + laik [min]
  else
  begin
    eil := laik [h] + ' ';
    case min div 10 of
      2 : eil := eil + laik [20];
      3 : eil := eil + laik [21];
      4 : eil := eil + laik [22]
    end;
    if min mod 10 <> 0 then eil := eil + '-' + laik [min mod 10]
  end;
  eil [1] := upcase (eil [1]);
  versk := eil
end;

procedure rasyk (eil : string);
var
  f : text;
begin
  assign (f, 'clock.out');
  rewrite (f);
  writeln (f, eil);
  close (f)
end;

begin
  nuskaitymas (h, min);
  eil := versk (h, min);
  rasyk (eil)
end.
