using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace test
{
    class Test
    {

        const string inputFilename = "test.in";
        const string outputFilename = "test.out";

        static int i1;
        static int i2;

        static int sum;

        static void Read()
        {
            using (StreamReader sr = new StreamReader(inputFilename))
            {
                string[] lines = sr.ReadLine().Split();

                i1 = int.Parse(lines[0]);
                i2 = int.Parse(lines[1]);
            }
        }

        static void Write()
        {
            using (StreamWriter sr = new StreamWriter(outputFilename))
            {
                sr.WriteLine(sum);
            }
        }

        static void Go()
        {
            sum = i1 + i2;
        }

        static int Main(string[] args)
        {
            Read();
            Go();
            Write();
            return 0;
        }

    }
}
