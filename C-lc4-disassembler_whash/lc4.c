/************************************************************************/
/* File Name : lc4.c 													*/
/* Purpose   : This file contains the main() for this project			*/
/*             main() will call the loader and disassembler functions	*/
/*             															*/
/* Author(s) : tjf and you												*/
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lc4_memory.h"
#include "lc4_hash.h"
#include "lc4_loader.h"
#include "lc4_disassembler.h"

int hash_function_helper(void* table, void *key){				//hash function
	int* my_key = key;
	if ( 0x0000 < *my_key && *my_key < 0x1FFF){
		return 0;
	}
	else if ( 0x2000 < *my_key && *my_key < 0x7FFF){
		return 1;
	}
	else if ( 0x8000 < *my_key && *my_key < 0x9FFF){
		return 2;
	}
	else {
		return 3;
	}

}


/* program to mimic pennsim loader and disassemble object files */

int main (int argc, char** argv) {
	FILE* filename = NULL ;
    FILE* txt_file = NULL;					// name of file
    int i = 0;
	int check_parse = 0;
	int error_check_reverse = 0;
	int text_file_length = 0;

    text_file_length = strlen(argv[1]);             //check if it's a text file
    if (argv[1][text_file_length-3]!='t' || argv[1][text_file_length-2]!='x' || argv[1][text_file_length-1]!='t'){
        printf("Error 1: not a text file\n");
        return 1;
    }

    txt_file = fopen(argv[1], "w");				//open file for write
    if (txt_file == NULL){
        printf("Error 1: text file is NULL\n");
        return 1;
    }

    //just following the steps below
	/**
	 * main() holds the hashtable &
	 * only calls functions in other files
	 */

	/* step 1: create a pointer to the hashtable: memory 	*/
	lc4_memory_segmented* memory = NULL ;

	/* step 2: call create_hash_table() and create 4 buckets 	*/
	memory = create_hash_table(4, hash_function_helper);

	/* step 3: determine filename, then open it		*/
	/*   TODO: extract filename from argv, pass it to open_file() */

	if (argc==1){
		printf("error with argc\n");		//error message 1
		return 1;
	}

	if (argc<3){
		printf("error1: usage: ./lc4 <object_file.obj>\n");
		return 1;
	}

   for (i=2; i<argc; i++){
	   filename = open_file(argv[i]);

		check_parse = parse_file(filename, memory);
		if (check_parse != 0){
			printf("error with parse_file\n");
		}
    }


	/* step 4: call function: parse_file() in lc4_loader.c 	*/
	/*   TODO: call function & check for errors		*/

	/* step 5: repeat steps 3 and 4 for each .OBJ file in argv[] 	*/


	/* step 6: call function: reverse_assemble() in lc4_disassembler.c */
	/*   TODO: call function & check for errors		*/
	error_check_reverse = reverse_assemble(memory);

	/* step 7: call function: print out the hashtable to output file */
	/*   TODO: call function 				*/
	fprintf(stdout, "printing in main before delete\n");

	print_table(memory, stdout);
	print_table(memory, txt_file);

	/* step 8: call function: delete_table() in lc4_hash.c */
	/*   TODO: call function & check for errors		*/
	delete_table(memory);

	fclose(txt_file);
	/* only return 0 if everything works properly */
	
	return 0 ;
}

