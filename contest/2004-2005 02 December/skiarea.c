/*
PROG: skiarea
LANG: C
*/

#include <stdio.h>

long xx, yy;
long h[500][500];
long comp[500][500];
long ats;

void
nuskaitymas ()
{
	long ckx, cky;
	FILE *f = fopen ("skiarea.in", "r");
	fscanf(f, "%ld %ld", &xx, &yy);
	for (cky = 0; cky < yy; cky++)
		for (ckx = 0; ckx < xx; ckx++)
			fscanf(f, "%ld", &h[ckx][cky]);
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("skiarea.out", "w");
	fprintf(f,"%ld\n", ats);
	fclose (f);
}

void
flood_fill(long ind, long x, long y)
{
	comp[x][y] = ind;
	if (x && h[x-1][y] == h[x][y] && comp[x-1][y] == -1) 
		flood_fill(ind, x-1, y);
	if (y && h[x][y-1] == h[x][y] && comp[x][y-1] == -1) 
		flood_fill(ind, x, y-1);
	if (x+1 < xx && h[x+1][y] == h[x][y] && comp[x+1][y] == -1) 
		flood_fill(ind, x+1, y);
	if (y+1 < yy && h[x][y+1] == h[x][y] && comp[x][y+1] == -1) 
		flood_fill(ind, x, y+1);
}


void
rask ()
{
	long ckx, cky, ck;
	long ind = 0;
	long top[250000], bot[250000];
	long kiek_top=0, kiek_bot=0;
	long min, max;
	
	if (xx == 1 && yy == 1)
	{
		ats = 0;
		return;
	}
		
	
	// ---flood fill---------------------------
	for (ckx = 0; ckx < xx; ckx++)
		for (cky = 0; cky < yy; cky++)
			comp[ckx][cky] = -1;
		
	for (ckx = 0; ckx < xx; ckx++)
		for (cky = 0; cky < yy; cky++)
			if (comp[ckx][cky] == -1)
				flood_fill(ind++, ckx, cky);
			
	// ---pairs & top/bot-------------------
	for (ck = 0; ck < ind; ck++)
	{
		top[ck] = 1;
		bot[ck] = 1;
	}
	
	for (ckx = 0; ckx < xx; ckx++)
		for (cky = 0; cky < yy; cky++)
		{
			if (ckx && comp[ckx-1][cky] != comp[ckx][cky]) 
			{
				if (h[ckx-1][cky] > h[ckx][cky])
				{
					max = comp[ckx-1][cky];
					min = comp[ckx][cky];
				}
				else
				{
					min = comp[ckx-1][cky];
					max = comp[ckx][cky];
				}
				bot[max] = 0;
				top[min] = 0;
			}
			if (cky && comp[ckx][cky-1] != comp[ckx][cky]) 
			{
				if (h[ckx][cky-1] > h[ckx][cky])
				{
					max = comp[ckx][cky-1];
					min = comp[ckx][cky];
				}
				else
				{
					min = comp[ckx][cky-1];
					max = comp[ckx][cky];
				}
				bot[max] = 0;
				top[min] = 0;
			}
			if (ckx+1 < xx && comp[ckx+1][cky] != comp[ckx][cky]) 
			{
				if (h[ckx+1][cky] > h[ckx][cky])
				{
					max = comp[ckx+1][cky];
					min = comp[ckx][cky];
				}
				else
				{
					min = comp[ckx+1][cky];
					max = comp[ckx][cky];
				}
				bot[max] = 0;
				top[min] = 0;
			}
			if (cky+1 < yy && comp[ckx][cky+1] != comp[ckx][cky]) 
			{
				if (h[ckx][cky+1] > h[ckx][cky])
				{
					max = comp[ckx][cky+1];
					min = comp[ckx][cky];
				}
				else
				{
					min = comp[ckx][cky+1];
					max = comp[ckx][cky];
				}
				bot[max] = 0;
				top[min] = 0;
			}
		}
		
	for (ck = 0; ck < ind; ck++)
	{
		if (top[ck])
			kiek_top++;
		if (bot[ck])
			kiek_bot++;
	}
	ats = kiek_top > kiek_bot ? kiek_top : kiek_bot;
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
