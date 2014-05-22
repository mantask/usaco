/*
PROB: lazy
LANG: C++
*/

#include <fstream>
#include <math.h>
#include <stdlib.h>

using namespace std;

const int MAX = 1000;
const long oo = 1000000000;

long m1[MAX][2], m2[MAX][2];
int kt1[MAX], kt2[MAX];
int viso1, viso2;
int kiek;
long ilg;
long ats;

int cmp(const void *sk1, const void *sk2)
{
	return ((int*)sk1)[0] - ((int*)sk2)[0];
}

void nuskaitymas()
{
	ifstream fin("lazy.in");
	int viso;
	fin >> viso >> kiek >> ilg;
	for (int ck = 0; ck < viso; ck++)
	{
		int pg;
		fin >> pg;
		if (pg == 1)
		{
			fin >> m1[viso1][0];
			m1[viso1][1] = m1[viso1][0];
			viso1++;
		}
		else
		{
			fin >> m2[viso2][0];
			m2[viso2][1] = m2[viso2][0];
			viso2++;
		}
	}
	fin.close();
}

void rasymas()
{
	ofstream fout("lazy.out");
	fout << ats << endl;
	fout.close();
}

void rask()
{
	ats = viso1 + viso2;
	qsort(m1, viso1, sizeof(m1[0]), cmp);
	qsort(m2, viso2, sizeof(m2[0]), cmp);
	
	// gaminam linked list
	for (int ck = 0; ck < viso1 - 1; ck++)
		kt1[ck] = ck + 1;
	for (int ck = 0; ck < viso2 - 1; ck++)
		kt2[ck] = ck + 1;
	kt1[viso1 - 1] = kt2[viso2 - 1] = -1;
	
	// reikalingu pakeitimu skaicius
	int pak = viso1 + viso2 - kiek;
	
	// darom pakeitimus toj pacioj eilutej
	for (int poz = 0; kt1[poz] != -1; poz = kt1[poz])
		if (m1[poz][1] == m1[kt1[poz]][0])
		{
			m1[poz][1] = m1[kt1[poz]][1];
			pak--;
			poz = kt1[poz];
		}
	for (int poz = 0; kt2[poz] != -1; poz = kt2[poz])
		if (m2[poz][1] == m2[kt2[poz]][0])
		{
			m2[poz][1] = m1[kt2[poz]][1];
			pak--;
			poz = kt2[poz];
		}
		
	// darom pakeitimus skirtingose eilutese
	if (pak <= 0)
		return;
/*	for ( ; pak > 0; pak--)
	{
		long min = +oo;
		int pg1, pg2;
		
		for (int pg1 = 0; pg 
		
	}
*/
	ats = 10;
}

int main()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
