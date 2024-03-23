#include <stdio.h>
unsigned char string_in_hex[] = {}; /*0x71, 0x33, 0x4d, 0x65....*/

int main() {
	int len_string = sizeof(string_in_hex);
	unsigned char last = 0;
	int i;

	for(i = 0; i < len_string; i++ ) { /*iterate over a string*/

		unsigned char temp, j;

		for (j = 0x20; j < 128; j++) {	/*iterate over a string using ASCII*/
			temp = j;
			
           /* Encryption algorithm */
           /*Example: temp ^= 0x41;*/
                    /*temp += 0x31;*/
                    /*temp -= last;*/

			if (temp == string_in_hex[i]) {
				/*last = temp;*/ /*Optional*/
				printf("%c", j);
				break;
			}
		}
	}
	printf("\n");
	return 0;
	
}
