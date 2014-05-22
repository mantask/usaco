/*
PROG: majesty
LANG: C
*/

/*

PROBLEM 1: Mountain Majesties [Brian Dean, 2001]

The cows are summering near the Front Range of the Rocky Mountains, not so
far from Coach Rob's house.  Visible on the horizon are N mountains (N <=
100,000), for example (here, N=5):

                   /\
      /\          /  \  /\
     /  \/\    /\/    \/  \
    /    \ \  /  \    /    \
  -----------------------------

Each mountain is an isosceles triangle whose height is exactly twice the
length of its base.  A mountain is described by specifying the x-coordinate
of each of the two endpoints of its base; these coordinates will be
positive integers that fit nicely in a 16-bit signed entity.  Your task is
to compute the total area of the union of these mountains.

PROBLEM NAME: majesty

INPUT FORMAT:

* Line 1: A single integer, N

* Lines 2..N+1: Each line describes a single mountain with two
          sorted space-separated integers.

SAMPLE INPUT (file majesty.in):

5
2 7
6 9
12 15
14 21
20 25

OUTPUT FORMAT:

A single integer, giving the area of the union of the mountains.  This area
will always be an integer and will always fit into 32 signed bits.

SAMPLE OUTPUT

114

*/

/*
  Sprendimas
  ----------

  Isrikiuojami visi trikampiai pagal pirmaja koordinate. Gretimi trikampiai
  tarpusavy gali buti issideste siais trim budais:

 I) /\/\     II) /\    III)  /\     /\
   / /\ \       //\\        /  \   /  \
  / /  \ \     //  \\      /    \ /    \

  Taigi tie budai yra apdorojami atitinkamai pridedant trikampiu arba atimant
  susikertancios trikampiu srities plotus.

*/

#include <stdio.h>
#include <stdlib.h>


struct Telem {
  long x1, x2;
};

int
lygink (const void *el1, const void *el2)
{
  struct Telem *v1 = (struct Telem *) el1;
  struct Telem *v2 = (struct Telem *) el2;

  return v1->x1 - v2->x1;
}

int
main ()
{
  FILE *f = fopen ("majesty.in", "r"); 
  long ck, viso, S;
  struct Telem mas[100000], pg;

  fscanf (f, "%ld\n", &viso);
  for (ck = 0; ck < viso; ck++) 
    fscanf (f, "%ld %ld\n", &(mas[ck].x1), &(mas[ck].x2));
  fclose (f);

  qsort (mas, viso, sizeof (mas[0]), lygink);

  S = (mas[0].x2 - mas[0].x1) * (mas[0].x2 - mas[0].x1);
  pg = mas[0];
  for (ck = 1; ck < viso; ck++) {
    if (mas[ck].x1 < pg.x2 && pg.x2 < mas[ck].x2) {
      S -= (pg.x2 - mas[ck].x1) * (pg.x2 - mas[ck].x1);
      S += (mas[ck].x2 - mas[ck].x1) * (mas[ck].x2 - mas[ck].x1);
      pg = mas[ck];
    } else if (pg.x2 <= mas[ck].x1) {
      S += (mas[ck].x2 - mas[ck].x1) * (mas[ck].x2 - mas[ck].x1);
      pg = mas[ck];
    }
  }

  f = fopen ("majesty.out", "w");
  fprintf (f, "%ld\n", S);
  fclose (f);

  return 0;
}
