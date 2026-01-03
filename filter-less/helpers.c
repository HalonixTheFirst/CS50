#include<math.h>
#include "helpers.h"

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for(int i = 0; i < height; i++)
    {
        for(int j = 0; j < width; j++)
        {
            int red = image[i][j].rgbtRed;
            int blue = image[i][j].rgbtBlue;
            int green = image[i][j].rgbtGreen;

            int mean = round((red + green + blue) / 3.0);

            image[i][j].rgbtRed = mean;
            image[i][j].rgbtBlue = mean;
            image[i][j].rgbtGreen = mean;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for(int i=0;i<height;i++){
    for(int j=0;j<width;j++){
        int red=image[i][j].rgbtRed;
        int green=image[i][j].rgbtGreen;
        int blue=image[i][j].rgbtBlue;
        int sepiaRed   = round(.393*red + .769*green + .189*blue);
int sepiaGreen = round(.349*red + .686*green + .168*blue);
int sepiaBlue  = round(.272*red + .534*green + .131*blue);
if (sepiaRed > 255) sepiaRed = 255;
if (sepiaGreen > 255) sepiaGreen = 255;
if (sepiaBlue > 255) sepiaBlue = 255;

        image[i][j].rgbtRed=sepiaRed;
        image[i][j].rgbtGreen=sepiaGreen;
        image[i][j].rgbtBlue=sepiaBlue;
    }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for(int i=0;i<height;i++){
        for(int j=0;j<width/2;j++){
            RGBTRIPLE tmp=image[i][j];
            image[i][j]=image[i][width-1-j];
            image[i][width-1-j]=tmp;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE clone[height][width];
    for(int i=0;i<height;i++){
        for(int j=0;j<width;j++){
            int tRed=0;
            int tGreen=0;
            int tBlue=0;
            int count=0;
            for(int l=-1;l<=1;l++){
                for(int d=-1;d<=1;d++){
                    int bi=i+l;
                    int bj=j+d;
                    if(bi<0 || bi>=height|| bj<0 || bj>=width){
                        continue;
                    }
                    tRed+=image[bi][bj].rgbtRed;
                    tBlue+=image[bi][bj].rgbtBlue;
                    tGreen+=image[bi][bj].rgbtGreen;
                    count++;
                }
            }
            clone[i][j].rgbtRed=round(tRed   / (float)count);
            clone[i][j].rgbtBlue=round(tBlue   / (float)count);
            clone[i][j].rgbtGreen=round(tGreen   / (float)count);
        }

    }
    for(int i=0;i<height;i++){
        for(int j=0;j<width;j++){
            image[i][j]=clone[i][j];
        }
    }
    return;
}
