/* Introduction:
 * In this MP, we inplemented a sparce matrix.
 * A sparce matrix is a large matrix where only a few entries are non-zero entries
 * To make the program more efficient, we only need to save the non-zero entires.
 * We used a linked list to accomplish this.
 */
 
#include "sparsemat.h"
#include <stdio.h>
#include <stdlib.h>

// Helper: Define a function to remove a node from the tuple
void remove_node(sp_tuples_node** head_ptr, int row, int col, double value);

// Helper: Define a funcion to insert a node into the tuple
void insert_node(sp_tuples_node** head_ptr, int row, int col, double value);

// Helper: find the node denoted by row and col
sp_tuples_node* find_node(sp_tuples_node* head, int row, int col);

// Helper: Define a function to remove all the old entries (keep the most up-to-date entries)
void update_tuple(sp_tuples_node** head_ptr);

// Helper: Define a function to remove all 0 entries in the tuple
void remove_0(sp_tuples_node** head_ptr);

// Helper: Define a function to sort the tuple
void sort_tuple(sp_tuples_node** head_ptr);

// Helper: Define a function to split the tuple into two tuples indicated by front ptr and middle ptr
void split_tuple(sp_tuples_node* head, sp_tuples_node** front, sp_tuples_node** middle);

// Helper: Define a function to merge two sorted linked list indicated by pointers
sp_tuples_node* sorted_merge(sp_tuples_node* tuple1, sp_tuples_node* tuple2);


/* Remove the node indicated by the (row, col) = value
 * @input: double pointer: a pointer to the head of the tuple
 *		   the node info: row, col, and value
 * @output: void
 */
void remove_node(sp_tuples_node** head_ptr, int row, int col, double value)
{
	// Previous node
	sp_tuples_node* prev = NULL;
	// Current node
	sp_tuples_node* current = *head_ptr;
	
	// Use a loop to go through the linked list and find the corresponding node
	while (current != NULL)
	{
		// Check if the node is found 
		if (current->row == row && current->col == col && current->value == value)
			break;
		prev = current;				// update prev to the current node
		current = current->next;	// update current node to the next node
	}
	
	// Case that the node is not found
	if (current == NULL)
		return;
		
	// Case that the node found is the first node
	if (current == *head_ptr)
	{
		// Update the head pointer
		*head_ptr = current->next;
	}
	// Case that the node found is the last node
	else if (current->next == NULL)
	{
		// Update prev->next to NULL
		prev->next = NULL;
	}
	// Case that the node found in middle of the linked list
	else
	{
		// Update the link from prev to the next
		prev->next = current->next;
	}
	// Free the location that current pointer points at
	free(current);
	return;
}


/* Insert the node indicated by the (row, col) = value
 * @input: double pointer: a pointer to the head of the tuple
 *		   the node info: row, col, and value
 * @output: void
 */
void insert_node(sp_tuples_node** head_ptr, int row, int col, double value)
{
	sp_tuples_node* prev = *head_ptr;		// previous node
	sp_tuples_node* current = *head_ptr;	// current node
	// Allocate space for the new node
	sp_tuples_node* temp = malloc(sizeof(sp_tuples_node));
	temp->row = row;		// set the row of the new node
	temp->col = col;		// set the col of the new node
	temp->value = value;	// set the value of the new node
	
	if (*head_ptr == NULL)
	{
		*head_ptr = temp;
	}
	
	// Go through the tuple to insert the node at an appropriate place
	while (current != NULL)
	{
		// Find the appropriate place by finding value < current->value (sorted tuple)
		if ((row < current->row) || ((current->row == row) && (col < current->col)))
		{
			// Link temp with current
			temp->next = current;
			// Case that insert at front
			if (current == *head_ptr)
			{
				// Set the head_ptr to temp 
				*head_ptr = temp;
			}
			// Case that inset in the middle
			else
			{
				// Link previous node to the temp node
				prev->next = temp;
			}
			// Exit the function
			return;
		}
		// Case that inserting at back
		if (current->next == NULL)
		{
			// Insert at back
			current->next = temp;
			temp->next = NULL;
		}
		prev = current;				// update the prev node pointer
		current = current->next;	// update the current node pointer
	}
}


