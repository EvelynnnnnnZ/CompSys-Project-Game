#include "hash.h"

#include <stdbool.h>
#include <assert.h>

/**
 * This file is to check list.h and list.c for part I of the assignment only
 *
 * Do not include it in the submission of part II
 *
 * You are expected to add additional test cases to this file
 * and to run valgrind on the program once you have it working
 */

//Tests that the hashcode function works
bool basicHashcode(hash_struct* table){


    if (hashcode(table, 7) == 7 && hashcode(table, 107) == 7){
        return true;
    } else {
        return false;
    }

}


//tests that an empty list has size == 0
bool testBasicEmpty(hash_struct* table){

    clear(table);

    if (isEmpty(table) == true){
        return true;
    } return false;

}





int main()
{
    printf ("Creating table\n") ;

        hash_struct* my_table = initTable(100) ;


        if (basicHashcode(my_table) == true){
         printf("%s\n", "Passed Test 1 : basicHashcode()");
    } else {
        printf("%s\n", "Failed Test 1 : basicHashcode()");
    }

    if (testBasicEmpty(my_table) == true){
        printf("%s\n", "Passed Test 2 : testBasicEmpty()");
    } else {
        printf("%s\n", "Failed Test 2 : testBasicEmpty()");
    }

    //-------------------YOU CAN ADD YOUR OWN TESTS HERE---------




    //-------------------------------------------------


    printf ("freeing table\n") ;
    done(my_table) ;



    return 0;

}
