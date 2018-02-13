/* Zhijie Jin (zhijiej2)
 * MP7
 * In this MP, we are writting a program to solve Sudoku puzzle using recursive backtracing method.
 * The standard Sudoku puzzles have 9*9=81 cells.
 * The 81 cells are divided in to 9 regions.
 *
 * Rules of the game:
 * Fill each row, col, and 9 sub-zones with unique numbers from 1-9
 *
 * There are 5 functions in the program:
 * 1. is_val_in_row(const int val, const int i, const int sudoku[9][9]);
 *	  @input: val to be checked, row number i, and the game board sudoku
 *	  @output: 1 if val exists in row i; 0 if val doesn't exist in row i
 * 2. is_col_in_row(const int val, const int j, const int sudoku[9][9]);
 *	  @input: val to be checked, col number j, and the game board sudoku
 *	  @output: 1 if val exists in col j; 0 if val doesn't exist in col j
 * 3. int is_val_in_3x3_zone(const int val, const int i, const int j, const int sudoku[9][9]);
 *	  @input: val to be checked, row number i, col number j, and the game board sudoku
 *	  @output: 1 if val exists in this sub-zone; 0 if val doesn't exist in this sub-zone
 * 4. int is_val_valid(const int val, const int i, const int j, const int sudoku[9][9]);
 * 	  @input: val to be checked, row number i, col number j, and the game board sudoku
 *	  @output: 1 if val exists already; 0 if val doesn't exist in the game
 *
 * 5. Helper function findij
 *	  Find the available spot in the sudoku board
 * 	  @input: sudoku array, row address(as a pointer), col addr(as a pointer)
 * 	  @output: 0 if the puzzle has no available spot
 * 	   		   1 if an available spot is found
 * 5. int solve_sudoku(int sudoku[9][9]);
 *	  @input: 9x9 int array representing the puzzle
 *	  @output: 1 if the given puzzle can be solved
 *			   0 if the given puzzle cannot be solved
 */

#include "sudoku.h"

//-------------------------------------------------------------------------------------------------
// Start here to work on your MP7
//-------------------------------------------------------------------------------------------------

// You are free to declare any private functions if needed.

// Function: is_val_in_row
// Return true if "val" already existed in ith row of array sudoku.
// @return: 1 if val exists in row i; 0 if val doesn't exist in row i
int is_val_in_row(const int val, const int i, const int sudoku[9][9]) {

  assert(i>=0 && i<9);

  // BEG TODO
  int j;
  for (j = 0; j < 9; j++) {
  	if (sudoku[i][j] == val)
  		return 1; // return 1 if val exists in row i
  }
  
  return 0; // return 0 if val doesn't exist in row i
  // END TODO
}

// Function: is_val_in_col
// Return true if "val" already existed in jth column of array sudoku.
// @output: 1 if val exists in col j; 0 if val doesn't exist in col j
int is_val_in_col(const int val, const int j, const int sudoku[9][9]) {

  assert(j>=0 && j<9);

  // BEG TODO
  int i;
  for (i = 0; i < 9; i++) {
  	if (sudoku[i][j] == val)
  		return 1; // return 1 if val exists in col j
  }
  return 0;	// return 0 if val doesn't exist in col j
  // END TODO
}

// Function: is_val_in_3x3_zone
// Return true if val already existed in the 3x3 zone corresponding to (i, j)
// @return: 1 if val exists in this sub-zone; 0 if val doesn't exist in this sub-zone

