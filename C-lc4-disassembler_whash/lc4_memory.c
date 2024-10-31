/************************************************************************/
/* File Name : lc4_memory.c		 										*/
/* Purpose   : This file implements the linked_list helper functions	*/
/* 			   to manage the LC4 memory									*/
/*             															*/
/* Author(s) : tjf and you												*/
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lc4_memory.h"


/*
 * adds a new node to linked list pointed to by head
 */
int add_to_list (row_of_memory** head,
		 		 unsigned short int address,
		 		 unsigned short int contents)
{																//following the instruction given in this function for this function
	row_of_memory* row_before;
	row_of_memory* row_now = NULL;

    if (*head != NULL){											//check if *head if NULL and we shall just add
	    row_now = *head;	
    }		
	row_before = NULL;											//initialize row_before

	while (row_now != NULL && row_now->address != address){	//loop until we find a place that row_now->address > new_row->address
		row_before = row_now;
		row_now = row_now->next;	//move to check the next one
	}

	if (row_now != NULL && row_now->address == address){			// we should add at the last
		row_now->contents = contents;
		return 0;
	}
	else {
		row_now = *head;			
		row_before = NULL;
		row_of_memory* new_row = malloc (sizeof (row_of_memory));	

		if (new_row == NULL){										//return -1 if malloc fails
			return -1;
		}

		new_row->address = address;									//initialize new_row
		new_row->contents = contents;
		new_row->assembly = NULL;
		new_row->label = NULL;
		new_row->next = NULL;

		if (*head == NULL){											//if head==NULL, node created is the new head of the list!
			*head = new_row;
		}
		else {

			while (row_now != NULL && row_now->address < new_row->address){	//loop until we find a place that row_now->address > new_row->address
				row_before = row_now;
				row_now = row_now->next;	//move to check the next one
			}
			if (row_before == NULL){		//if we should put the new node at first	
				new_row->next = *head;		//then new_row is before head
				*head = new_row;			//then the head is new_row
			}
			else {
				row_before->next = new_row;	//insert the node between the two
				new_row->next = row_now;
			}
		}



	/* allocate memory for a single node */

	/* populate fields in newly allocated node with arguments: address/contents */

    /* make certain to set other fields in structure to NULL */

	/* if head==NULL, node created is the new head of the list! */

	/* otherwise, insert the node into the linked list keeping it in order of ascending addresses */

	/* return 0 for success, -1 if malloc fails */

		return 0 ;
			
	}


}

//If the instruction I'm follwing is clear enough then there might don't have that much comment. 

/*
 * search linked list by address field, returns node if found
 */
row_of_memory* search_address (row_of_memory* head,
			        		   unsigned short int address )
{
	row_of_memory* row_now;
	row_now = head;
	while (row_now != NULL){
		if (row_now->address == address){				//search for "address"
			return row_now;								//return pointer to node in the list if item is found
		}
		row_now = row_now->next;						//otherwise keep searching
	}
	/* traverse linked list, searching each node for "address"  */

	/* return pointer to node in the list if item is found */

	/* return NULL if list is empty or if "address" isn't found */

	return NULL ;
}

/*
 * search linked list by opcode field, returns node if found
 */
row_of_memory* search_opcode (row_of_memory* head,
				      		  unsigned short int opcode  )
{
    unsigned short int full_instruction = 0;
    unsigned short int opcode_two = 0;
	row_of_memory* row_now;

	row_now = head;
	while (row_now != NULL){
		full_instruction = row_now->contents;
		opcode_two = full_instruction>>12;
		if (opcode_two == opcode){
			if (row_now->assembly == NULL){					//return the node with the opcode we want and with assembly being NULL
				return row_now;
			}
		}
		row_now = row_now->next;
	}
	/* traverse linked list until node is found with matching opcode
	   AND "assembly" field of node is empty */

	/* return pointer to node in the list if item is found */

	/* return NULL if list is empty or if no matching nodes */
	return NULL ;
}

/*
 * delete the node from the linked list with matching address
 */
int delete_from_list (row_of_memory** head,
			          unsigned short int address ) 
{															//following the instruction given in this function for this function
	row_of_memory* row_before;
	row_of_memory* row_now;
	row_now = *head;
	row_before = NULL;
	while (row_now != NULL){								//keep checking through
		if (row_now->address != address){
			row_before = row_now;
			row_now = row_now->next;
		}
		else if (row_now->address == address){				//if we find the right place to delete
			if (row_before == NULL){						//update head if needed
				*head = row_now->next;
			}
			else {
				row_before->next = row_now->next;			//delete
			}
			free(row_now);
			row_now = NULL;
			return 0;										//return 0 if successfully deleted the node from list
		}
	}

	/* if head isn't NULL, traverse linked list until node is found with matching address */

	/* delete the matching node, re-link the list */

	/* make certain to update the head pointer - if original was deleted */

	/* return 0 if successfully deleted the node from list, -1 if node wasn't found */

	return -1 ;

}

void print_list (row_of_memory* head, 
				 FILE* output_file )
{
	int count = 0;												//simply counting for numbers of codes, not required by part2
	if (head == NULL){											//check if NULL
		fprintf(output_file, "The head is NULL.");
		return;
	}

	while (head != NULL){										//printing things based on the given form
		if (head->label != NULL){
			fprintf(output_file, "%s", head->label);
			if (strcmp(head->label, "END")==0){
				fprintf(output_file, "        ");
			}
		}
		else {
			fprintf(output_file, "           ");	
		}
		fprintf(output_file, "%04X        ", head->address);
		fprintf(output_file, "%04X         ", head->contents);
		if (head->assembly != NULL){
			fprintf(output_file, "%s\n", head->assembly);
		}
		else {
			if (strcmp(head->label, "END")==0){
				fprintf(output_file, "");
			}
			else {
				fprintf(output_file, "\n");	
			}
		}
		head = head->next;
		count++;
	}
	/* make sure head isn't NULL */

	/* print out a header to output_file */

	/* traverse linked list, print contents of each node to output_file */


	return ;
}

/*
 * delete entire linked list
 */
void delete_list (row_of_memory** head )
{
	row_of_memory* row_past_now;
	row_of_memory* row_now;
	row_now = *head;
	row_past_now = NULL;

	while (row_now != NULL){
		row_past_now = row_now->next;		//delete it
		free(row_now->label);				//free them
		free(row_now->assembly);
		free(row_now);
		row_now = row_past_now;
	}
	*head = NULL;

	/* delete entire list node by node */
	/* set head = NULL upon deletion */

	return ;
}