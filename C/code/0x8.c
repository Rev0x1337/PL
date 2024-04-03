#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void encryptFile(FILE* inputFile, FILE* outputFile, int key) {
    char ch;
    while ((ch = fgetc(inputFile)) != EOF) {
        ch = ch ^ key; 
        fputc(ch, outputFile);
    }
}

int main() {
    FILE *inputFile, *outputFile;
    char inputFileName[100], outputFileName[100];
    int key;

    
    srand(time(NULL));
    key = rand() % 256; 

    printf("Key: %d\n", key);

    printf("Enter name file for encoding: ");
    scanf("%s", inputFileName);

    printf("Enter name encoding file: ");
    scanf("%s", outputFileName);

    inputFile = fopen(inputFileName, "rb");
    if (inputFile == NULL) {
        printf("Error open file for reading.\n");
        return 1;
    }

    outputFile = fopen(outputFileName, "wb");
    if (outputFile == NULL) {
        printf("Error open file for writing.\n");
        return 1;
    }

    encryptFile(inputFile, outputFile, key);

    printf("File encoding.\n");

    fclose(inputFile);
    fclose(outputFile);

    return 0;
}
