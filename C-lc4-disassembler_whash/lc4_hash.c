/************************************************************************/
/* File Name : lc4_hash.c		 										*/
/* Purpose   : This file contains the definitions for the hash table  	*/
/*																		*/
/* Author(s) : tjf 														*/
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "lc4_hash.h"



/*
 * creates a new hash table with num_of_buckets requested
 */
lc4_memory_segmented* create_hash_table (int num_of_buckets, 
             					         int (*hash_function)(void* table, void *key) ) 
{
	int i = 0;
	lc4_memory_segmented* my_table = malloc (sizeof(lc4_memory_segmented));			//do malloc
	my_table->hash_function = hash_function;

	if (my_table == NULL){
		printf("malloc fials for my_table");
		return NULL;				//malloc fails
	}

	my_table->buckets = malloc(sizeof(row_of_memory*)*num_of_buckets);				//do malloc

	if (my_table->buckets == NULL){
		printf("malloc fials for buckets");
		return NULL;				//malloc fails
	}

	for (i = 0; i<4; i++){
		my_table->buckets[i] = NULL;
	}

	my_table->num_of_buckets = num_of_buckets;

	return (my_table);
	// allocate a single hash table struct

	// allocate memory for the buckets (head pointers)

	// assign function pointer to call back hashing function

	// // return 0 for success, -1 for failure
}

//If the instruction I'm follwing is clear enough then there might don't have that much comment. 


/*
 * adds a new entry to the table
 */
int add_entry_to_tbl (lc4_memory_segmented* table, 
					  unsigned short int address,
			    	  unsigned short int contents) 
{
	int bucket_num = 0;

	bucket_num = table->hash_function(table, &address);
	if (table->buckets[bucket_num] != NULL){							//check if we can just call add_to_list
		add_to_list(&table->buckets[bucket_num], address, contents);
	}
	else {
		row_of_memory* new_row = malloc (sizeof (row_of_memory));		//if table->buckets[bucket_num] == NULL so that we should create it and add
		new_row->address = address;
		new_row->contents = contents;
		new_row->assembly = NULL;
		new_row->label = NULL;
		new_row->next = NULL;
		table->buckets[bucket_num] = new_row;
	}
	// apply hashing function to determine proper bucket #
	// add to bucket's linked list using linked list add_to_list() helper function
	return 0 ;
}

/*
 * search for an address in the hash table
 */
row_of_memory* search_tbl_by_address 	(lc4_memory_segmented* table,
			                   			 unsigned short int address ) 
{									//just following instruction
	int bucket_num = 0;
	row_of_memory* search_result;
	bucket_num = table->hash_function(table, &address);
	search_result = search_address(table->buckets[bucket_num], address);
	if (search_result != NULL){
		return search_result;
	}
	// apply hashing function to determine bucket # item must be located in			
	// invoked linked_lists helper function, search_by_address() to return return proper node
	return NULL;
}

/*
 * prints the linked list in a particular bucket
 */

void print_bucket (lc4_memory_segmented* table, 
				   int bucket_number,
				   FILE* output_file ) 
{
	print_list(table->buckets[bucket_number], output_file);
	// call the linked list helper function to print linked list
	return ;
}

/*
 * print the entire table (all buckets)
 */
void print_table (lc4_memory_segmented* table, 
				  FILE* output_file ) 
{
	int i = 0;
    fprintf(output_file, "<label>   <address>   <contents>   <assembly>\n");	//print header

	for (i = 0; i<4; i++){

		if (table->buckets[i]!=NULL){
			print_list(table->buckets[i], output_file);				//if not null, delete
		}
	}
	// call the linked list helper function to print linked list to output file for each bucket

	return ;
}

/*
 * delete the entire table and underlying linked lists
 */

void delete_table (lc4_memory_segmented* table ) 
{
	int i = 0;
	int check = 0;

	for (i = 0; i<4; i++){
		 if (table->buckets[i]!=NULL){			//if not null, delete
			delete_list(&table->buckets[i]);		
		}
	}
	free(table->buckets);				//free them
	free(table);
	table = NULL;
	// call linked list delete_list() on each bucket in hash table
	// then delete the table itself
	return ;
}