/* Find the node given by row & col parameters
 * @input: a pointer the head node
 * 		   row & col parameters
 * @output: a pointer to a sp_tuples_node if node found
 			NULL if node is not found
 */
sp_tuples_node* find_node(sp_tuples_node* head, int row, int col)
{
	// Current node
	sp_tuples_node* current = head;
	
	// Go through the tuple to find the node indicated by row & col
	while (current != NULL)
	{
		// Check the row & col parameters
		if (current->row == row && current->col == col)
		{
			// Return a pointer to the current node
			return current;
		}
		// Increment the current pointer
		current = current->next;
	}
	// Return NULL is no entry is found
	return NULL;
}




/* Update the all the entries to the most up-to-date one
 * @input: double ptr: a ptr to the head of the tuple
 * @output: void
 */
void update_tuple(sp_tuples_node** head_ptr)
{
	// sp_tuples_node* prev = NULL;
	sp_tuples_node* current = *head_ptr;
	
	// Go through each element in the tuple
	while (current != NULL)
	{
		// Set another pointer to go through all nodes after the current node
		sp_tuples_node* loop_current = current->next;
		
		// Go through all nodes after the current node
		while (loop_current != NULL)
		{
			// Check is node info
			if (current->row == loop_current->row && current->col == loop_current->col)
			{
				// Call remove_node function to remove the old entry
				remove_node(head_ptr, current->row, current->col, current->value);
				break;
			}
			// Increment the loop_current ptr
			loop_current = loop_current->next;
		}
		// Increment the current ptr
		current = current->next;
	}	
}


/* Remove all the 0 entires in the tuple
 * @input: double ptr: a pointer to the head of the tuple
 * @output: void
 */
void remove_0(sp_tuples_node** head_ptr)
{
	sp_tuples_node* prev = NULL;			// previous node
	sp_tuples_node* current = *head_ptr;	// current node
	sp_tuples_node* next = NULL;			// next node
	
	while (current != NULL)
	{
		// Case that the first node is 0
		if (current->value == 0 && current == *head_ptr)
		{
			*head_ptr = current->next;		// update head pointer
			free(current);					// free the current pointer
			current = *head_ptr;			// re-assign the current pointer
		}
		else 
		{
			// Case that the other node is 0
			if (current->value == 0) {
				next = current->next;	// store the pointer of the next node
				free(current);			// free the current pointer
				current = prev;			// assign the current pointer to the previous pointer
				current->next = next;	// link current node and the next node
			}
			prev = current;				// update the previous pointer
			current = current->next;	// update the current pointer
		}	
	}
	return;
}


/* Sort the tuple using merge sort method
 * @input: a double ptr: a ptr to the head of the tuple
 * @output: void
 */
void sort_tuple(sp_tuples_node** head_ptr)
{
	sp_tuples_node* head = *head_ptr;			// head of the tuple
	
	// If the tuple is empty or contains only 1 elements, do nothing
	if (head == NULL || head->next == NULL) 
	{
		return;
	}
	
	sp_tuples_node* front = NULL;				// front ptr
	sp_tuples_node* middle = NULL;				// middle ptr
	
	// Call split_tuple function to split the tuple into two tuples indicated by front ptr and middle ptr
	split_tuple(head, &front, &middle);	
	
	sort_tuple(&front);		// Sort the tuple indicated by the front ptr
	sort_tuple(&middle);	// Sort the tuple indicated by the middle ptr
	
	// Call the sorted_merge function to merge sorted tuples indicated by fornt ptr and middle ptr
	*head_ptr = sorted_merge(front, middle);
}


/* Split the tuple into two tuples using fast-slow pointer method
 * @input: a pointer to the tuple
 *		   2 double pointers: front, middle
 * @output: void
 */
void split_tuple(sp_tuples_node* head, sp_tuples_node** front, sp_tuples_node** middle)
{
	sp_tuples_node* fast;			// fast ptr
	sp_tuples_node* slow;			// slow ptr
	
	// Case that the tuple is empty or contians just 1 element
	if (head == NULL || head->next == NULL)
	{
		*front = head;				// set front to head
		*middle = NULL;				// set middle to NULL
	}
	
	// Case that the tuple contains more than 1 element
	slow = head;					// set slow ptr
	fast = head->next;				// set fast ptr
	
	// Go throught he tuple using the faster ptr
	// Increment fast ptr twice while incment slow ptr once
	while (fast != NULL)
	{
		fast = fast->next;			// Increment fast ptr
		// Not the end of the tuple
		if (fast != NULL)
		{
			slow = slow->next;		// Increment slow ptr
			fast = fast->next;		// Increment fast ptr
		}
	}
	
	// Set the front ptr to head
	*front = head;
	// Set the middle ptr to slow->next
	*middle = slow->next;
	// Split the tuple by setting slow-next to NULL
	slow->next = NULL;
}


