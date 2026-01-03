// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
} node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 26;

// Hash table
node *table[N];

unsigned int count=0;
// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    unsigned int index=hash(word);
    node* current=table[index];
    while(current!=NULL){
        if(strcasecmp(current->word,word)==0){
            return true;
        }
        current=current->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    unsigned int hash=0;
    for(int i=0;word[i]!='\0';i++){
        hash+=toupper(word[i]) - 'A';
    }
    // TODO: Improve this hash function

    return hash%N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    char word[LENGTH + 1];
    // TODO
    FILE *file =fopen(dictionary,"r");
    if(!file){
        return false;
    }
    while(fscanf(file,"%s",word)!=EOF){
        node* n=malloc(sizeof(node));
        if(n==NULL){
            fclose(file);
            return false;
        }
        strcpy(n->word,word);
        int hashindex=hash(word);
        count++;
        n->next= table[hashindex];
        table[hashindex]=n;
}
    fclose(file);
    return true;

}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    return count;
    // return 0;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    for(int i=0;i<N;i++){
    node*current=table[i];
    while(current!=NULL){
        node*tmp=current;
        current=current->next;
        free(tmp);
    }
}
return true;

}
