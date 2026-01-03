#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int compute_score(string word, int scores[])
{
    int score = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        if (isupper(word[i]))
        {
            score += scores[word[i] - 'A'];
        }
        else
        {
            score += scores[word[i] - 'a'];
        }
    }
    return score;
}
int main(void)
{
    int scores[26] = {1, 3, 3, 2,  1, 4, 2, 4, 1, 8, 5, 1, 3,
                      1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
    //              a b c d e f g h i j k l m n o p q  r s t u v w x y z
    string word1 = get_string("Enter Player 1: ");
    string word2 = get_string("Enter Player 2: ");
    int score1 = compute_score(word1, scores);
    int score2 = compute_score(word2, scores);

    if (score1 > score2)
    {
        printf("Player 1 Wins!\n");
    }
    else if (score1 == score2)
    {
        printf("Tie\n");
    }
    else
    {
        printf("Player 2 Wins!\n");
    }
}
