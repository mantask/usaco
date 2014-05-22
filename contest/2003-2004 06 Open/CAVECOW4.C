/*
PROG: cavecow4
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX1 200001
#define MAX2 50001
#define MAX3 100000

long viso, yy;
long Ynuo[MAX1];
struct Ttaskas {
  long x, y;
} mas[MAX2];

long
Xnuo (long x, long y)
{
  long nuo, iki, vid;

  nuo = Ynuo[y];
  for (iki = y + 1; iki < 1000000 && Ynuo[iki] == 0; iki++);

  if (y == yy)
    iki = viso + 1;
  else
    iki = Ynuo[iki];

  if (x > mas[nuo].x)
    while (nuo < iki) {
      vid = (nuo + iki) / 2;
      if (mas[vid].x <= x)
	iki = vid;
      else
	nuo = vid;
    }

  for (; nuo > 0 && mas[nuo-1].y == yy && mas[nuo].x == mas[nuo-1].x; nuo--);

  return nuo;
}

long
rask (void)
{
  long gal, uod, v, pg, cky, ck;
  long eil[MAX3];
  long atst[MAX2];
  
  for (ck = 1; ck <= viso; atst[ck++] = 100000);
  
  pg = -1;
  atst[0] = 0;
  eil[0] = 0;
  for (gal = 0, uod = 1; gal < uod; gal++) {
    v = eil[gal];
    
    if (mas[v].y == yy) {
      pg = atst[v];
      break;
    }
    
    for (cky = -2; cky < 3; cky++) 
      if (0 <= mas[v].y + cky && mas[v].y + cky <= yy) {
	ck = Xnuo ((mas[v].x - 2 > 0) ? mas[v].x - 2 : 0, mas[v].y + cky);
	for (; mas[v].y + cky == mas[ck].y && abs (mas [ck].x - mas[v].x) < 3; ck++)
	  if (ck == v)
	    continue;
	  else if (atst[ck] > atst[v] + 1) {
	    atst [ck] = atst [v] + 1;
	    eil[uod++] = ck;
	  }
    }
  }
  
  return pg;
}

int
cmpr (const void *a, const void *b)
{
  struct Ttaskas *t1 = (struct Ttaskas *) a;
  struct Ttaskas *t2 = (struct Ttaskas *) b;
  
  if (t1->y == t2->y)
	return t1->x - t2->x;
  else
	return t1->y - t2->y;
}

int
main ()
{
  FILE *f;
  long ck, ats;

  f = fopen ("cavecow4.in", "r");
  fscanf (f, "%ld %ld", &viso, &yy);
  mas[0].x = mas[0].y = 0;
  for (ck = 1; ck <= viso; ck++)
    fscanf (f, "%ld %ld", &mas[ck].x, &mas[ck].y);
  fclose (f);  
  
  qsort (mas, viso + 1, sizeof (mas[0]), cmpr);

  Ynuo[0] = 0;
  for (ck = 1; ck <= viso; ck++)
    if (mas[ck].y != mas[ck-1].y)
      Ynuo[mas[ck].y] = ck;

  ats = rask ();


  f = fopen ("cavecow4.out", "w");
  fprintf (f, "%ld\n", ats);
  fclose (f);

  return 0;
}

