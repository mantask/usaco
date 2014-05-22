/*
PROB: expand
LANG: C++
*/

#include <cstdio>
#include <cstdlib>
#include <cassert>

using namespace std;

const long MAX_RECT = 25000;

long totalRect;
struct Node {
	long x, y1, y2;
	long nr;
	bool start;
} nodes[MAX_RECT * 2];
long totalNonOverlapping;

bool overlaps[MAX_RECT];
struct Tree {
	Tree *lt, *gt;
	Node n;
} *tree;


void Read()
{
	FILE *f = fopen("expand.in", "r");
	fscanf(f, "%d", &totalRect);
	for (long i = 0; i < totalRect; i++)
	{
		long x1, x2, y1, y2;
		fscanf(f, "%ld %ld %ld %ld", &x1, &y1, &x2, &y2);

		nodes[2 * i].x = x1;
		nodes[2 * i].y1 = y1;
		nodes[2 * i].y2 = y2;
		nodes[2 * i].nr = i;
		nodes[2 * i].start = true;

		nodes[2 * i + 1].x = x2;
		nodes[2 * i + 1].y1 = y1;
		nodes[2 * i + 1].y2 = y2;
		nodes[2 * i + 1].nr = i;
		nodes[2 * i + 1].start = false;
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("expand.out", "w");
	fprintf(f, "%ld\n", totalNonOverlapping);
	fclose(f);
}

int cmp(const void *pn1, const void *pn2)
{
	Node *n1 = (Node*)pn1;
	Node *n2 = (Node*)pn2;
	if (n1->x == n2->x)
		return n1->start ? -1 : +1; 
	else
		return (n1->x - n2->x) < 0 ? -1 : +1;
}

inline void overlap(const Node n1, const Node n2)
{
	if (n1.y1 <= n2.y1 && n2.y1 <= n1.y2 || n2.y1 <= n1.y1 && n1.y1 <= n2.y2) 
	{
		overlaps[n1.nr] = true;
		overlaps[n2.nr] = true;
	}
}

inline bool left(const Node treeN, const Node n)
{
	if (n.y2 <= treeN.y1)
		return true;
	else if (treeN.y2 <= n.y1)
		return false;
	else
		false;
}

void treeCreate(Tree *t, Node n)
{
	t->gt = NULL;
	t->lt = NULL;
	t->n = n;
}

void treeAdd(Node n)
{
	Tree *pTree = tree;
	
	while (true)
	{
		Tree *child = left(tree->n, n) ? pTree->lt : pTree->gt;

		if (child == NULL)
		{
			//add node here
			if (left(pTree->n, n))
				child = pTree->lt = new Tree;
			else
				child = pTree->gt = new Tree;
			treeCreate(child, n);
			break;
		}
		else
		{
			// go deeper
			overlap(child->n, n);
			pTree = child;
		}
	}
}

void treeRemove(Node n)
{
	Tree *t = tree;
	
	while (true)
	{
		assert(t != NULL);

		Tree *l = t->lt;
		Tree *r = t->gt;
		
		if (l != NULL && l->n.nr == n.nr)
		{
			if (l->gt != NULL)
			{
				// assign right
				t->lt = l->gt;
				
				// assign l
				Tree *p = l->gt;
				while (p->lt != NULL)
					p = p->lt;
				p->lt = l->lt;
			}
			else if (l->lt != NULL)
			{
				t->lt = l->lt;
			}
			else
			{
				t->lt = NULL;
			}
			delete l;
			break;
		}
		else if (r != NULL && r->n.nr == n.nr)
		{
			if (r->gt != NULL)
			{
				// assign r
				t->gt = r->gt;
	
				// assign left
				Tree *p = r->gt;
				while (p->lt != NULL)
					p = p->lt;
				p->lt = r->lt;
			}
			else if (r->lt != NULL)
			{
				t->gt = r->lt;
			}
			else
			{
				t->gt = NULL;
			}
			delete r;
			break;
		}
		else
			t = left(t->n, n) ? t->lt : t->gt;
	}
}

void Do()
{
	qsort(nodes, totalRect * 2, sizeof(Node), cmp);
	
	// initialize start node
	tree = new Tree;
	tree->lt = NULL;
	tree->gt = NULL;
	tree->n.y1 = -1;
	tree->n.y2 = -1;
	tree->n.x = -1;
	
	// form tree
	for (long i = 0; i < 2 * totalRect; i++)
	{
		if (nodes[i].start)
			treeAdd(nodes[i]);
		else
			treeRemove(nodes[i]);
	}
	
	// dispose start node
	delete tree;

	// count aswer
	for (long i = 0; i < totalRect; i++)
		if (!overlaps[i])
			totalNonOverlapping++;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
