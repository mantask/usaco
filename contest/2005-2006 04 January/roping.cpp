/*
PROB: roping
LANG: C++
*/

#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <cstring>

using namespace std;

typedef struct { long x, y; double angle; } Point;


int totalAngles;
Point points[150];

long radius;

int totalCircles;
Point circles[100];

bool ropes[150][150];
int f[150][150];

int maxRopes;


void Read()
{
	FILE* f = fopen("roping.in", "r");
	fscanf(f, "%d %d %ld\n", &totalAngles, &totalCircles, &radius);
	for (int i = 0; i < totalAngles; i++)
	{
		fscanf(f, "%ld %ld\n", &points[i].x, &points[i].y);
	}
	for (int i = 0; i < totalCircles; i++)
	{
		fscanf(f, "%ld %ld\n", &circles[i].x, &circles[i].y);
	}
	fclose(f);
}

void Write()
{
	FILE* f = fopen("roping.out", "w");
	fprintf(f, "%d\n", maxRopes);
	fclose(f);
}

int AngleCmp(const void *a1, const void *a2)
{
	Point *a = (Point*)a1;
	Point *b = (Point*)a2;
    if (a->angle < b->angle) return -1;
    if (a->angle > b->angle) return +1;
    return 0;
}

void Sort()
{
    // find middle point
    double midX = 0, midY = 0;
    for (int i = 0; i < totalAngles; i++)
    {
        midX += (double)points[i].x / totalAngles;
        midY += (double)points[i].y / totalAngles;
    }

    // find angle for each vertice
    for (int i = 0; i < totalAngles; i++)
    {
        points[i].angle = atan2(points[i].y - midY, points[i].x - midX);
    }

    // sort vertices by angles
    qsort(points, totalAngles, sizeof(points[0]), AngleCmp);
}

bool Intersects(Point p1, Point p2, Point c)
{
	Point u; 
	u.x = c.x - p1.x; 
	u.y = c.y - p1.y;

	Point v;
	v.x = p2.x - p1.x;
	v.y = p2.y - p1.y;

	double uLen = sqrt((double)u.x * u.x + u.y * u.y);
	double vLen = sqrt((double)v.x * v.x + v.y * v.y);

	double cosine = (u.x * v.x + u.y * v.y) / uLen / vLen;
	
	return radius >= uLen* sqrt(1 - cosine * cosine);
}

int F(int v1, int v2)
{
	int maxRopes = 0;

	// start from next and finish with one before last one
	for (int i = (v1 + 1) % totalAngles; i != v2; i = (i + 1) % totalAngles)
	{
		// precompute values
		if (f[v1][i] != -1) { f[v1][i] = F(v1, i); }
		if (f[i][v2] != -1) { f[i][v2] = F(i, v2); }

		if (f[v1][i] + f[i][v2] > maxRopes)
			maxRopes = f[v1][i] + f[i][v2];
	}

	if (ropes[v1][v2])
		maxRopes++;

	return maxRopes;
}

int DP()
{
	// initialize DP table with emptiness
	for (int x = 0; x < totalAngles; x++)
		for (int y = 0; y < totalAngles; y++)
			f[x][y] = -1;

	// zero cases: neighbours have zero ropes
	for (int i = 0; i < totalAngles; i++)
		f[i][(i + 1) % totalAngles] = 0;
	
	// go DP
	maxRopes = 0;
	for (int i = 0; i < totalAngles; i++)
	{
		int tmpMaxRopes = F(i, (i + totalAngles - 1) % totalAngles);
		if (tmpMaxRopes > maxRopes)
		{
			maxRopes = tmpMaxRopes;
		}
	}
	return maxRopes;
}

void CreateRopes()
{
	for (int v1 = 0; v1 < totalAngles - 1; v1++)
	{
		// rope from self to self or from self to neighbour not available
		ropes[v1][v1] = false;
		ropes[v1][(v1 + 1) % totalAngles] = false;

		for (int v2 = v1 + 2; v2 < totalAngles; v2++)
		{
			// check all circles
			bool ok = true;
			for (int i = 0; i < totalCircles; i++)
			{
				if (Intersects(points[v1], points[v2], circles[i]))
				{
					ok = false;
					break;
				}
			}
			
			// assign if rope between v1-v2 is available or not
			ropes[v1][v2] = ok;
			ropes[v2][v1] = ok;
		}
	}

	// special case
	ropes[0][totalAngles] = false;
	ropes[totalAngles][0] = false;
}

void Do()
{
	// sort points clockwise
	Sort();

	// create a list of all possible ropes
	CreateRopes();

	// find maxRopes with DP
	maxRopes = DP();
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
