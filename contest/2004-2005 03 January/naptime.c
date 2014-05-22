/*
PROG: naptime
LANG: C
*/

/*	nap[from][len] = max<i=2..len>(sum<j=from+1..from+i-1>(mas[j]) + nap[from+i][len-i])
*/

#include <stdio.h>
#include <stdlib.h>

int viso, miega;
long mas[3830];
long ats;

void
nuskaitymas ()
{
	int ck;
	
	FILE *f = fopen ("naptime.in", "r");
	fscanf(f, "%d %d", &viso, &miega);
	for (ck =0; ck<viso; ck++)
		fscanf(f, "%ld", &mas[ck]);
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("naptime.out", "w");
	fprintf(f, "%ld\n", ats);
	fclose (f);
}

void
rask ()
{
	long m[100][100];
	int ck_goto, ck_dur;
	
	for (ck_goto=0; ck_goto<viso; ck_goto++)
		m[ck_goto][1] = 0;
	
	for (ck_goto=0; ck_goto<viso; ck_goto++)
		for (ck_dur=2; ck_dur<=miega; ck_dur++)
			m[ck_goto][ck_dur]=m[ck_goto][ck_dur-1]+mas[(ck_goto+ck_dur)%viso];
		
	for (ck_goto=0; ck_goto<viso; ck_goto++)
		if (ats < m[ck_goto][miega])
			ats = m[ck_goto][miega];
}


int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
