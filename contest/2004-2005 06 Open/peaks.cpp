/*
PROB: peaks
LANG: C++
*/

#include <fstream>

using namespace std;

const long MAX = 1000;

int viso, virs;
long m[MAX];
long isv[MAX];
long ats;

void nuskaitymas()
{
	ifstream fin("peaks.in");
	fin >> viso >> virs;
	for (int ck = 0; ck < viso; ck++)
		fin >> m[ck];
	fin.close();
}

void rasymas()
{
	ofstream fout("peaks.out");
	fout << ats;
	fout.close();
}

long cost(int v)
{
	int poz = v;
	while (v >= 0 && 
}

bool yra_virsune(int v)
{
	if (v == 0)
	{
		int poz = 0;
		while (poz < viso - 1 && isv[poz] == 0) 
			poz++;
		if (isv[poz] >= 0)
			return false;
		else 
			return true;
	}
	
	if (v == viso - 1)
	{
		int poz = viso - 2;
		while (poz >= 0 && isv[poz] == 0)
			poz--;
		if (isv[poz] > 0)
			return true;
		else
			return false;
	}
	
	int poz = v - 1;
	while (poz >= 0 && isv[poz] == 0)
		poz--;
	if (isv[poz] < 0)
		return false;
		
	poz = v;
	while (poz < viso - 1 && isv[poz] == 0)
		poz++;
	if (isv[poz] > 0)
		return false;
	
	return true;
}

void griauk(int v)
{
	
}

void rask()
{
	// mazejimai, didejimai
	for (int ck = 0; ck < viso-1; ck++)
		isv[ck] = m[ck+1] - m[ck];
	
	// virsuniu skaiciu ir pigiausios kaina bei numeri
	long min = -oo;
	int v;
	int viso_v = 0;
	
	for (int ck = 0; ck < viso; ck++)
		if (yra_virsune(ck))
		{
			viso_v++;
			long pg = cost(ck);
			if (pg < min)
			{
				v = ck;
				min = pg;
			}
		}
	
	// kol virsuniu yra per daug
	while (viso_v > virs)
	{
		griauk(v);
		ats += min;
		
		// mazejimai, didejimai
		for (int ck = 0; ck < viso-1; ck++)
			isv[ck] = m[ck+1] - m[ck];

		// virsuniu skaiciu ir pigiausios kaina bei numeri
		min = -oo;
		viso_v = 0;
		for (int ck = 0; ck < viso; ck++)
			if (yra_virsune(ck))
			{
				viso_v++;
				long pg = cost(ck);
				if (pg < min)
				{
					v = ck;
					min = pg;
				}
			}
	}
}

int main()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
