#include <stdio.h>
#include <stdlib.h>
#include<stdint.h>

typedef uint8_t BYTE;
int main(int argc, char *argv[])
{
    if(argc!=2){
        printf("Usage: ./recover image\n");
        return 1;
    }
    FILE *input=fopen(argv[1],"r");
    if(!input)
    {
        printf("Could not open file\n");
        return 1;
    }
    BYTE BYTES[512];
    FILE* output=NULL;
    int count=0;
    char outputfile[8];
    while(fread(BYTES,1,512,input)==512){
        if(BYTES[0]==0xff && BYTES[1]==0xd8 && BYTES[2]==0xff &&(BYTES[3] & 0xf0)==0xe0){
            if(output){
                fclose(output);
            }
            sprintf(outputfile,"%03i.jpg",count++);
            output= fopen(outputfile,"w");
        }
        if(output){
            fwrite(BYTES,1,512,output);
        }
    }
    if(output){
        fclose(output);
    }
    fclose(input);

}
