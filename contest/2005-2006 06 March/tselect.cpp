/*
PROB: tselect
LANG: C++
*/

#include <cstdio>

const int MAX_COWS = 500;

int totalCows;
int minGallons;
int gallons[MAX_COWS];
int parent[MAX_COWS];
int maxRel;

void Read()
{
	FILE *f = fopen("tselect.in", "r");
	fscanf(f, "%d %d", &totalCows, &minGallons);
	for (int i = 0; i < totalCows; i++)
	{
		fscanf(f, "%d %d", &gallons[i], &parent[i]);
		parent[i]--;
		if (parent[i] == -1) { parent[i] = i; }
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("tselect.out", "w");
	fprintf(f, "%d\n", maxRel);
	fclose(f);
}

void Do()
{
	const int IN_TREE = 0;
	const int HAS_REL = 1;
	const int NOT_IN = 2;
	int tree[MAX_COWS];

	int curSum = 0;

	// teigiamus itraukiam, neigiamu ne
	for (int i = 0; i < totalCows; i++)
	{
		if (gallons[i] >= 0)
		{
			curSum += gallons[i];
			tree[i] = IN_TREE;
		}
		else
		{
			tree[i] = NOT_IN;
		}
	}

	if (curSum < minGallons)
	{
		maxRel = -1;
		return;
	}

	// pazymim tuos, kurie turi rysiu
	for (int i = 0; i < totalCows; i++)
	{
		if (tree[i] == IN_TREE && tree[parent[i]] == NOT_IN)
		{
			tree[parent[i]] = HAS_REL;
		}

		if (tree[parent[i]] == IN_TREE && tree[i] == NOT_IN)
		{
			tree[i] = HAS_REL;
		}
	}

	while (true)
	{
		// imam pigiausia
		int cheapest = -1;
		for (int i = 0; i < totalCows; i++)
		{
			if (tree[i] == HAS_REL && (cheapest == -1 || gallons[cheapest] < gallons[i]))
			{
				cheapest = i;
			}
		}

		if (cheapest == -1) { break; }

		curSum += gallons[cheapest];
		if (curSum < minGallons) { break; }

		// itraukiam i medi
		tree[cheapest] = IN_TREE;

		// pazymim teva
		if (tree[parent[cheapest]] == NOT_IN)
		{ 
			tree[parent[cheapest]] = HAS_REL; 
		}

		// pazymim vaikus
		for (int i = 0; i < totalCows; i++)
		{
			if (parent[i] == cheapest && tree[i] == NOT_IN) 
			{
				tree[i] = HAS_REL;
			}
		}
	}

	// randam rysiu skaiciu
	maxRel = 0;
	for (int i = 0; i < totalCows; i++)
	{
		if (tree[i] == IN_TREE && tree[parent[i]] == IN_TREE && i != parent[i])
		{
			maxRel++;
		}
	}
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
