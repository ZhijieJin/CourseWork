/* Zhijie Jin (Zhijie Jin), Hamza Waseem (hwasee3)
 * MP9: Maze Solver
 * 
 * In this mp, we implemented an maze solver. 
 * The program takes a maze from a .txt fill and solve the given maze.
 * The wall of the maze is represented by '%'.
 * The stating point and ending point are represented by 'S' and 'E'.
 * The program find the correct path by marking the path with '.'
 * All visited cells (but not in the solved path) are represented by '~'
 *
 * This program has 4 functions:
 * maze_t * createMaze(char * fileName);
 			function: make a maze using the give file
 			@input: a pointer to the file that contains the maze
 			@output: a pointer that pioints to the maze
 * void destroyMaze(maze_t * maze);
 			function: destroy the maze to free memmory space
 			@input: a pointer to the maze
			@output: void
 * void printMaze(maze_t * maze);
 			function: print the maze
 			@input: a pointer to the maze
 			@output: void
 * int solveMazeMahhatanDFS(maze_t * maze, int col, int row);
			function: solve a given maze with the give staring point
			@input: a pointer to the maze
					starting point (row, col)
			@output: 0 if the maze is unsolvable
					 1 if the maze can be solved
 * Note: There might be multiple solution to the given maze. 
 		 However, only one solutions are found using this method.
 		 By checking left, right, up, and bottom in different order, the solution may vary.
 */

#include <stdio.h>
#include <stdlib.h>
#include "maze.h"

/*
 * createMaze -- Creates and fills a maze structure from the given file
 * INPUTS:       fileName - character array containing the name of the maze file
 * OUTPUTS:      None 
 * RETURN:       A filled maze structure that represents the contents of the input file
 * SIDE EFFECTS: None
 */
maze_t * createMaze(char * fileName)
{
	maze_t* ptr = malloc(sizeof(maze_t));	// allocate space for the maze
	
    FILE* file;								// create a file
    file = fopen(fileName, "r");			// open a file to read
    
    int rows, cols;							// create int variables to store the number of rows & cols of the maze
    fscanf(file, "%d %d", &cols, &rows);	// get rows and cols from the file
        
    ptr->height = rows;		// set the width 
    ptr->width = cols;		// set the height
    
    ptr->cells = malloc(cols * sizeof(char*)); // allocate space for cells in the maze_t structure
    
    int i, j;	// iterate through the files
    char c;		// store the char read from the file temperarily
    
    // Assign space for each rows in the 2-D array
    for (j = 0; j < cols; j++)
    	ptr->cells[j] = malloc(rows * sizeof(char));
    
    // Assign values to each element in the ptr->cells 
    // Also, find the start coordinates and end coordinates of the maze
    for (i = 0; i < rows; i++)
    {
    	for (j = 0; j < cols; j++)
    	{
    		fscanf(file, "%c", &c);			// read each char in the file to c
    		if (c == '\n')					// ignore the '\n' new_line char
    			fscanf(file, "%c", &c);
    		ptr->cells[i][j] = c;			// put the char to the ptr->cells
    		if (ptr->cells[i][j] == 'S')	// check if the char == 'S'
    		{
    			ptr->startColumn = j;		// set startColum
    			ptr->startRow = i;			// set startRow	
    		}
    		if (ptr->cells[i][j] == 'E')	// check if the char == 'E'
    		{
    			ptr->endColumn = j;			// set endColumn
    			ptr->endRow = i;			// set endRow
    		}
    	}
    }
    
    // Close the file
    fclose(file);
    
    // Return the ptr
    return ptr;
}

/*
 * destroyMaze -- Frees all memory associated with the maze structure, including the structure itself
 * INPUTS:        maze -- pointer to maze structure that contains all necessary information 
 * OUTPUTS:       None
 * RETURN:        None
 * SIDE EFFECTS:  All memory that has been allocated for the maze is freed
 */
void destroyMaze(maze_t * maze)
{
    // Your code here.
    int j;
    // Free the cells of the maze first
    for (j = 0; j < maze->width; j++)
    	free(maze->cells[j]);
    // Free the maze ptr
    free(maze);
    maze = NULL;
    return;
}

/*
 * printMaze --  Prints out the maze in a human readable format (should look like examples)
 * INPUTS:       maze -- pointer to maze structure that contains all necessary information 
 *               width -- width of the maze
 *               height -- height of the maze
 * OUTPUTS:      None
 * RETURN:       None
 * SIDE EFFECTS: Prints the maze to the console
 */
void printMaze(maze_t * maze)
{
    // Your code here.
    
    int rows = maze->height;					// Get the height of the maze
    int cols = maze->width;						// Get the width of the maze
    int i, j;									
    for (i = 0; i < rows; i++)					// Go through the rows
    {
    	for (j = 0; j < cols; j++)				// Go through the cols
    	{
    		printf("%c",maze->cells[i][j]);		// Print the char
    	}
    	printf("\n");							// Print a new line
    }
}

/*
 * solveMazeManhattanDFS -- recursively solves the maze using depth first search,
 * INPUTS:               maze -- pointer to maze structure with all necessary maze information
 *                       col -- the column of the cell currently beinging visited within the maze
 *                       row -- the row of the cell currently being visited within the maze
 * OUTPUTS:              None
 * RETURNS:              0 if the maze is unsolvable, 1 if it is solved
 * SIDE EFFECTS:         Marks maze cells as visited or part of the solution path
 */ 
int solveMazeManhattanDFS(maze_t * maze, int col, int row)
{
    // Your code here. Make sure to replace following line with your own code.
    
    // Check the out of bound conditions, col and row are index starting from 0
    // return 0 if the cell is not in the maze
    if (col >= maze->width || col < 0 || row >= maze->height || row < 0) 
    	return 0;
    
    // check if the cell in the maze is an empty cell, 'S' and 'E' are treated as empty cells
    // return 0 if the cell is not empty
    if (maze->cells[row][col] == ' ' || maze->cells[row][col] == 'S' || maze->cells[row][col] == 'E')
    	;
    else
    	return 0;
    
    // Check if the cell is the end
    // return 1 if it is the end of the maze
    if (maze->cells[row][col] == 'E')
    	return 1;
    
    // Check if the cell is the starting cell
    // If the cell is not a starting cell, make it '.'
    if (maze->cells[row][col] != 'S')
    	maze->cells[row][col] = '.';
    
	// Recursion to the left cell
    if (solveMazeManhattanDFS(maze, col-1, row) == 1)
    	return 1;
	
	// Check if we ever step back to the starting cell
	// If we come back, make the cell we visited on the left to '~'
    if (maze->cells[row][col+1] == 'S')
    		maze->cells[row][col] = '~';
    
    // Recursion to the right cell
    if (solveMazeManhattanDFS(maze, col+1, row) == 1)
    	return 1;

    // Recursion to the top cell
    if (solveMazeManhattanDFS(maze, col, row-1) == 1)
    	return 1;
    
    // Check if we ever step back to the starting cell
    // If we come back, make the cell we visited on the top to '~'	
    if (maze->cells[row+1][col] == 'S')
    		maze->cells[row][col] = '~';
    
    // Recursion to the bottom cell
    if (solveMazeManhattanDFS(maze, col, row+1) == 1)
    		return 1;
    
    // Exclude the starting cell, make the rest visited cells '~'
    if (maze->cells[row][col] != 'S')
    		maze->cells[row][col] = '~';
    
    return 0;
}
