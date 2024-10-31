/***************************************************************************
 * file name   : assembler.c                                               *
 * author      : tjf & you                                                 *
 * description : This program will assemble a .ASM file into a .OBJ file   *
 *               This program will use the "asm_parser" library to achieve *
 *			     its functionality.										   * 
 *                                                                         *
 ***************************************************************************
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "asm_parser.h"

int main(int argc, char** argv) {
	int x;
	int i;
	int j;
	int p;
	int ob;
	
	char* filename = NULL ;					// name of ASM file
	char  program [ROWS][COLS] ; 			// ASM file line-by-line
	char  program_bin_str [ROWS][17] ; 		// instructions converted to a binary string
	unsigned short int program_bin [ROWS] ; // instructions in binary (HEX)
	
	// //start of question 1
	for (i=0; i<ROWS; i++)
	{
		for (j=0; j<COLS; j++){
			program[i][j]='\0';
		}
	}

	if (argc==1){
		printf("error1: usage: ./assembler <assembly_file.asm>");		//error message 1
		return 1;
	}
	filename = argv[1];
	x = read_asm_file (filename, program); 			//call read_asm_file
	for (i=0; i<ROWS; i++){
		printf("%s\n",program[i]);					//print out the program
	}
	// //end for question 1

	//start of question 2, 3
	for (i=0; i<ROWS; i++)
	{
		for (j=0; j<17; j++){
			program_bin_str[i][j]='\0';
		}
	}

	for (i=0; i<7; i++){					//call parse_instruction
		if (program[i]==NULL){				// break if NULL
			break;
		}

		p = parse_instruction(program[i], program_bin_str[i]);	
		printf("%s\n",program_bin_str[i]);			//print out the result


	}
	//end of question 2, 3


	//start of question 4

	for (i=0; i<ROWS; i++){		
		if (program[i][0]=='\0'){		//break if has '\0' at the beginning
			break;
		}

		program_bin[i] = str_to_bin(program_bin_str[i]);		//call str_to_bin
		printf("%X\n",program_bin[i]);				//print out the result


	}

	//end of question 4


	//start of question 5
	ob = write_obj_file (filename, program_bin) ;		//call write_obj_file
	printf("%d\n",ob);									//print out 0 showing no error
	//end of question 5

	return 0;							//if no error, return 0
}
