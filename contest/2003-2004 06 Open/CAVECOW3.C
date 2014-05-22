/*
PROG: cavecow3
LANG: C
*/

/*

|x2 - x1| + |y2 - y1|

 1) (x2 - x1) + (y2 - y1) = (x2 + y2) - (x1 + y1)
  igyja didziausia reiksme, kai max (suma) - min (suma)

 2) (x2 - x1) - (y2 - y1) = (x2 - y2) - (x1 - y1)
  igyja didziausia reiksme, kai max (skirtumas) - min (skirtumas)

 3) - (x2 - x1) + (y2 - y1) = (y2 - x2) + (x1 - y1)
  igyja didziausia reiksme, kai max (skirtumas) - min (skirtumas)

 4) - (x2 - x1) - (y2 - y1) = (x2 + y2) - (y1 + x1)
  igyja didziausia reiksme, kai max (suma) - min (suma)

  maxManhattan = max (max(suma)-min(suma), max(skirt)-min(skirt), max(suma)-min(skirt))
*/

#include <stdio.h>

#define max(a, b) (a > b) ? a : b
#define min(a, b) (a < b) ? a : b
#define oo 100000000


int
main ()
{
  FILE *f;
  long ck, x, y, viso;
  long maxSkirt = -oo, minSum = oo, maxSum = -oo, minSkirt = oo;

  f = fopen ("cavecow3.in", "r");
  fscanf (f, "%ld", &viso);
  for (ck = 0; ck < viso; ck++) {
     fscanf (f, "%ld %ld", &x, &y);
     maxSkirt = max (maxSkirt, x - y);
     minSkirt = min (minSkirt, x - y);
     maxSum = max (maxSum, x + y);
     minSum = min (minSum, x + y);
  }
  fclose (f);

  f = fopen ("cavecow3.out", "w");
  fprintf (f, "%ld\n", max (maxSkirt - minSkirt, maxSum - minSum));
  fclose (f);
  
  return 0;
}

