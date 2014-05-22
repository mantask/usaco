/*
PROG: juice
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define oo 1000000000;

int xx, yy;
long mas[300][300];
long jau[300][300];
long ats;

void
nuskaitymas ()
{
	int ckx, cky;
	
	FILE *f = fopen ("juice.in", "r");
	fscanf(f, "%d %d", &xx, &yy);
	for (cky=0; cky<yy; cky++)
		for (ckx=0; ckx<xx; ckx++)
			fscanf(f, "%ld", &mas[ckx][cky]);
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("juice.out", "w");
	fprintf(f, "%ld\n", ats);
	fclose (f);
}

void
info (int x, int y, long *kiek, long *minh, long kelintas)
{
	(*kiek)++;
	jau[x][y] = kelintas;

	if (0 <= x-1 && jau[x-1][y] != kelintas)
	{
		if (mas[x-1][y] == mas[x][y] && x-1 != 0)
		{
			info(x-1,y,kiek,minh,kelintas);
		}
		else
			if (mas[x-1][y] < *minh)
				*minh = mas[x-1][y];
	}
	
	if (0 <= y-1 && jau[x][y-1] != kelintas)
	{
		if (mas[x][y-1] == mas[x][y] && y-1 != 0)
		{
			info(x,y-1,kiek,minh,kelintas);
		}
		else
			if (mas[x][y-1] < *minh)
				*minh = mas[x][y-1];
	}
	
	if (x+1<xx && jau[x+1][y] != kelintas)
	{
		if (mas[x+1][y] == mas[x][y] && x+1 < xx-1)
		{
			info(x+1,y,kiek,minh,kelintas);
		}
		else
			if (mas[x+1][y] < *minh)
				*minh = mas[x+1][y];
	}

	if (y+1<yy && jau[x][y+1] != kelintas)
	{
		if (mas[x][y+1] == mas[x][y] && y+1 < yy-1)
		{
			info(x,y+1,kiek,minh,kelintas);
		}
		else
			if (mas[x][y+1] < *minh)
				*minh = mas[x][y+1];
	}
	
}

void
fill(int x, int y, long h, long hh)
{
	mas[x][y] = h;
	
	if (0 < x-1 && mas[x-1][y] == hh)
		fill(x-1,y,h, hh);
	
	if (0 < y-1 && mas[x][y-1] == hh)
		fill(x,y-1,h, hh);
	
	if (x+1<xx-1 && mas[x+1][y] == hh)
		fill(x+1,y,h, hh);

	if (y+1<yy-1 && mas[x][y+1] == hh)
		fill(x,y+1,h, hh);
}

void
rask ()
{
	long kiek, minh, kelintas=0, dh;
	int ckx, cky;
	
	do {
		dh = 0;
		for (ckx=1; ckx < xx-1; ckx++)
			for (cky=1; cky<yy-1; cky++)
			{
				kiek = 0;
				minh = oo;
				kelintas++;
				info(ckx, cky, &kiek, &minh, kelintas);
				if (minh > mas[ckx][cky])
				{
					dh += kiek*(minh-mas[ckx][cky]);
					fill (ckx, cky, minh, mas[ckx][cky]);
				}
			}
		ats += dh;
	} while (dh);
}


int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
