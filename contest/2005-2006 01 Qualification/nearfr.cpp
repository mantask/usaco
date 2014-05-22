/*
PROB: nearfr
LANG: C++
*/

#include <fstream>

using namespace std;

const long MAX_D = 32767;
struct Fraction {
	long d, n;
} fr, nearfr;

void Read()
{
	ifstream f("nearfr.in");
	f >> fr.n >> fr.d;
	f.close();	
}

void Write()
{
	ofstream f("nearfr.out");
	f << nearfr.n << ' ' << nearfr.d << endl;
	f.close();
}

inline long Cmp(long n1, long d1, long n2, long d2)
{
	return n1 * d2 - d1 * n2;
}

void Reduce(Fraction &fr)
{
	long x = fr.n;
	long y = fr.d;

	while (x != 0)
	{
		long tmp = x;
		x = y % x;
		y = tmp;
	}

	fr.n /= y;
	fr.d /= y;
}

void Do()
{
	Fraction floorfr, ceilfr;
	floorfr.n = 0;
	floorfr.d = 1;
	ceilfr.n = 1;
	ceilfr.d = 1;
	for (long ckd = 1; ckd <= MAX_D; ckd++)
	{
		long result;
		long ckn;
		// find [(ckn-1)/ckd] < [fr] <= [ckn/ckd]
		for (ckn = floorfr.n; (result = Cmp(ckn, ckd, fr.n, fr.d)) < 0; ckn++);

		// check if [floorfr] < [(ckn-1)/ckd] < [fr]
		if (Cmp(floorfr.n, floorfr.d, ckn - 1, ckd) < 0)
		{
			floorfr.d = ckd;
			floorfr.n = ckn - 1;
		}
		// check if [fr] == [ckn/ckd]
		if (result == 0)
			ckn++;
		// check if [fr] < [ckn/ckd] < [ceilfr]
		if (Cmp(ckn, ckd, ceilfr.n, ceilfr.d) < 0)
		{
			ceilfr.d = ckd;
			ceilfr.n = ckn;
		}
	}

	// find whether [ceilfr], or [floorfr] is closer to [fr]
	// if (Cmp(fr - floorfr, ceilfr - fr) < 0) 
	if (Cmp(fr.n * floorfr.d - floorfr.n * fr.d, floorfr.d, ceilfr.n * fr.d - fr.n * ceilfr.d, ceilfr.d) < 0)
		nearfr = floorfr;
	else
		nearfr = ceilfr;
	
	Reduce(nearfr);
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}

