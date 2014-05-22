/*
PROB: skyline
LANG: C++
*/

#include <cstdio>
#include <stack>

using namespace std;

long totalInput, width, totalBuildings;
stack<long> list;

int main()
{
	FILE *f = fopen("skyline.in", "r");
	fscanf(f, "%ld %ld\n", &totalInput, &width);
	list.push(0);
	for (long i = 0; i < totalInput; i++)
	{
		long x, y;
		fscanf(f, "%ld %ld\n", &x, &y);
		while (y < list.top())
			list.pop();
		if (y > list.top())
		{
			list.push(y);
			totalBuildings++;
		}
	}
	fclose(f);

	f = fopen("skyline.out", "w");
	fprintf(f, "%ld\n", totalBuildings);
	fclose(f);
	
	return 0;
}
