#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>


int main(void)
{
  volatile uint32_t * FPGA_SDRAM = (uint32_t *) 0xC0000000;
  
  volatile uint32_t * ready_BUTTON = (uint32_t *) 0xFF200010;
  volatile uint32_t * done_LIGHT = (uint32_t *) 0xFF200000;
  volatile uint32_t * length = (uint32_t *) 0xFF200020;
  volatile uint32_t * average = (uint32_t *) 0xFF200030;
  volatile uint32_t * readaddress = (uint32_t *) 0xFF200080;
  volatile uint32_t * writeaddress = (uint32_t *) 0xFF200090;

  printf("Greetings and salutations\n");


  int i = 0;
  int *ptr = FPGA_SDRAM;
  int j = 0;
  int count = 10;
  *ready_BUTTON = 0;
  int a = 0, b = 0;
  int array[32];
  int size = 0;

  while(1){
    ptr = FPGA_SDRAM;
    printf("How many numbers do you want to sort power of 2, up to 32\n");
    scanf("%d",&i);
    fflush(stdin);
    *length = i << 1; 
    printf("What address do you want to the FPGA to read from ?\n");
    scanf("%d",&a);
    fflush(stdin);
    readaddress = a;
    printf("What address do you want the FPGA to write to?\n");
    scanf("%d",&b);
    fflush(stdin);
    writeaddress = b;
    printf("Please enter %d numbers (<16bits):\n",i);
    count = i;
    j = i/2;
    while(count--){
      scanf("%d", &i);
      fflush(stdin);
      if(count % 2){
        *ptr = i;
      }
      else{
        *ptr |= i << 16;
        *(ptr++);
      }
    }
    *ready_BUTTON = 1;
    while(!(*done_LIGHT));
    printf("Ready!\n");
    printf("Average: %d\n", *average);
    while(j--){
        printf("%d\n", (*ptr) & 0xFFFF);
        printf("%d\n", (*ptr++) >> 16);
        //printf("%d\n", (*ptr) >> 16);
        //printf("%d\n", (*ptr++) & 0xFFFF);
    }
    *ready_BUTTON = 0;
    printf("Please press the any key to continue\n");
    scanf("%d", &i);
    fflush(stdin);
  }
 //while
}//main
