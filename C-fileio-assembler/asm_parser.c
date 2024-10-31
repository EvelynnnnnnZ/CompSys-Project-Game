/***************************************************************************
 * file name   : asm_parser.c                                              *
 * author      : tjf & you                                                 *
 * description : the functions are declared in asm_parser.h                *
 *               The intention of this library is to parse a .ASM file     *
 *			        										               * 
 *                                                                         *
 ***************************************************************************
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "asm_parser.h"

/* to do - implement all the functions in asm_parser.h */
int read_asm_file (char* filename, char program [ROWS][COLS] ){
    FILE *this_file;
    char one_row[COLS];  
    int i;
    int j;
    int comment_helper_num;
    int loop_helper;

    this_file = fopen(filename, "r");          //open the file

    if (this_file==NULL){                       //print error message
        printf("error2: read_asm_file() failed");
        return 2;
    }
    for (i=0; i<ROWS; i++){
        
        if (fgets(one_row, COLS, this_file)==NULL){         //break if NULL
            break;
        }

        if (one_row[0]=='\0'){                      //break if empty
            break;
        }
        if (one_row[0]==';'){       //ignore if the row start with a ";", meaning the row is comment. 
            continue;
        }

        j=strlen(one_row);

        for (comment_helper_num = 0; comment_helper_num < strlen(one_row); comment_helper_num++){   // ignore the part after ";" since it is comment.
            if (one_row[comment_helper_num]==';'){
                j = comment_helper_num;
            }
        }

        one_row[j-1]='\0';          //set the end as '\0'

        strcpy(program[i], one_row);            //copy one_row into program
        
    }
    fclose(this_file);          //close the file
    return 0;
}


int parse_instruction (char* instr, char* instr_bin_str) {
    const char s[3]=", ";
    const char space[2]=" ";
    char *token;
    int instr_bin;

    if (instr == NULL || instr_bin_str == NULL){
        printf("error3: rparse_instruction() failed");  //print out error message if there's NULL
        return 3;
    }

    token = strtok(instr, space);          //first deal with the opcode
    if (token == NULL){
        printf("error3: rparse_instruction() failed");
        return 3;
    }

    if (strcmp(token, "ADD")==0){           //all instrutions needed for this homework
        parse_add(token, instr_bin_str);
    }
    else if (strcmp(token, "SUB")==0){
        parse_sub(token, instr_bin_str);
    }
    else if (strcmp(token, "MUL")==0){
        parse_mul(token, instr_bin_str);
    }
    else if (strcmp(token, "DIV")==0){
        parse_div(token, instr_bin_str);
    }
    else if (strcmp(token, "XOR")==0){
        parse_xor(token, instr_bin_str);
    }
    else if (strcmp(token, "AND")==0){
        parse_and(token, instr_bin_str);
    }
    else if (strcmp(token, "OR")==0){
        parse_or(token, instr_bin_str);
    }

    //then we will deal with DR, SR1, SR2 in each instrument

    return 0;           //return 0 if no error
}


int parse_add (char* instr, char* instr_bin_str ) {   
    char* ptr;
    const char s[3]=", ";       //what we use to get the registers

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "ADD") != 0){
        printf("error4: parse_add() failed");           // print out error message if there's NULL
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '0'; 
    instr_bin_str[12] = '0'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '0'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4;                  // use pointer to show positions of each register
    instr = strtok(NULL, s);                // checked with TA that we don't need to consider if register greater than 7
    parse_reg(instr[1], ptr);               //call parse_reg 

    ptr = instr_bin_str+7;                  //similar as above
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    return 0;
}

int parse_reg (char reg_num, char* instr_bin_str){
    if (reg_num==0 || instr_bin_str == NULL){
        printf("error5: parse_reg() failed");             // print error message if error occur
        return 5;
    }

    switch (reg_num){
        case '0':
            instr_bin_str[0] = '0';             //if we have R0, we should then have 000
            instr_bin_str[1] = '0';
            instr_bin_str[2] = '0';
            break;
        case '1':
            instr_bin_str[0] = '0';             // for R1
            instr_bin_str[1] = '0';
            instr_bin_str[2] = '1';
            break;
        case '2':
            instr_bin_str[0] = '0';             // for R2, below are for R3 to R7
            instr_bin_str[1] = '1';
            instr_bin_str[2] = '0';
            break;
        case '3':
            instr_bin_str[0] = '0';
            instr_bin_str[1] = '1';
            instr_bin_str[2] = '1';
            break;
        case '4':
            instr_bin_str[0] = '1';
            instr_bin_str[1] = '0';
            instr_bin_str[2] = '0';
            break;
        case '5':
            instr_bin_str[0] = '1';
            instr_bin_str[1] = '0';
            instr_bin_str[2] = '1';
            break;
        case '6':
            instr_bin_str[0] = '1';
            instr_bin_str[1] = '1';
            instr_bin_str[2] = '0';
            break;
        case '7':
            instr_bin_str[0] = '1';
            instr_bin_str[1] = '1';
            instr_bin_str[2] = '1';
            break;
    }
    return 0;
}

