/*
PROG: yogfac
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define max(a,b) ((a) > (b) ? (a) : (b))

#define oo 1000000000
#define MAXDIGITS 10000

typedef struct {
	char digits[MAXDIGITS];         /* represent the number */
    int lastdigit;			/* index of high-order digit */
} bignum;

int viso;
int S;
int kaina[10000], kiekis[10000];
bignum pg, *suma, *SUMA, *tmp;

void
nuskaitymas()
{
	int ck;
	FILE *f = fopen("yogfac.in", "r");
	fscanf(f, "%d %d", &viso, &S);
	for (ck = 0; ck < viso; ck++)
		fscanf(f, "%d %d", &kaina[ck], &kiekis[ck]);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("yogfac.out", "w");
	int ck;
	for (ck = suma->lastdigit; ck >= 0; ck--)
		fprintf(f, "%c",'0'+ suma->digits[ck]);
	fprintf(f, "\n");
	fclose(f);
}

void
int_to_bignum(int s, bignum *n)
{
	int i;				/* counter */
	int t;				/* int to work with */

	for (i=0; i<MAXDIGITS; i++) n->digits[i] = (char) 0;

	n->lastdigit = -1;

	t = s;

	while (t > 0) {
		n->lastdigit ++;
		n->digits[ n->lastdigit ] = (t % 10);
		t = t / 10;
	}

	if (s == 0) n->lastdigit = 0;
}

void
initialize_bignum(bignum *n)
{
	int_to_bignum(0,n);
}

/*	c = a + b;	*/
void
add_bignum(bignum *a, bignum *b, bignum *c)
{
	int carry;			/* carry digit */
	int i;				/* counter */

	initialize_bignum(c);

	c->lastdigit = max(a->lastdigit,b->lastdigit)+1;
	carry = 0;

	for (i=0; i<=(c->lastdigit); i++) {
		c->digits[i] = (char) (carry+a->digits[i]+b->digits[i]) % 10;
		carry = (carry + a->digits[i] + b->digits[i]) / 10;
	}

	// zero justify c
	while ((c->lastdigit > 0) && (c->digits[ c->lastdigit ] == 0))
		c->lastdigit --;
}

void
rask()
{
	int ck;
	long min = +oo;
	long plius;
	
	initialize_bignum(suma);
	for (ck = 0; ck < viso; ck++)
	{
		min = (min < kaina[ck]) ? min : kaina[ck];
		plius = min * kiekis[ck];
		int_to_bignum(plius, &pg);
		add_bignum(suma, &pg, SUMA);
		tmp = SUMA; SUMA = suma; suma = tmp;
		min += S;
	}
	
}

int
main ()
{
	nuskaitymas();
	suma = (bignum *) malloc(sizeof(bignum));
	SUMA = (bignum *) malloc(sizeof(bignum));
	rask();
	rasymas();
	free(suma);
	free(SUMA);

	return 0;
}
