using System;

namespace SayingHelloApplication
{
    class SayingHello
    {
        public static void Main()
        {
            Console.Write("What is your name? ");
            string name = Console.ReadLine();
            Console.WriteLine("Hello, " + name + ", nice to meet you!");
        }
    }
}