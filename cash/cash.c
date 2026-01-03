#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int quarter = 25;
    int nickel = 10;
    int dime = 5;
    int penny = 1;
    int change = get_int("Please give me your money :) ");
    while (change < 0)
    {
        change = get_int("Please give me your money :) ");
    }
    int coins = 0;
    while (change > 0)
    {
        if (change >= quarter)
        {
            change -= quarter;
            coins++;
        }
        else if (change >= nickel)
        {
            change -= nickel;
            coins++;
        }
        else if (change >= dime)
        {
            change -= dime;
            coins++;
        }
        else
        {
            change -= penny;
            coins++;
        }
    }
    printf("%i\n", coins);
    return 0;
}
