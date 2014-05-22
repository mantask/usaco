/*
PROG: secret
LANG: C
*/

#include <stdio.h>


void
nuskaitymas()
{
	FILE *f = fopen("secret.in", "r");
	fscanf(f, "%d", &);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("secret.out", "w");
	fprintf(f, "%d\n", ats);
	fclose(f);
}

void
rask()
{
}

int
main ()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
