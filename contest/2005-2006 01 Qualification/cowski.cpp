/*
PROB: cowski
LANG: C++
*/

#include <fstream>

using namespace std;

int map[100][100];
int v, xx, yy;
double minTime;
double times[100][100];


void Read()
{
	ifstream f("cowski.in");
	f >> v >> yy >> xx;
	for (int cky = 0; cky < yy; cky++)
		for (int ckx = 0; ckx < xx; ckx++)
			f >> map[ckx][cky];
	f.close();	
}

void Write()
{
	ofstream f("cowski.out");
	f.precision(2);
	f << minTime << endl;
	f.close();
}

void Do()
{
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}


