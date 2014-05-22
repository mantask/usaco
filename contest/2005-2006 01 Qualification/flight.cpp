/*
PROB: flight
LANG: C++
*/

#include <fstream>
#include <math>
#include <string>

using namespace std;


struct Group {
	long from, to;
	int cows;
} groupForward[50000];
long groups, farms, capacity;
long totalTaken;


void Read()
{
	ifstream f("flight.in");
	f >> groups >> farms >> capacity;
	for (int ck = 0; ck < groups; ck++)
		f >> 
	f.close();	
}

void Write()
{
	ofstream f("flight.out");
	f << totalTaken;
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


