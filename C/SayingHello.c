#include <stdio.h>

void greetings (char* name)
{
    printf("Hello, %s, nice to meet you!\n", name);
    switch (name[0]) {
        case 'a':
        case 'A':
            printf("Nice you got an A");
            break;
        case 'b':
        case 'B':
            printf("B is for ...");
            break;
        case 'c':
        case 'C':
            printf("C++ is better?");
            break;
        default:
            printf("Sorry, %c", name[0]);
    }
    printf("\n");
}

int main()
{
    char* name;
    printf("What is your name? ");
    scanf("%s", name);

    greetings(name);

    return 0;
}