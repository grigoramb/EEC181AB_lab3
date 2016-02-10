#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

static inline unsigned int getCycles ()
{
 unsigned int cycleCount;
 // Read CCNT register
 asm volatile ("MRC p15, 0, %0, c9, c13, 0\t\n": "=r"(cycleCount));
 return cycleCount;
}
static inline void initCounters ()
{
 // Enable user access to performance counter
 asm volatile ("MCR p15, 0, %0, C9, C14, 0\t\n" :: "r"(1));
 // Reset all counters to zero
 int MCRP15ResetAll = 23;
 asm volatile ("MCR p15, 0, %0, c9, c12, 0\t\n" :: "r"(MCRP15ResetAll));
 // Enable all counters:
 asm volatile ("MCR p15, 0, %0, c9, c12, 1\t\n" :: "r"(0x8000000f));
 // Disable counter interrupts
 asm volatile ("MCR p15, 0, %0, C9, C14, 2\t\n" :: "r"(0x8000000f));
 // Clear overflows:
 asm volatile ("MCR p15, 0, %0, c9, c12, 3\t\n" :: "r"(0x8000000f));
}


int main(void)
{
  volatile uint32_t * FPGA_SDRAM = (uint32_t *) 0xC0000000;
  
  volatile uint32_t * ready_BUTTON = (uint32_t *) 0xFF200010;
  volatile uint32_t * done_LIGHT = (uint32_t *) 0xFF200000;
    


  volatile short * RDYBIT = (short *) 0xC4000028;
  printf("Greetings and salutations\n");


  int i = 0;

  int *ptr = FPGA_SDRAM;

  int count = 10;
  *ready_BUTTON = 0;
  while(1){
    ptr = FPGA_SDRAM;
    printf("Please enter 10 numbers (<16bits):\n");
    count = 10;
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
    *ready_BUTTON = 0;
    printf("Min and max should be there!\n"); 
    printf("Min: %d\n", (*ptr++)>>16);
    printf("Max: %d\n", (*ptr) & 0xFFFF);
    printf("Please press the any key to continue\n");
    scanf("%d", &i);
    fflush(stdin);
   // *RDYBIT = 1; // ready bit
   // for(count = 1; count <64000; count++);
    //*RDYBIT = 0; 
    //for(ptr = FPGA_SDRAM; ptr < FPGA_SDRAM + 10; ptr++)
     // printf("Number: %d\n", *ptr); 
  }
/*	int location;
	int i = 0;
	int value;
	int number = 0x0;
	int fakeCounter = 0;
	unsigned int time;

	int startval = 0x0;
	int val;
	int j;
	volatile uint32_t * addresses[4] = {FPGA_onchip, FPGA_SDRAM, HPS_onchip, HPS_SDRAM};
	volatile uint32_t * adr;

	char locations[4][20] = {"FPGA Onchip","FPGA SDRAM","HPS Onchip","HPS SDRAM"};

	int num_invalid;

	int avail_mem;
		

	while(1){

		initCounters ();
		location = 5; 
		num_invalid = 0;
		while(location < 0 || location > 3){
			printf("Choose memory block to write to:\n");
			for(i = 0; i < 4; i++)
				printf("  %d: %s\n",i,locations[i]); // (0=FPGA Onchip, 1=FPGA SDRAM, 2=HPS Onchip, 3=HPS SDRAM):");
			scanf("%d", &location);
			fflush(stdin);
		}
		avail_mem = location ? 32 : 16; // 16kb for location 0, 32kb for the rest

		printf("\nWriting %dKB to %s.\n", avail_mem, locations[location]);

		 avail_mem*=256; // set to num blocks


		time = getCycles();

		for(adr = addresses[location], val = startval, i = 0;
			(i < avail_mem); i++){
				*(adr++) = val++;
		}

		time = getCycles() - time;
		printf ("Elapsed Time: %d cycles\n", time);


		printf("\nReading %dKB from %s.\n", avail_mem/256, locations[location]);
		int j;
		time = getCycles();

		for(adr = addresses[location], val = startval, i = 0;
			i < avail_mem; i++)
				if(*(adr++) != val++)
					num_invalid++;

		time = getCycles() - time;
		printf ("Elapsed Time: %d cycles\n", time);

		printf("Number of invalid blocks: %d\n\n\n", num_invalid);

	

} //while
*/
 }//main
