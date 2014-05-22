/*
PROB: cell
LANG: C++
*/

#include <cstdio>

int nr;
int totalButtons, totalLettes;
int totalWords;

char word[11][000];

char breaks[26];

int maxWords;
char maxBreaks[26];


void Read()
{
	FILE *f = fopen("cell.in", "r");
	fscanf(f, "%d\n", &nr);
	fscanf(f, "%d %d\n", &totalButtons, &totalLetters);
	fscanf(f, "%d\n", &totalWords);
	for (int i = 0; i < totalWords; i++)
	{
		fscanf(f, "%s\n", &word[i]);
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("cell.out", "w");
	fprintf(f, "#FILE cell %d\n", nr);
	fprintf(f, "%d\n", maxWords);

	for (int j = 0; j < maxBreaks[0]; j++) { fprintf(f, "%c", 'A' + j);	}
	fprintf(f, "\n");

	for (int i = 1; i < totalButtons - 1; i++)
	{
		for (int j = maxBreaks[i]; j < maxBreaks[i + 1]; j++) {	fprintf(f, "%c", 'A' + j); }
		fprinf(f, "\n");
	}

	for (int j = maxBreaks[totalButtons-1]; j < totalLetters; j++) { fprintf(f, "%c", 'A' + j);	}
	fprintf(f, "\n");

	fclose(f);
}

int CheckWords()
{
	int val[26];
	for (int i = 0; i < totalLetters
\}

void Generate(int which, int from)
{
	// if all breaks have been generated
	if (which == totalButtons)
	{
		int tmp = CheckWords();
		if (tmp > maxWords)
		{
			maxWords = tmp;
			for (int i = 0; i < totalButtons; i++)
			{
				maxBreaks[i] = breaks[i];
			}
		}
		return;
	}

	for (int i = from; i < totalLetters; i++)
	{
		breaks[which] = i;
		Generate(which+1, i+1);
	}
}

void Do()
{
	// add first letter A
	breaks[0] = 1;

	// generate all breaks
	Generate(1, 1);
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
