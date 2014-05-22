/*
PROG: bcatch
LANG: C
*/

#include <stdio.h>

int kiek[2][1000];
int viso_switch;
int viso_laikas;
int ats;

void
nuskaitymas ()
{
	int min;
	int ck, m, sm = -1;
	FILE *f = fopen ("bcatch.in", "r");
	fscanf (f, "%d %d", &min, &viso_switch);
	for (ck = 0; ck < min; ck++)
	{
		fscanf (f, "%d", &m);
		m--;
		if (sm != m)
			viso_laikas++;
		kiek[m][viso_laikas-1]++;
		sm = m;
	}
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("bcatch.out", "w");
	fprintf (f, "%d\n", ats);
	fclose (f);
}

void
rask ()
{
	int ob[2][31][1000];
	int ck_medis, ck_switch, ck_laikas, pg;
	
	for (ck_medis = 0; ck_medis < 2; ck_medis++)
		for (ck_switch = 0; ck_switch <= viso_switch; ck_switch++)
		{
			ob[ck_medis][ck_switch][viso_laikas-1] = kiek[ck_medis][viso_laikas-1];
			if (ck_switch > 0)
			{
				pg = kiek[ck_medis^1][viso_laikas-1];
				if (pg > ob[ck_medis][ck_switch][viso_laikas-1])
					ob[ck_medis][ck_switch][viso_laikas-1] = pg;
			}
		}
			
	for (ck_laikas = viso_laikas-2; ck_laikas >= 0; ck_laikas--)
		for (ck_medis = 0; ck_medis < 2; ck_medis++)
			for (ck_switch = 0; ck_switch <= viso_switch; ck_switch++)
			{
				ob[ck_medis][ck_switch][ck_laikas] = ob[ck_medis][ck_switch][ck_laikas+1] + kiek[ck_medis][ck_laikas];
				if (ck_switch)
				{
					pg = ob[ck_medis^1][ck_switch-1][ck_laikas+1] + kiek[ck_medis^1][ck_laikas];
					if (pg > ob[ck_medis][ck_switch][ck_laikas])
						ob[ck_medis][ck_switch][ck_laikas] = pg;
				} 
			}
			
	ats = ob[0][viso_switch][0];
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
