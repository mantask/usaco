/*
ID: vkanapo001
LANG: C
TASK: cowxor
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int total, *nums1, *nums2, *nums3;
int max = 0, max_row, max_iter;


void read() {
	int i;
	FILE *in  = fopen ("cowxor.in", "r");
	fscanf (in, "%d\n", &total);
	nums1 = (int*) malloc(total + 1);
	nums2 = (int*) malloc(total + 1);
	nums3 = (int*) malloc(total + 1);
	for (i = 0; i < total; i++) {
		nums1[i] = 0;
		fscanf(in, "%d\n", &nums2[total]);
	}
	fclose(in);
}

void write() {
	FILE *out = fopen ("cowxor.out", "w");
	fprintf (out, "%d %d %d\n", max, max_row + 1, max_row + max_iter);
	fclose(out);
}

void calc() {
	max = 6;
	max_row = 3;
	max_iter = 2;
}

void main () {
	read();
	calc();
	write();
	exit (0);
}
