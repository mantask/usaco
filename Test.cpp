#include <cstdio>
#include <string>

using namespace std;

string inputFilename("test.in");
string outputFilename("test.out");

int i1, i2;
int sum;

void Read()
{
	FILE *f = fopen(inputFilename.c_str(), "r");
	fscanf(f, "%d %d", &i1, &i2);
	fclose(f);
}

void Write()
{
	FILE *f = fopen(outputFilename.c_str(), "w");
	fprintf(f, "%d\n", sum);
	fclose(f);
}

void Do()
{
	sum = i1 + i2;
}

int main()
{
	Read();
	Do();
	Write();
	return 0;
}