/* Split the tuple into two tuples using fast-slow pointer method
 * @input: head ptr to tuple1 & head ptr to tuple2
 * @output: a sp_tuples_node ptr
 */
sp_tuples_node* sorted_merge(sp_tuples_node* tuple1, sp_tuples_node* tuple2)
{
	// Set the head ptr to NULL
	sp_tuples_node* head = NULL;
	
	// Base case when tuple1 == NULL, return tuple2
	if (tuple1 == NULL)
	{
		return tuple2;
	}
	// Base case when tuple2 == NULL, return tuple1
	else if (tuple2 == NULL)
	{
		return tuple1;
	}
	// Recursion case
	else 
	{
		// Case tuple1->value <= tuple2->value
		if ((tuple1->row < tuple2->row) || ((tuple1->row == tuple2->row) && (tuple1->col < tuple2->col)))
		{
			// Set head to tuple1 head
			head = tuple1;
			// Set the next node
			head->next = sorted_merge(tuple1->next, tuple2);
		}
		// Case tuple1->value > tuple2->value
		else
		{
			// Set head to tuple2 head
			head = tuple2;
			// Set the next node
			head->next = sorted_merge(tuple1, tuple2->next);
		}
		// Retrun head
		return head;
	}
}


/* Load the tuple from a given file
 * @input: the name of a file that contains the tuple info
 		   @input_file: row col (first row)
 		   				row col value (other rows)
 * @output: a pointer to the tuple
 */
sp_tuples * load_tuples(char* input_file)
{
	// Allocate memory for the sparse tuple
	sp_tuples* tuple = malloc(sizeof(sp_tuples));
	
	FILE* file; // Create file of FILE type
	// Open the input_file to read
	file = fopen(input_file, "r");
	
	// read the number of rows and cols from the file
	// tuple->m: the number of rows
	// tuple->n: the number of cols
	fscanf(file, "%d %d", &tuple->m, &tuple->n);
	
	// Allocate memory for the head pointer of the tuple
	tuple->tuples_head = malloc(sizeof(sp_tuples_node));
	
	// Create a sparse tuple node to store the current node
	sp_tuples_node* current = tuple->tuples_head;
	
	// Use a while loop to put info in the file to the tuple
	while (current != NULL)
	{
		int ret; // retrun value from fscanf
		// Gets row, col and value info from the file
		// Return the number of arguments read successfully
		ret = fscanf(file, "%d %d %lf", &current->row, &current->col, &current->value);
		
		// If info read fails, break the loop
		if (ret != 3)
		{
			// Set current->next to NULL (end of the tuple)
			current->next = NULL;
			break;
		}
		
			// Allocate memory for the next tuple node
			current->next = malloc(sizeof(sp_tuples_node));
			// Set the current node to the next
			current = current->next;
	}
	
	// Update the entry to the newest one and delete the old entries
	update_tuple(&tuple->tuples_head);
	// Remove entries with 0 value
	remove_0(&tuple->tuples_head);
	// order the tuple from lowest value to the highest value
	sort_tuple(&tuple->tuples_head);
	
	
	// Using a loop to set the number of non_zero entires
	tuple->nz = 0; // Initialize non_zero entries to 0
	current = tuple->tuples_head; // set current to tuple_head
	while (current != NULL)
	{
		tuple->nz = tuple->nz + 1; // increment # of non_zero entries
		current = current->next;   // set the current to current->next
	}
	// Close the file
	fclose(file);
	
    return tuple;
}


/* Find the node's value indicated by row & col
 * @input: a pointer to the tuple
 		   row & col coordinate
 * @output: the value of the node indicated by row & col
 */