int parse_mul (char* instr, char* instr_bin_str ) {         //similar methods for instruction have similar structure for parse_add and thus similar comment
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "MUL") != 0){
        printf("error4: parse_mul() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '0'; 
    instr_bin_str[12] = '1'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '0'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4;      
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}

int parse_sub (char* instr, char* instr_bin_str ) {
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "SUB") != 0){
        printf("error4: parse_sub() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '1'; 
    instr_bin_str[12] = '0'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '0'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4; 
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}

int parse_div (char* instr, char* instr_bin_str ) {
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "DIV") != 0){
        printf("error4: parse_div() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '1'; 
    instr_bin_str[12] = '1'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '0'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4; 
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}

int parse_and (char* instr, char* instr_bin_str ) {
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "AND") != 0){
        printf("error4: parse_and() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '0'; 
    instr_bin_str[12] = '0'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '1'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4; 
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}

int parse_or (char* instr, char* instr_bin_str ) {
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "OR") != 0){
        printf("error4: parse_mul() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '1'; 
    instr_bin_str[12] = '0'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '1'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4; 
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}

int parse_xor (char* instr, char* instr_bin_str ) {
    char* ptr;
    const char s[3]=", ";

    if (instr == NULL || instr_bin_str == NULL || strcmp(instr, "XOR") != 0){
        printf("error4: parse_mul() failed");
        return 4;
    }

    instr_bin_str[10] = '0'; 
    instr_bin_str[11] = '1'; 
    instr_bin_str[12] = '1'; 
    instr_bin_str[0] = '0'; 
    instr_bin_str[1] = '1'; 
    instr_bin_str[2] = '0';
    instr_bin_str[3] = '1'; 

    ptr = instr_bin_str+4; 
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+7;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);

    ptr = instr_bin_str+13;
    instr = strtok(NULL, s);
    parse_reg(instr[1], ptr);
    return 0;
}


//question 4 below

unsigned short int str_to_bin (char* instr_bin_str) {

    char *ptr;

    int long_form;
    unsigned short int short_form;

    long_form = strtol (instr_bin_str, &ptr, 2);    //converting string to binary
    short_form = (unsigned short int) long_form;

    return short_form;
}

//question 5 below
int write_obj_file (char* filename, unsigned short int program_bin[ROWS] ){
    FILE *this_objfile;
    int a;
    int b;
    int filesize;          
    int row_here;
    int num_rows;
    unsigned short int upper8;
    unsigned short int lower8;
    unsigned short int swap_it;

    while (filename[filesize]!= '\0'){
        filesize++;
    }
    filename[filesize-3] = 'o';
    filename[filesize-2] = 'b';             //change last 3 letters to "obj"
    filename[filesize-1] = 'j';

    this_objfile = fopen(filename, "w");        //open the file for write
    if (this_objfile==NULL){
        printf("error7: write_obj_file() failed");      //print error message if error occurs
        return 7;
    }

    unsigned short int address_here = 0x0000;
    unsigned short int header_here[2] = {0xCADE, address_here};       //get header and address
    for (a=0; a<2; a++){
        lower8 = (header_here[a] & 0x00FF) << 8;            //swap for PennSim, similar for all swaps I have later
        upper8 = (header_here[a] & 0xFF00) >> 8; 
        swap_it = lower8 | upper8;
        header_here[a] = swap_it;
    }
    fwrite (header_here, sizeof(header_here), 1, this_objfile); 

    row_here = 0;
    while (row_here < ROWS && program_bin[row_here] != 0){  //count number of rows
        row_here++;
    }
    num_rows = row_here;
    lower8 = (row_here & 0x00FF) << 8;
    upper8 = (row_here & 0xFF00) >> 8; 
    swap_it = lower8 | upper8;
    row_here = swap_it;

    fwrite (&row_here, 2, 1, this_objfile);         //write out rows

    for (b = 0; b<num_rows; b++){
        upper8 = (program_bin[b] & 0x00FF) << 8;
        lower8 = (program_bin[b] & 0xFF00) >> 8; 
        swap_it = lower8 | upper8;
        program_bin[b] = swap_it;
        fwrite(&program_bin[b], 2, 1, this_objfile);
    }

    fclose(this_objfile);           //close the file

    return 0;

}