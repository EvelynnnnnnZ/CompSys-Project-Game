    /************************************************************************/
/* File Name : lc4_loader.c		 										*/
/* Purpose   : This file implements the loader (ld) from PennSim		*/
/*             It will be called by main()								*/
/*             															*/
/* Author(s) : tjf and you												*/
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "lc4_memory.h"
#include "lc4_hash.h"

void swapEndianness(unsigned short int *read_num){      //what I used to swap Endianness
  unsigned short int upper8;
  unsigned short int lower8;
  unsigned short int swap_it;

  lower8 = (*read_num & 0x00FF) << 8;
  upper8 = (*read_num & 0xFF00) >> 8; 
  swap_it = lower8 | upper8;                          //swap lower 8 and upper 8
  *read_num = swap_it;
}

//If the instruction I'm follwing is clear enough then there might don't have that much comment. 

/* declarations of functions that must defined in lc4_loader.c */
/**
 * opens up name of the file passed in, returns a pointer
 * to the open file
 *
 * returns the FILE pointer upon success, else NULL.
 */
FILE* open_file(char* file_name)
{
	FILE *opened_file;
	opened_file = fopen(file_name, "rb");
	if (opened_file != NULL){
		return opened_file;					//if file exist, return opened file
	}
  printf ("error in open");
	return NULL ;							//otherwise a NULL should be returned
}

/**
 * parses the given input file into hashtable
 *
 * returns 0 upon successs, non-zero if an error occurs.
 */
int parse_file (FILE* my_obj_file, lc4_memory_segmented* memory)	
{
  int i = 0;
  int read_num = 0;
  unsigned short int header_helper = 0;
  unsigned short int address = 0;
  unsigned short int n = 0;
  unsigned short int temp = 0; 
  row_of_memory *for_symbol = NULL;
  char *temp_char = NULL;

  while(1) {

    if (feof(my_obj_file)) {
      break;
    }
    read_num = fread(&header_helper, sizeof(unsigned short int), 1, my_obj_file); //initialize read_num
    swapEndianness(&header_helper);
    if (read_num<0){ 
      printf("Error2: error with ReadObjectFile read_num NULL");
      return 1;
    }
    else {
      if (header_helper == 0xCADE){           // if it's code - getting address and n and then add
        fread (&address, sizeof(address), 1, my_obj_file);
        swapEndianness(&address);
        fread(&n, sizeof(n), 1, my_obj_file); 
        swapEndianness(&n); 
        
        for (i = 0; i < n; i++){
          fread (&temp, sizeof(unsigned short int), 1, my_obj_file);
          swapEndianness(&temp);
          add_entry_to_tbl (memory, address, temp);
          address++;
        }
      }
      else if (header_helper == 0xDADA){           // if it's data - getting address and n and then add
        fread (&address, sizeof(unsigned short int), 1, my_obj_file);
        swapEndianness(&address);
        fread(&n, sizeof(n), 1, my_obj_file); //initiate read_num
        swapEndianness(&n); 

        for (i = 0; i < n; i++){
          fread (&temp, sizeof(unsigned short int), 1, my_obj_file);
          swapEndianness(&temp);
          add_entry_to_tbl (memory, address, temp);
          address++;
        }
      }
      else if (header_helper == 0xC3B7){           // if it's symbol - getting address and n and then add symbol
        fread (&address, sizeof(unsigned short int), 1, my_obj_file);
        swapEndianness(&address);
        fread(&n, sizeof(n), 1, my_obj_file); 
        swapEndianness(&n); 

        for_symbol = search_tbl_by_address(memory, address);    //search, as the insturction said

        for_symbol->label = malloc((n+1)*sizeof(char));         //do the malloc
        if (for_symbol->label == NULL){
          fprintf(stdout, "temp_char malloc fails");          //print error message is malloc fails
          fflush(stdout);
          free(for_symbol->label);
          return 1;
        }

        fread(for_symbol->label, sizeof(char), n, my_obj_file);
        for_symbol->label[n] = '\0';

      }
  }
  }

  fclose(my_obj_file);          //close the file
	return 0 ;
}