double gv_tuples(sp_tuples * mat_t,int row,int col)
{
	// Current node
	sp_tuples_node* current = mat_t->tuples_head;
	
	// Go through the tuple to find the node indicated by row & col
	while (current != NULL)
	{
		// Check if the node found
		if (current->row == row && current->col == col)
		{
			// Return the value
			return current->value;
		}
	}
	// Return 0 if the node is not found
    return 0;
}


/* Insert the node given by the current parameters
 * Three cases: 
 				1. value == 0, delete the node indicated by row & col
 				2. value != 0, row & col exist, update the value
 				3. value != 0, row & col don't exist, insert a node
 * @input: a pointer to the tuple
 		   row & col coordinate, and value
 * @output: void
 */
void set_tuples(sp_tuples * mat_t, int row, int col, double value)
{
	// Head of the tuple
	sp_tuples_node* head = mat_t->tuples_head;
	
	// Case value == 0
	if (value == 0)
	{
		// Remove the node indicated by row & col
		remove_node(&head, row, col, value);
	}
	// Case value != 0
	else 
	{
		// Get the pointer to the indicated node(row, col)
		sp_tuples_node* update = find_node(head, row, col);
		// Case value != 0 && (row, col) is not found
		if (update == NULL)
		{
			// Insert the node to an appropriate place
			insert_node(&head, row, col, value);
		}
		// Case value != 0 && (row, col) is found
		else
		{
			// update the value
			update->value = value;
		}
	}
    return;
}


/* Wrtie date in mat_to a .txt file file_name
 * @input: file_name that we write to
 *		   a tuple list
 * @output: void
 */
void save_tuples(char * file_name, sp_tuples * mat_t)
{
	// Open a file to write
	FILE* file = fopen(file_name, "w");
	
	// Write the row and col to the file
	fprintf(file, "%d %d\n", mat_t->m, mat_t->n);
	
	// Creat a tuple node called current to go through the tuple
	sp_tuples_node* current = mat_t->tuples_head;
	
	// Using a loop to write the rest of the content
	while (current != NULL)
	{
		// Write to the file
		fprintf(file, "%d %d %lf", current->row, current->col, current->value);
		
		// Set the current node to the next
		current = current->next;
	}
	
	// Close the file
	fclose(file);
	return;
}



// 
sp_tuples * add_tuples(sp_tuples * matA, sp_tuples * matB)
{
	// Check if two matrix are addable
	if (matA->m != matB->m || matA->n != matB->n)
		return NULL;
	
	// Create a new matrix C
	sp_tuples* matC = malloc(sizeof(sp_tuples));
	
	matC->m = matA->m;	// initialize # row
	matC->n = matA->n;	// initialize # col
	matC->nz = 0;		// initialize nz to 0
	
	// Allocate memory for the head pointer of the tuple
	matC->tuples_head = NULL;
	
	// Create a pointer to go through matA
	sp_tuples_node* matAcurrent = matA->tuples_head;
	// Create a pointer to go through matB
	sp_tuples_node* matBcurrent = matB->tuples_head;
	
	// Use a loop to add all elements in A with C
	while (matAcurrent != NULL)
	{
		int i = matAcurrent->row;	// current row
		int j = matAcurrent->col;	// current col
		
		sp_tuples_node *Atemp, *Ctemp;				// pointer to matA and matC
		Atemp = find_node(matA->tuples_head, i, j);	// find the node in matA with the index i,j
		Ctemp = find_node(matC->tuples_head, i, j);	// find the node in matC with the index i,j
		
		// Check if matC(i,j) == 0
		if (Ctemp == NULL)
		{
			// insert the node if it is 0
			insert_node(&(matC->tuples_head), i, j, Atemp->value);
			// Increase the non-zero entry counter
			matC->nz = matC->nz + 1;
		}
		else 
		{
			// update value of matC(i,j)
			Ctemp->value = Ctemp->value + Atemp->value;
			// If matC(i,j)+matA(i,j)==0, decrement non-zero entry counter
			if ((Ctemp->value + Atemp->value) == 0)
			{
				// decrease matC->nz
				matC->nz = matC->nz - 1;
			}
		}
		// Increse matAcurrent
		matAcurrent = matAcurrent->next;
	}
	
	while (matBcurrent != NULL)
	{
		int i = matBcurrent->row;		// current row
		int j = matBcurrent->col;		// current col
		
		sp_tuples_node *Btemp, *Ctemp;				// pointer to matB and matC
		Btemp = find_node(matB->tuples_head, i, j);	// find the node in matB with the index i,j
		Ctemp = find_node(matC->tuples_head, i, j);	// find the node in matC with the index i,j
		
		if (Ctemp == NULL)
		{
			// insert the node if it is 0
			insert_node(&(matC->tuples_head), i, j, Btemp->value);
			// Increase the non-zero entry counter
			matC->nz = matC->nz + 1;
		}
		else 
		{
			// update value of matC(i,j)
			Ctemp->value = Ctemp->value + Btemp->value;
			// If matC(i,j)+matB(i,j)==0, decrement non-zero entry counter
			if ((Ctemp->value + Btemp->value) == 0)
			{
				// decrease matC->nz
				matC->nz = matC->nz - 1;
			}
		}
		// Increment matBcurrent
		matBcurrent = matBcurrent->next;
	}
	// Remove 0s from the matC
	remove_0(&(matC->tuples_head));
	
	//return retmat;
	return matC;
}



