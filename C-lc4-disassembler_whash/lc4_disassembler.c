/************************************************************************/
/* File Name : lc4_disassembler.c 										*/
/* Purpose   : This file implements the reverse assembler 				*/
/*             for LC4 assembly.  It will be called by main()			*/
/*             															*/
/* Author(s) : tjf and you												*/
/************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "lc4_hash.h"

int reverse_assemble (lc4_memory_segmented* memory) 
{
    unsigned short int full_instruction = 0;
	unsigned short int sub_opcode_one = 0;
	unsigned short int sub_opcode_two = 0;
	row_of_memory* row_now = NULL;
	row_of_memory* row_want = NULL;
    char for_assembly[15] = "";
    int how_long_assembly = 0;
    unsigned short int rs = 0;
    unsigned short int rt = 0;
    unsigned short int rd = 0;
    unsigned short int iMM = 0;
    signed short int SiMM = 0;
    int i = 0;

    if (memory == NULL){                //check if null
        return 1;
    }
    
    for (i = 0; i < memory->num_of_buckets; i++){
        row_now = memory->buckets[i];                   //helper to loop through
        while(row_now != NULL){
            row_want = search_opcode(row_now, 0x0001);      //search for: OPCODE=0001 && NULL assembly
            if (row_want == NULL){
                break;
            }
            full_instruction = row_want->contents;
            rd = (full_instruction>>9) & 0x7;                   //get rd, rs, rt, and sub_opcodes
            rs = (full_instruction>>6) & 0x7;
            rt = full_instruction & 0x7;
	        sub_opcode_one = (full_instruction >> 5) & 0x0001;
	        sub_opcode_two = (full_instruction >> 3) & 0x0003;
            switch (sub_opcode_one){                            //determine which instruction
                case 0: 
                    switch (sub_opcode_two){
                        case 0: //ADD   
                            sprintf(for_assembly, "ADD R%d R%d R%d", rd, rs, rt);   //get the correct form into for_assembly
                            break;
                        case 1: //MUL
                            sprintf(for_assembly, "MUL R%d R%d R%d", rd, rs, rt);
                            break;
                        case 2: //SUB 
                            sprintf(for_assembly, "SUB R%d R%d R%d", rd, rs, rt);
                            break;
                        case 3: //DIV 
                            sprintf(for_assembly, "DIV R%d R%d R%d", rd, rs, rt);
                            break;
                        default: 
                            return 1;
                        }
                    break;
                case 1: //ADD IMM
                    iMM = full_instruction & 0x1F;
                    SiMM = (signed short int)(iMM <<11)>>11;
                    sprintf(for_assembly, "ADD R%d R%d #%d", rd, rs, SiMM);
                    break;                       
                default: 
                    return 1;
            }
            how_long_assembly = strlen(for_assembly);                
            row_now->assembly = malloc((how_long_assembly+1) * sizeof(char));           //malloc for row_now->assembly
            strcpy(row_now->assembly, for_assembly);
            strcpy(for_assembly, "");
            row_now= row_now->next;
        }
    }

    for (i = 0; i < memory->num_of_buckets; i++){
        row_now = memory->buckets[i];
        while(row_now != NULL){
            row_want = search_opcode(row_now, 0101);            //search for: OPCODE=0101 && NULL assembly
            if (row_want == NULL){
                break;
            }
            full_instruction = row_want->contents;
            rd = (full_instruction>>9) & 0x7;                   //get rd, rs, rt, and sub_opcodes
            rs = (full_instruction>>6) & 0x7;
            rt = full_instruction & 0x7;
	        sub_opcode_one = (full_instruction >> 5) & 0x0001;
	        sub_opcode_two = (full_instruction >> 3) & 0x0003;
            switch (sub_opcode_one){
                case 0: 
                    switch (sub_opcode_two){                    //determine which instruction it is
                        case 0: //AND 
                            sprintf(for_assembly, "AND R%d R%d R%d", rd, rs, rt);       //get the correct form into for_assembly
                            break;
                        case 1: //NOT
                            sprintf(for_assembly, "NOT R%d R%d R%d", rd, rs, rt);
                            break;
                        case 2: //OR 
                            sprintf(for_assembly, "OR R%d R%d R%d", rd, rs, rt);
                            break;
                        case 3: //XOR 
                            sprintf(for_assembly, "XOR R%d R%d R%d", rd, rs, rt);
                            break;
                        default:
                            return 1;
                        }
                    break;
                case 1: //AND IMM
                    iMM = full_instruction & 0x1F;
                    SiMM = (signed short int)(iMM <<11)>>11;                        
                    sprintf(for_assembly, "AND R%d R%d #%d", rd, rs, SiMM);
                    break;
                default: 
                    return 1;
            }
            how_long_assembly = strlen(for_assembly);
            row_now->assembly = malloc((how_long_assembly+1) * sizeof(char));
            strcpy(row_now->assembly, for_assembly);
            strcpy(for_assembly, "");
            row_now= row_now->next;
        }
    } 	
	return 0 ;
}