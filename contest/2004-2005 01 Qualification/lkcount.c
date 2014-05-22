/*
PROG: lkcount
LANG: C
*/

#include <stdio.h>


int viso;
int xx, yy;
int m[100][100];

void
nuskaitymas ()
{
	int ckx, cky;
	char c;
	FILE *f = fopen ("lkcount.in", "r");
	fscanf (f, "%d %d", &yy, &xx);
	fscanf (f, "%*c");
	for (cky = 0; cky < yy; cky++)
	{
		for (ckx = 0; ckx < xx; ckx++)
		{
			fscanf (f, "%c", &c);
			m[ckx][cky] = (c == 'W') ? -1 : 0;
		}
		fscanf (f, "%*c");
	}
	fclose (f);
}

void
rasym ()
{
	FILE *f = fopen ("lkcount.out", "w");
	fprintf (f, "%d\n", viso);
	fclose (f);
}

void
lisk (int x, int y)
{
	m[x][y] = 0;
	if (x > 0)
	{
		if (m[x-1][y] == -1)
			lisk (x-1, y);
		if (y > 0 && m[x-1][y-1] == -1)
			lisk (x-1, y-1);
		if (y < yy-1 && m[x-1][y+1] == -1)
			lisk(x-1, y+1);
	}
	if (x < xx-1)
	{
		if (m[x+1][y] == -1)
			lisk(x+1,y);
		if (y > 0 && m[x+1][y-1] == -1)
			lisk(x+1, y-1);
		if (y < yy-1 && m[x+1][y+1] == -1)
			lisk(x+1, y+1);
	}
	if (y > 0 && m[x][y-1] == -1)
		lisk(x, y-1);
	if (y < yy-1 && m[x][y+1] == -1)
		lisk(x, y+1);

}

void
rask ()
{
	int ckx, cky;
	viso = 0;
	for (ckx = 0; ckx < xx; ckx++)
		for (cky = 0; cky < yy; cky++)
			if (m[ckx][cky] == -1)
			{
				viso++;
				lisk (ckx, cky);
			}
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasym();
	return 0;
}
