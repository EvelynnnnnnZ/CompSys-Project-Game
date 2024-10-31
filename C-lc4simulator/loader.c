/*
 * loader.c : Defines loader functions for opening and loading object files
 */

#include "loader.h"

// memory array location
unsigned short memoryAddress;

void swapEndianness(unsigned short int *read_num){
  unsigned short int upper8;
  unsigned short int lower8;
  unsigned short int swap_it;

  lower8 = (*read_num & 0x00FF) << 8;
  upper8 = (*read_num & 0xFF00) >> 8; 
  swap_it = lower8 | upper8;
  *read_num = swap_it;
}
/*
 * Read an object file and modify the machine state as described in the writeup
 */
int ReadObjectFile(char* filename, MachineState* CPU)
{
  FILE *read_file;
  int i = 0;
  int read_num = 0;
  unsigned short int header_helper = 0;
  unsigned short int address = 0;
  unsigned short int n = 0;
  int file_length = 0;


  read_file = fopen(filename, "rb"); //open binary file for reading
  file_length = strlen(filename);
  if (read_file == NULL){ 
      printf("Error1: error with ReadObjectFile nameNULL");
      return 1; 
  }
  if (filename[file_length-3]!='o' || filename[file_length-2]!='b' || filename[file_length-1]!='j'){ //check obj*********|| filename[file_length-3]!='o'
      printf("Error1: error with ReadObjectFile obj");
      return 1; 
  }

   if (CPU == NULL){
       printf("CPU is NULL");
   }

  while(1) {

    if (feof(read_file)) {
      break;
    }

    read_num = fread(&header_helper, sizeof(header_helper), 1, read_file); //initiate read_num
    swapEndianness(&header_helper);
    if (read_num<0){ 
      printf("Error2: error with ReadObjectFile read_num NULL");
      return 1;
  }


    else {
      if (header_helper == 0xCADE || header_helper == 0xDADA){           // if it's code

        fread (&address, sizeof(address), 1, read_file);
        swapEndianness(&address);
        fread(&n, sizeof(n), 1, read_file); 
        swapEndianness(&n); 

        // fread(&header_helper, sizeof(header_helper), 1, read_file); //initiate read_num
        // swapEndianness(&header_helper);
        // address = header_helper;
        // fread(&header_helper, sizeof(header_helper), 1, read_file); //initiate read_num
        // swapEndianness(&header_helper); 
        // n = header_helper;

        //printf("number = %d\n", n);

        for (i = 0; i < n; i++){
          //  if (address == 0x8200) {
          //    printf("\n\naddress\n\n");
          //  }
            fread (&(CPU->memory[address+i]), sizeof(unsigned short int), 1, read_file);
            swapEndianness(&(CPU->memory[address+i]));

        }


    }

  }
  }

  fclose(read_file);

  return 0;
}

