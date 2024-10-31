#include "hash.h"


/**
* @input - A number of buckets, the size to make the hash table.
* Should assign space for the hash_struct pointer, all buckets, and should
* initialize all entries as KEY = -1, VALUE = -1 to begin.
* 
*/

hash_struct* initTable(int num_of_buckets){


          return NULL;


}


/*
* @input : Some key value.
* @returns : The key value modulated by the size of the hash table.
*/

int hashcode(hash_struct* table, int key){

        return 0;

}

/*
* @input : Some key value, table pointer.
* @returns : The data entry if some matching (key, value) pair exists, otherwise returns NULL.
*/
data_entry* get(hash_struct* table, int key){

        return NULL;


}

/*
* @input : Some key value, table pointer.
* @returns : True only if a valid key exists that maps to this value.
*/
bool contains(hash_struct* table, int key){

    return false;

}

/*
* @input : Some key integer.
* @input : Some value,.
* @returns : void. Places (key, value) pairing into map.
* Replaces value if another pairing with this key already exists.
* Do nothing if the table is full!
*/
void put(hash_struct* table, int key, int value){

       
}

/*
* @returns : The number of valid (key, value) pairings in the table.
*/
int size(hash_struct* table){

        return 0;
}

/*
* Iterates through the table and resets all entries.
*/
void clear(hash_struct* table){

}

/*
* @returns : true, only if the table contains 0 valid (key, value) pairings.
*/
bool isEmpty(hash_struct* table){

     return false;

}


/*
* @returns : true, only when the table is filled entirely with VALID values.
*/
bool isFull(hash_struct* table){

       return false;
}


/*
* @input : Some key value.
* @returns : void. if a pair exists for this key, reinitialize this entry.
*/
void removeEntry(hash_struct* table, int key){


    

}


/*
* Debugging function.
* Iterates through the hashTable and prints all NON-NULL (key, value) pairings.
* Print statement should be of the form "(key1, value1), (key2, value2), ...."
*/
void printEntries(hash_struct* table){

}

/*
* Debugging function.
* Iterates though the hashTable and prints ALL entries in order.
* If a value is not valid, you will print "EMPTY" for the value.
* Entry print Format: "(INDEX: tableIndex, KEY: key, VALUE: value)"
* Example :  "(INDEX: 0, KEY: 0, VALUE: 3), (INDEX: 1, KEY: EMPTY, VALUE: EMPTY), (INDEX: 2, KEY: 2, VALUE: 49), ..."
*/
void printFullTable(hash_struct* table){

      
}


/**
* Should free all space consumed by the hash table.
*/
void done(hash_struct* table){

        

}