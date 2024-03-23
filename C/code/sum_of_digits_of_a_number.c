#include <stdio.h>

/*The input of the program is a natural three-digit number. The program displays the sum of the digits of this number.*/

int main() {
  int num, digit, res = 0;

  scanf ("%d", &num);
  digit = num % 10;
  res += digit;
  
  num /= 10;
  digit = num % 10;
  res += digit;
  
  num /= 10;
  digit = num % 10;
  res += digit;
  
  printf("%d", res);
  
  return 0;
}
