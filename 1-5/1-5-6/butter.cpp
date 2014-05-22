/*
ID: vkanapo001
LANG: C++
PROG: butter
*/ 

/*
	Imam kiekvienà virðûnæ su karve ir nuo jos paskaièiuojam maþiausius atstumus
	iki kiekvienos kitos virðûnës. Kaupiam tu atstumu suma.	Tam naudojam min-Heapa
	su Dijkstra. Tada isrenkam virsune, iki kurios trumpiausiu keliu suma yra
	maziausia.

	O(N*P*log(P))


	Galimi patobulinimai:
		heapo realizacija
 */

using namespace std;
#include <fstream>


const int oo = 1000000000;

int viso_karv, viso_virs;
int karv[500];

int kiek_karv[800];

struct { int v, sv; } g[800][800];
int suma[800];
int kiek_v[800];
int ats;

// pas mane nekompiliuoja, bet usaco priima

template <class type> void swap(type &sk1, type &sk2)
{
	type pg = sk1;
	sk1 = sk2;
	sk2 = pg;
}

class Heap
{
	public:
		Heap() { }
		bool is_empty() { return ilg == 0; }
		int get_min();
		void insert(int, int);
		void change_key(int, int);
		void clean() { ilg = 0; }
	private:
		void up(int);
		void down(int);
		int ilg;
		struct { int sv, v; } m[1000];
		int v_poz[1000];
} heap;

inline void Heap::down(int poz)
{
	int next;
	
	if (2 * poz >= ilg)
		next = poz;
	else if (2 * poz + 1 < ilg)
		next = (m[poz*2].sv < m[poz*2+1].sv) ? poz*2 : poz*2+1;
	else
		next = poz*2;
	
	while (m[poz].sv > m[next].sv)
	{
		swap(m[poz], m[next]);
		swap(v_poz[m[next].v], v_poz[m[poz].v]);
		poz = next;
	
		if (2 * poz >= ilg)
			next = poz;
		else if (2 * poz + 1 < ilg)
			next = (m[poz*2].sv < m[poz*2+1].sv) ? poz*2 : poz*2+1;
		else
			next = poz*2;
	}
}

inline void Heap::up(int poz)
{
	while (poz != 0 && m[poz/2].sv > m[poz].sv)
	{
		swap(v_poz[m[poz/2].v], v_poz[m[poz].v]);
		swap(m[poz/2], m[poz]);
		poz /= 2;
	}
}
void Heap::insert(int v, int sv)
{
	int poz = ilg++;
	m[poz].sv = sv;
	m[poz].v = v;
	v_poz[v] = poz;
	up(poz);
}


int Heap::get_min()
{
	int pg = m[0].v;
	m[0] = m[--ilg];
	v_poz[m[0].v] = 0;
	down(0);
	return pg;
}

void Heap::change_key(int v, int sv)
{
	int pg_sv = m[v_poz[v]].sv;
	m[v_poz[v]].sv = sv;
	if (pg_sv < sv)
		down(v_poz[v]);
	else if (pg_sv > sv)
		up(v_poz[v]);
}

void nuskaitymas()
{
	int kiek, v1, v2, pg;
	ifstream f ("butter.in");
	f >> viso_karv >> viso_virs >> kiek;
	for (int ck = 0; ck < viso_karv; ck++)
	{
		f >> karv[ck];
		karv[ck]--;
		// fiksuojam, kiek karviu sedi sioje virsuneje
		kiek_karv[karv[ck]]++;
	}
	for (int ck = 0; ck < kiek; ck++)
	{
		f >> v1 >> v2 >> pg;
		v1--; v2--;
		g[v1][kiek_v[v1]].sv = pg;
		g[v1][kiek_v[v1]].v = v2;
		kiek_v[v1]++;
		g[v2][kiek_v[v2]].sv = pg;
		g[v2][kiek_v[v2]].v = v1;
		kiek_v[v2]++;
	}
	f.close();
}

void rasymas()
{
	ofstream f("butter.out");
	f << ats << endl;
	f.close();
}

void pildyk(int v)
{
	int pg_v;
	int ilg[800];

	for (int ck = 0; ck < viso_virs; ilg[ck++] = +oo);
	ilg[v] = 0;

	// idedam pirma virsune i heap'a
	heap.clean();
	heap.insert(v, 0);
		
	while (!heap.is_empty())
	{
		// paimam artimiausia neaplankyta virsune
		pg_v = heap.get_min();
	
		// skaiciuojam globalia keliu ilgiu suma iki duotos virsunes
		suma[pg_v] += ilg[pg_v] * kiek_karv[v];

		// nagrinejam kaimynes, i kurias galima patekti greiciau nei anksciau
		for (int ck = 0; ck < kiek_v[pg_v]; ck++)
			if (ilg[g[pg_v][ck].v] > ilg[pg_v] + g[pg_v][ck].sv)
			{
				// jei virsune dar nebuvo itraukta i heap'a, itraukiam
				if (ilg[g[pg_v][ck].v] == +oo)
					heap.insert(g[pg_v][ck].v, ilg[pg_v] + g[pg_v][ck].sv);
				// jei virsune buvo itraukta i heapa, atnaujinam ilgi heap'e
				else
					heap.change_key(g[pg_v][ck].v, ilg[pg_v] + g[pg_v][ck].sv);

				ilg[g[pg_v][ck].v] = ilg[pg_v] + g[pg_v][ck].sv;
			}
	}
	
}

void
rask()
{
	// uzpildom masyva SUMA
	for (int ck_k = 0; ck_k < viso_karv; ck_k++)
		if (kiek_karv[karv[ck_k]] > 0)
		{
			pildyk(karv[ck_k]);
			kiek_karv[karv[ck_k]] = 0;
		}
	
	// perrenkam visas vietas kubui ir paskaiciuojam jam ilgiu suma is kiekvienos virsunes
	ats = suma[0];
	for (int ck_v = 1; ck_v < viso_virs; ck_v++)
		if (suma[ck_v] < ats)
			ats = suma[ck_v];
}

int main()
{
	nuskaitymas();
	rask();
	rasymas();
	return 0;
}