// An easier way to write this function
// int 3x3startRow = row - row % 3;
// int 3x3startCol = col - col % 3;
// Then use 3x3startRow and 3x3startCol to loop through the 3x3 region
int is_val_in_3x3_zone(const int val, const int i, const int j, const int sudoku[9][9]) {
   
  assert(i>=0 && i<9);
  
  // BEG TODO
  // Check the first row
  if (i < 3) {
  	// check zone index [0][0]
  	if (j < 3) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 0; p < 3; p++) {
  			for (q = 0; q < 3; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [0][1]
  	else if (j >=3 && j < 6) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 0; p < 3; p++) {
  			for (q = 3; q < 6; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 is val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [0][2]
  	else {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 0; p < 3; p++) {
  			for (q = 6; q < 9; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  }
  else if (i >=3 && i < 6) {
  	// check zone index [1][0]
  	if (j < 3) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 3; p < 6; p++) {
  			for (q = 0; q < 3; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [1][1]
  	else if (j >=3 && j < 6) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 3; p < 6; p++) {
  			for (q = 3; q < 6; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 is val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [1][2]
  	else {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 3; p < 6; p++) {
  			for (q = 6; q < 9; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  }
  else {
  	// check zone index [2][0]
  	if (j < 3) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 6; p < 9; p++) {
  			for (q = 0; q < 3; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [2][1]
  	else if (j >=3 && j < 6) {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 6; p < 9; p++) {
  			for (q = 3; q < 6; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 is val exists in the 3*3 area
  			}
  		}
  	}
  	// check zone index [2][2]
  	else {
  		int p, q; // p -> row; q -> col
  		// check each cell in this area
  		for (p = 6; p < 9; p++) {
  			for (q = 6; q < 9; q++) {
  				if (sudoku[p][q] == val)
  					return 1; // return 1 if val exists in the 3*3 area
  			}
  		}
  	}
  }
  
  return 0; // return 0 if val doesn't exist in the 3*3 area
  // END TODO
}

// Function: is_val_valid
// Return true if the val is can be filled in the given entry.
// @return: 1 if val exists already; 0 if val doesn't exist in the game
int is_val_valid(const int val, const int i, const int j, const int sudoku[9][9]) {

	assert(i>=0 && i<9 && j>=0 && j<9);

	// BEG TODO
	if (is_val_in_row(val, i, sudoku) == 0 && is_val_in_col(val, j, sudoku) == 0 && is_val_in_3x3_zone(val, i, j, sudoku) == 0) {
  	  	return 0; // return 0 if val can be filled
	}
	else return 1; // return 1 if val cannot be filled
	// END TODO
}


// Helper function findij
// Find the available spot in the sudoku board
// @input: sudoku array, row address(as a pointer), col addr(as a pointer)
// @output: 0 if the puzzle has no available spot
//			1 if an available spot is found
int findij(int sudoku[9][9], int *row, int *col) {
	// Needs to use a pointer because otherwise the variable will not be changed in solve_sudoku
	// Go through each grid in the sudoku puzzle and fnd the available spot
	for (int i = 0; i < 9; i++) {
		// Go through each col
		for (int j = 0; j < 9; j++) {
			// Check if the current grid is an available spot
			if (sudoku[i][j] == 0) {
				// assign i and j to the pointer *row & *col
				*row = i;
				*col = j;
				return 1; // Retrun 1 if there is an available spot
			}
		}
	}
	// Return 0 if there is no available spot
	return 0;
}


// Procedure: solve_sudoku
// Solve the given sudoku instance using backtracing method.
// @return: 1 if the given puzzle can be solved
//			0 if the given puzzle cannot be solved
int solve_sudoku(int sudoku[9][9]) {

	// BEG TODO.
	int i, j; // declare i and j to represent row and col index
	// Check the next available grid in the sudoku
	if (findij(sudoku, &i, &j)==0) {
		return 1; // return 1 if there is an available spot
	}
  
  // Go through number 1 to 9 and check is the number is safe to put in the grid
  for (int num = 1; num <= 9; num++) {
  	if (is_val_valid(num, i, j, sudoku) == 0) {
  		sudoku[i][j] = num; // If safe, put num in the spot(i,j)
  		if (solve_sudoku(sudoku)) { // Backtracking
  			return 1;
  		}
  		//Clear the grid if we backtrack(in last state num is 9, which for this state won't loop again)
  		sudoku[i][j] = 0; 
  	}
  }
  return 0;
  
  // END TODO.
}

// Procedure: print_sudoku
void print_sudoku(int sudoku[9][9])
{
  int i, j;
  for(i=0; i<9; i++) {
    for(j=0; j<9; j++) {
      printf("%2d", sudoku[i][j]);
    }
    printf("\n");
  }
}

// Procedure: parse_sudoku
void parse_sudoku(const char fpath[], int sudoku[9][9]) {
  FILE *reader = fopen(fpath, "r");
  assert(reader != NULL);
  int i, j;
  for(i=0; i<9; i++) {
    for(j=0; j<9; j++) {
      fscanf(reader, "%d", &sudoku[i][j]);
    }
  }
  fclose(reader);
}





