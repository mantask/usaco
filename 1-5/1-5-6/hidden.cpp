/*
ID: vkanapo001
LANG: C++
PROB: hidden
*/

using namespace std;
#include <fstream>
#include <string>

const long N = 100000;
int ats;
int viso;
char m[N+1]; // jau turi buti uznulintas
bool paz[N];

void nuskaitymas()
{
	ifstream f("hidden.in");
	f >> viso;
	char c;
	for (int kiek = 0; kiek < viso; kiek++)
	{
		do {
			f >> c;
		} while (c == '\n');
		m[kiek] = c;
	}
	f.close();
}

void rasymas()
{
	ofstream f("hidden.out");
	f << ats << endl;
	f.close();
}

inline long kitas(long poz, long plius)
{
	poz += plius;
	if (poz >= viso)
		poz -= viso;
	return poz;
}

void rask()
{
	long kiek;
	long maz;
	bool jau;

	// isrenkam pirma maziausia
	maz = 0;
	kiek = 1;
	for (long ck = 1; ck < viso; ck++)
		if (m[ck] < m[maz])
		{
			maz = ck;
			kiek = 1;
		}
		else if (m[ck] == m[maz])
			kiek++;
	
	// paziurim, ar ju yra daugiau nei vienas	
	if (kiek == 1)
	{
		ats = maz; // grazinti kairiausia: aaabbb[a]aa
		return;
	}

	// pazymim pirmus maziausius 
	for (long ck = 0; ck < viso; ck++)
		if (m[ck] == m[maz])
			paz[ck] = true;
	
	for (long plius = 1; ; plius++)
	{
		// randam maziausia "plius"-taja raide
		kiek = 0;
		jau = false;
		for (long ck = 0; ck < viso; ck++)
			if (paz[ck])
			{
				if (m[kitas(ck,plius)] < m[kitas(maz,plius)])
				{
					maz = ck;
					kiek = 1;
					jau = paz[kitas(ck,plius)];
				}
				else if (m[kitas(ck,plius)] == m[kitas(maz,plius)])
				{
					kiek++;
					jau |= paz[kitas(ck,plius)];
				}
			}
		
		// jei liko vienas zodis, tai jis ir yra atsakymas
		if (kiek == 1)
		{
			ats = maz;
			return;
		}
		
		// jei nors viena "plius"-toji maziausioji raide yra zodzio pradzia
		if (jau)
		{
			// randam ta vieta, nuo kurios susidaro ilgiausia grandine
			long max_ilg = 0;
			for (long ck = 0; ck < viso; ck++)
				if (paz[ck])
				{
					long poz = ck;
					long ilg = 1;
					while (kitas(poz,plius) != ck && paz[kitas(poz,plius)])
					{
						ilg++;
						poz = kitas(poz,plius);
					}
					if (max_ilg < ilg)
					{						
						ats = ck;
						max_ilg = ilg;
					}
					// jei rasti du vienodo ilgio zodziai, lyginam pagal tolimesnias raides
					else if (max_ilg == ilg)
					{
						long poz1 = kitas(ats, ilg*plius);
						long poz2 = kitas(ck, ilg*plius);
						while (poz1 != ats && m[poz1] == m[poz2]) 
						{
							poz1 = kitas(poz1, 1);
							poz2 = kitas(poz2, 1);
						}
						if (poz1 != ats && m[poz1] > m[poz2])
							ats = ck;
					}
					ck += ilg*plius - 1;
				}
			return;
		}
	
		// atzymim zodzius, kuriu "plius"-toji raide yra didesne uz maziausia
		for (long ck = 0; ck < viso; ck++)
			if (paz[ck] && m[kitas(ck,plius)] != m[kitas(maz,plius)])
				paz[ck] = false;
	}
}

int main()
{
	nuskaitymas();
	rask();
	rasymas();
	return 0;
}
