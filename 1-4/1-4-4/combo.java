/*
ID: vkanapo001
LANG: JAVA
PROG: combo
*/

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;


public class combo {

    static final String inputFilename = "combo.in";
    static final String outputFilename = "combo.out";

    static int n;

    static int comb1[] = new int[3];
    static int comb2[] = new int[3];

    static int total = 0;


    static void read() throws IOException {

        // Use BufferedReader rather than RandomAccessFile; it's much faster
        BufferedReader f = new BufferedReader(new FileReader(inputFilename));

        // Use StringTokenizer vs. readLine/split -- lots faster
        StringTokenizer st = new StringTokenizer(f.readLine());

        // Get line, break into tokens

        n = Integer.parseInt(st.nextToken());

        st = new StringTokenizer(f.readLine());
        for (int i = 0; i < 3; i++)
            comb1[i] = Integer.parseInt(st.nextToken());

        st = new StringTokenizer(f.readLine());
        for (int i = 0; i < 3; i++)
            comb2[i] = Integer.parseInt(st.nextToken());

        f.close();
    }

    static void write() throws IOException {
        PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(outputFilename)));
        out.println(total);
        out.close();
    }

    static boolean near(int n1, int n2) {
        return prev(prev(n1)) == n2 || prev(n1) == n2 || n1 == n2 || next(n1) == n2 || next(next(n1)) == n2;
    }

    static int next(int n1) {
        return n1 == n ? 1 : n1 + 1;
    }

    static int prev(int n1) {
        return n1 == 1 ? n : n1 - 1;
    }

    static void go() {
        for (int i0 = 1; i0 <= n; i0++)
            for (int i1 = 1; i1 <= n; i1++)
                for (int i2 = 1; i2 <= n; i2++)
                    if (near(i0, comb1[0]) && near(i1, comb1[1]) && near(i2, comb1[2]) || near(i0, comb2[0]) && near(i1, comb2[1]) && near(i2, comb2[2]))
                        total++;

    }

    public static void main(String... args) throws IOException {
        read();
        go();
        write();
        System.exit(0);
    }

}
