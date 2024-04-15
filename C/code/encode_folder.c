#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>

void encryptFile(FILE* inputFile, FILE* outputFile, int key) {
    char ch;
    while ((ch = fgetc(inputFile)) != EOF) {
        ch = ch ^ key; 
        fputc(ch, outputFile);
    }
}

void encryptFilesInDirectory(const char* directoryPath, int key) {
    struct dirent *entry;
    DIR *dir = opendir(directoryPath);
    if (dir == NULL) {
        printf("Error open folder.\n");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG) {
            char filePath[256];
            sprintf(filePath, "%s/%s", directoryPath, entry->d_name);

            FILE* inputFile = fopen(filePath, "rb");
            if (inputFile == NULL) {
                printf("Error open file: %s\n", filePath);
                continue;
            }

            char outputFilePath[256];
            sprintf(outputFilePath, "%s/%s_encrypted", directoryPath, entry->d_name);
            FILE* outputFile = fopen(outputFilePath, "wb");
            if (outputFile == NULL) {
                printf("Error create encrypted file: %s\n", outputFilePath);
                fclose(inputFile);
                continue;
            }

            encryptFile(inputFile, outputFile, key);

            printf("File %s encrypted.\n", entry->d_name);

            fclose(inputFile);
            fclose(outputFile);

            remove(filePath); 

            printf("File %s deleted.\n", entry->d_name);
        }
    }
    
    closedir(dir);
}

int main() {
    const char* directoryPath = "testEncode"; 
    int key = 0x41; // 

    encryptFilesInDirectory(directoryPath, key);

    return 0;
}

