/*
PROG: cover
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

int mas[50][50];
int masx[50], masy[50];
int xx, yy;
int ats=10000;

void
nuskaitymas ()
{
	int ckx, cky;
	char c;
	
	FILE *f = fopen ("cover.in", "r");
	fscanf(f, "%d %d", &yy, &xx);
	fscanf(f, "%c", &c);
	for (cky = 0; cky < yy; cky++)
	{
		for (ckx = 0; ckx < xx; ckx++)
		{
			fscanf(f, "%c", &c);
			if (c == '*')
			{
				mas[ckx][cky]= 1; 
				masx[ckx]++;
				masy[cky]++;
			}
		}
		fscanf(f, "%*c");
	}
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("cover.out", "w");
	fprintf(f, "%d\n", ats);
	fclose (f);
}

void
rask (int gylis)
{
	int ckx, cky;
	int poz, pg;
	
	if (gylis >= ats)
		return;
	
	//--------------------------------------------
	poz = 0;
	for (ckx=1; ckx<xx; ckx++)
		if (masx[ckx] > masx[poz])
			poz = ckx;
	
	if (masx[poz] <= 0)
	{
		if (gylis < ats)
			ats = gylis;
		return;
	}
	
	pg=gylis;
	poz = masx[poz];
	for (ckx=0; ckx<xx; ckx++)
		if (masx[ckx] == poz)
		{
			pg++;
			masx[ckx]=-poz;
			for (cky=0; cky<yy; cky++)
				if (mas[ckx][cky])
				{
					if (mas[ckx][cky] == 1)
						masy[cky]--;
					mas[ckx][cky]++;
				}
		}
		
	rask(pg);
	
	for (ckx=0; ckx<xx; ckx++)
		if (masx[ckx] == -poz)
		{
			pg--;
			masx[ckx]=poz;
			for (cky=0;cky<yy;cky++)
			{
				if (mas[ckx][cky])
				{
					mas[ckx][cky]--;
					if (mas[ckx][cky] == 1)
						masy[cky]++;
				}
			}
		}
		
	//------------------------------------------
	poz = 0;
	for (cky=1; cky<yy; cky++)
		if (masy[cky] > masy[poz])
			poz = cky;
	
	
	poz = masy[poz];
	for (cky=0; cky<yy; cky++)
		if (masy[cky] == poz)
		{
			pg++;
			masy[cky]=-poz;
			for (ckx=0; ckx<xx; ckx++)
				if (mas[ckx][cky])
				{
					if (mas[ckx][cky] == 1)
						masx[ckx]--;
					mas[ckx][cky]++;
				}
		}
		
	rask(pg);
	
	for (cky=0; cky<yy; cky++)
		if (masy[cky] == -poz)
		{
			pg--;
			masy[cky]=poz;
			for (ckx=0;ckx<xx;ckx++)
			{
				if (mas[ckx][cky])
				{
					mas[ckx][cky]--;
					if (mas[ckx][cky] == 1)
						masx[ckx]++;
				}
			}
		}
	
}


int
main ()
{
	nuskaitymas ();
	rask (0);
	rasymas();
	return 0;
}
