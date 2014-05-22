/*
PROG: obstacle
LANG: C
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define oo 1000000000

long lent[50001][2];
long yy, xx;
long ilg;

void
nuskaitymas ()
{
	int ck;
	FILE *f = fopen ("obstacle.in", "r");
	fscanf(f, "%ld %ld", &yy, &xx);
	for (ck = 1; ck <= yy; ck++)
		fscanf(f, "%ld %ld", &lent[ck][0], &lent[ck][1]);
	lent[0][0] = lent[0][1] = 0;
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("obstacle.out", "w");
	fprintf(f, "%ld\n", ilg);
	fclose (f);
}

void
rask ()
{
	long m[50001][2];
	long ckY, ck, y, pg;
	
	for (ck = 0; ck < yy; ck++)
		m[ck][0] = m[ck][1] = oo;
	
	m[yy][0] = xx - lent[yy][0];
	m[yy][1] = lent[yy][1] - xx;
	
	for (ckY = yy; ckY > 0; ckY--)
	{
		if (m[ckY][0] != oo)
		{
			y = ckY - 1;
			while (y > 0 && (lent[ckY][0] <= lent[y][0] || lent[y][1] <= lent[ckY][0])) 
				y--;
			if (m[ckY][0] + (pg = labs(lent[ckY][0] - lent[y][0])) < m[y][0])
				m[y][0] = m[ckY][0] + pg;
			if (m[ckY][0] + (pg = labs(lent[ckY][0] - lent[y][1])) < m[y][1])
				m[y][1] = m[ckY][0] + pg;
		}
		if (m[ckY][1] != oo)
		{
			y = ckY - 1;
			while ((y > 0) && (lent[ckY][1] <= lent[y][0] || lent[y][1] <= lent[ckY][1])) 
				y--;
			if (m[ckY][1]+ (pg = labs(lent[ckY][1] - lent[y][0])) < m[y][0])
				m[y][0] = m[ckY][1] + pg;
			if (m[ckY][1] + (pg = labs(lent[ckY][1] - lent[y][1])) < m[y][1])
				m[y][1] = m[ckY][1] + pg;
		}
	}
	
	ilg = m[0][0];
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
