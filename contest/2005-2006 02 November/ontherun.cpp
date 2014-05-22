/*
PROB: ontherun
LANG: C++
*/

#include <cstdio>
#include <cstdlib>

const long EMPTY = -1;

long total, start;
long clumps[1000];
long left[1000];
long right[1000];
long staleness;


void Read()
{
	FILE *f = fopen("ontherun.in", "r");
	fscanf(f, "%ld %ld", &total, &start);
	for (int ck = 0; ck < total; ck++)
	{
		fscanf(f, "%ld", &clumps[ck]);
		
		// if start is on clump
		if (clumps[ck] == start)
		{
			ck--;
			total--;
		}
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("ontherun.out", "w");
	fprintf(f, "%ld\n", staleness);
	fclose(f);
}

long F(long pos, long t);

inline long min(long a, long b) { return (a < b) ? a : b; }

inline long gotoLeft(long pos, long t)
{
	right[left[pos]] = right[pos];
	left[right[pos]] = left[pos];
	long result = F(left[pos], t + (clumps[pos] - clumps[left[pos]]));
	right[left[pos]] = pos;
	left[right[pos]] = pos;
	return result;
}

inline long gotoRight(long pos, long t)
{
	right[left[pos]] = right[pos];
	left[right[pos]] = left[pos];
	long result = F(right[pos], t + (clumps[right[pos]] - clumps[pos]));
	right[left[pos]] = pos;
	left[right[pos]] = pos;
	return result;
}

long F(long pos, long t)
{
	if (left[pos] == EMPTY)
	{
		// the end
		if (right[pos] == EMPTY)
			return t;
		
		return t + gotoRight(pos, t);
	}
	else if (right[pos] == EMPTY)
	{
		return t + gotoLeft(pos, t);
	}
	else // none is empty
	{
		long tLeft = gotoLeft(pos, t);
		long tRight = gotoRight(pos, t);
		return t + min(tLeft, tRight);
	}
}

int cmp(const void* a, const void* b)
{
	long* aa = (long*)a;
	long* bb = (long*)b;
	long result = *aa - *bb; 
	if (result < 0)
		return -1;
	else if (result > 0)
		return +1;
	else // result == 0
		return 0;
}

void Do()
{
	// add current position to the list
	clumps[total++] = start;
	
	// sort the clumps
	qsort(clumps, total, sizeof(long), cmp);
	
	// create a linked list of clumps
	right[0] = 1;
	left[0] = EMPTY;
	for (int ck = 1; ck < total - 1; ck++)
	{
		right[ck] = ck + 1;
		left[ck] = ck - 1;
	}
	right[total-1] = EMPTY;
	left[total-1] = total - 2;
	
	// find the index of start
	long startInd;
	for (int ck = 0; ck < total; ck ++)
		if (start == clumps[ck])
		{
			startInd = ck;
			break;
		}
	
	// launch the DP
	staleness = F(startInd, 0);
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
