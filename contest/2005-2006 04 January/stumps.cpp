/*
PROB: stumps
LANG: C++
*/

#include <cstdio>

using namespace std;


int main()
{
	FILE* fin = fopen("stumps.in", "r");
	FILE* fout = fopen("stumps.out", "w");

	int total;
	fscanf(fin, "%d\n", &total);
	
	int old, cur, d;
	
	// 1st element
	fscanf(fin, "%d\n", &cur);
	
	// other elements
	for (int i = 1; i < total; i++)
	{
		old = cur;
		fscanf(fin, "%d\n", &cur);
		if ((i == 1 || d >= 0) && cur - old <= 0) { fprintf(fout, "%d\n", i); }
		d = cur - old;
	}

	// last element
	if (cur - old >= 0) { fprintf(fout, "%d\n", total);  }

	fclose(fin);
	fclose(fout);
	
	return 0;
}
