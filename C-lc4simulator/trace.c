/*
 * trace.c: location of main() to start the simulator
 */

#include "loader.h"

// Global variable defining the current state of the machine
MachineState* CPU;

int main(int argc, char** argv)
{

    int i;
    int j;
    int text_file_length;
    FILE *txt_file;
    FILE *read_object;
    unsigned short int row_num;
    MachineState CPU_point;
    unsigned short int memory_helper;

    CPU = &CPU_point;

    // printf("Argc%d\n", argc);
    // printf("argv: %s\n", argv[1]);

    ClearSignals(CPU);
    Reset(CPU);


    if (argc <1){
        printf("error with argc, it's not >=1");
        return 1;
    }
        

    for (i=2; i<argc; i++){

        ReadObjectFile(argv[i], CPU); 
        //printf("argv: %hu\n", CPU->PC);


        //****** CPU->PC == 0; didn't read in anything

    }
    //printf("argv: %x\n", CPU->memory[CPU->PC]);

    // for (j=0; j<65536; j++){

    //         if ((CPU->memory[j]) == 0x0000){
    //             //printf("yeah it's null");
    //             continue;
    //         }
            
    //         printf("address: 0x%05x", j);

    //         printf(" content: 0x%04X\n", CPU->memory[j]);
    //         //memory_helper = CPU->memory[j+1];



    //     }



    text_file_length = strlen(argv[1]);
    if (argv[1][text_file_length-3]!='t' || argv[1][text_file_length-2]!='x' || argv[1][text_file_length-1]!='t'){
        printf("Error 1: not a text file");
        return 1;
    } 
    txt_file = fopen(argv[1], "w");
    if (txt_file == NULL){
        printf("Error 1: text file is NULL");
        return 1;
    }
	// j = memory_helper;
    // while ((CPU->memory[j]) != 0x0000){

    //     fprintf(txt_file, "address: %05x", j);

    //     fprintf(txt_file, " contents: 0x%04X\n", CPU->memory[j]);
	//     j++;
    //  }
    
    // for (j=0; j<65536; j++){
    //     if ((CPU->memory[j]) == 0x0000){
    //         continue;
    //     }

    //     fprintf(txt_file, "address: %05d", j);

    //     fprintf(txt_file, " contents: 0x%04X\n", CPU->memory[j]);
    // }
    
    //fclose(txt_file);

//part 1 specific thinsg above command out


    // read_object = fopen(argv[1], "w");
    // if (read_object == NULL){
    //     printf("Error 2: output file is NULL");
    //     return 2;
    // }
    int counter_here = 0;

    while (UpdateMachineState(CPU, txt_file) == 0){ 
        // fprintf (txt_file, "%d: ",counter_here);

        // if (counter_here == 3393){
        //     fclose(txt_file);
        //     return 0;
        // }
        counter_here ++;

    }

    fclose(txt_file);


    return 0;
}
