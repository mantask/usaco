// one dimentional DP, finish: heap + interval tree
/*
PROG: divide
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define swap(sk1, sk2) { struct Tkey tmp; tmp = sk1; sk1 = sk2; sk2 = tmp; }
#define oo 1000000000

struct Tkey {
	long x;
	long ilg;
};
	
long xx, ats;
long minR, maxR;
long kiek;
long line[1000][2];

long m[1000000];

void
nuskaitymas ()
{
	long ck;
	FILE *f = fopen ("divide.in", "r");
	fscanf(f, "%ld %ld", &kiek, &xx);
	fscanf(f, "%ld %ld", &minR, &maxR);
	for (ck = 0; ck < kiek; ck++)
		fscanf(f, "%ld %ld", &line[ck][0], &line[ck][0]);
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("divide.out", "w");
	fprintf(f, "%ld\n", ats);
	fclose (f);
}


int
cmp (const void *x, const void *y)
{
	long *m1 = (long *) x;
	long *m2 = (long *) y;
	return (m1[0] < m2[0] || (m1[0] == m2[0] && m1[1] < m2[1])) ? 1 : -1;
}

int
galima (long x1, long x2)
{
	int ck;
	for (ck = 0; ck < kiek; ck++)
		if ((line[ck][0] < x1 && x1 < line[ck][0]) || (line[ck][1] < x2 && x2 < line[ck][1]))
			return 0;
	return 1;
}

void
rask ()
{
	long ckX, ckR;
	
	for (ckX=0; ckX<xx; m[ckX++]=oo);
	
	m[0] = 0;
	for (ckX = 0; ckX < xx; ckX++)
		if (m[ckX] != oo)
			for (ckR = minR; ckR < maxR; ckR++)
				if (galima(ckX, ckX+2*ckR) && m[ckX+2*ckR] > m[ckX] + 1)
					m[ckX+2*ckR]=m[ckX]+1;
				
	ats = m[xx] != oo ? m[xx] : -1;
}


int
main ()
{
	nuskaitymas ();
	qsort(line, sizeof(line[0]), sizeof(line), cmp);
	rask ();
	rasymas();
	return 0;
}