sp_tuples * mult_tuples(sp_tuples * matA, sp_tuples * matB)
{ 
	// Check if two matrix are multipliable
	if (matA->n != matB->m)
		return NULL;
	
	// Create a new matrix C
	sp_tuples* matC = malloc(sizeof(sp_tuples));
	
	matC->m = matA->m;	// initialize # row
	matC->n = matB->n;	// initialize # col
	matC->nz = 0;		// initialize nz to 0
	
	// Allocate memory for the head pointer of the tuple
	matC->tuples_head = NULL;
	
	// Create a pointer to go through matA
	sp_tuples_node* matAcurrent = matA->tuples_head;
	// Create a pointer to go through matB
	sp_tuples_node* matBcurrent = matB->tuples_head;
	
	// Go through matA
	while (matAcurrent != NULL)
	{
		int iA = matAcurrent->row;		// current row of matA
		int jA = matAcurrent->col;		// current col of matA
		
		matBcurrent = matB->tuples_head;// reinitialize matBcurrent
		
		// Go through matB
		while (matBcurrent != NULL)
		{
			matC->nz = matC->nz + 1;
			int iB = matBcurrent->row;	// current row of matB
			int jB = matBcurrent->col;	// current col of matB
			
			if (jA == iB) {
				sp_tuples_node* Ctemp = find_node(matC->tuples_head, iA, jB); // find the node in matC with the index iA,jB
				
				// Check if matC(iA,jB) if 0
				if (Ctemp == NULL)
				{
					// Increment matC->nz
					;
					matBcurrent = matB->tuples_head;
					// Calculate matA(iA,jA)*matB(iB,jB)
					double Cvalue = (matAcurrent->value) * (matBcurrent->value);
					// Insert this node to matC
					insert_node(&(matC->tuples_head), iA, jB, Cvalue);	
				}
				else 
				{
					// Calculate and assign value to Ctemp
					double Cvalue = Ctemp->value + (matAcurrent->value) * (matBcurrent->value);
					Ctemp->value = Cvalue;
					
					// Check if Ctemp->value == 0
					if (Cvalue == 0) {
						;//matC->nz = matC->nz - 1;
					}
				}
			}
			// Increment matBcurrent
			matBcurrent = matBcurrent->next;
		}
		// Increment matAcurrent
		matAcurrent = matAcurrent->next;
	}
	
	// Remove 0s from the matC
	remove_0(&(matC->tuples_head));
	
	//return retmat;
	return matC;
}


/* Helper function Funtion to destroy a linked list using recursion 
 * @input: head ptr to the linked list
 * @ouptut: void
 */
void destroy_linkedlist(sp_tuples_node* node_ptr)
{
	// Base case: node_ptr == NULL
	if (node_ptr == NULL)
	{
		return;
	}
	// Base case: node_ptr->next == NULL, free node_ptr
	else if (node_ptr->next == NULL)
	{
		free(node_ptr);
	}
	// Recursive case
	else
	{
		destroy_linkedlist(node_ptr->next);
	}
}

/* Function to destroy the tuple list
 * @input: a pointer to the tuple list
 * @output: void
 */
void destroy_tuples(sp_tuples * mat_t){
	// Free the linked list
	destroy_linkedlist(mat_t->tuples_head);
	// Free the tuple list
	free(mat_t);
    return;
}






