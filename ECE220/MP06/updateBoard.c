/* Zhijie Jin (zhijiej2)
 * Hamza Waseem (hwasee3)
 *
 * In this MP, we are writing a game call Game of Life
 * The game was played on a m*n board. In the board, 0 represents a dead cell.
 * 1 represents a live cell. A cell has 8 neighbors. If a live cell has 2 or 3 live neighbors,
 * it lives to the next generation. Otherwise, it will die. If a dead cell has exactly 3 live 
 * neighbors, it will be rescued in the next generation. Otherwise, it remians dead.
 *
 * The program has three functions: countLiveNeighbor(), updateBoard(), and aliveStable
 * countLiveNeighbor(int* board, int boardRowSize, int boardColSize, int row, int col):
 * 	 @input: takes an array(represent a 2-D board), row number of the board, 
 *	 		 col number of the board, row of the cell, and column of the cell as input.
 *	 @output: It output the number of live cells the current cell has(1 is live, 0 is dead)
 * updateBoard(int* board, int boardRowSize, int boardColSize):
 *	 @input: takes an array(represent a 2-D board), row size, and column size as input
 *	 @output: void
 *	 @functionality: go through each cell and update the board with it's new value
 * aliveStable(int* board, int boardRowSize, int boardColSize)
 * 	 @input: takes an array(represent a 2-D board), row size, and column size as input
 *	 @output: 0 if the board is the same for the next update
 *			  1 if the board is different for the next update
 */



/*
 * countLiveNeighbor
 * Inputs:
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * row: the row of the cell that needs to count alive neighbors.
 * col: the col of the cell that needs to count alive neighbors.
 * Output:
 * return the number of alive neighbors. There are at most eight neighbors.
 * Pay attention for the edge and corner cells, they have less neighbors.
 */
int countLiveNeighbor(int* board, int boardRowSize, int boardColSize, int row, int col){
	row = row + 1; // the first row index is 1
	col = col + 1; // the first col index is 1
	
	// Check the first row because of the corner cases
	if (row == 1) {
		if (col == 1) {
			// top left corner
			return board[(row-1)*boardColSize+col]
				 + board[(row)*boardColSize+col-1] + board[(row)*boardColSize+col];
		}
		else if (col == boardColSize) {
			// top right corner
			return board[(row-1)*boardColSize+col-2]
				 + board[(row)*boardColSize+col-2] + board[(row)*boardColSize+col-1];
		}
		else {
			// top row
			return board[(row-1)*boardColSize+col-2] + board[(row-1)*boardColSize+col]
				 + board[(row)*boardColSize+col-2] + board[(row)*boardColSize+col-1] + board[(row)*boardColSize+col];
		}
	}
	// Check the last row because the corner cases
	else if (row == boardRowSize) {
		if (col == 1) {
			// bottom left corner
			return board[(row-1)*boardColSize+col]
				 + board[(row-2)*boardColSize+col-1] + board[(row-2)*boardColSize+col];
		}
		else if (col == boardColSize) {
			// bottom right corner
			return board[(row-1)*boardColSize+col-2]
				 + board[(row-2)*boardColSize+col-2] + board[(row-2)*boardColSize+col-1];
		}
		else {
			// bottom row
			return board[(row-1)*boardColSize+col-2] + board[(row-1)*boardColSize+col] 
				 + board[(row-2)*boardColSize+col-2] + board[(row-2)*boardColSize+col-1] + board[(row-2)*boardColSize+col];
		}
	}
	// check the cells besides the frist row and the last row
	else {
		// Check the first column because of the corner cases
		if (col == 1) {
			// left col
			return board[(row-1)*boardColSize+col]
			     + board[(row-2)*boardColSize+col-1] + board[(row-2)*boardColSize+col]
				 + board[(row)*boardColSize+col-1] + board[(row)*boardColSize+col];
		}
		// check the last column because of the corner cases
		else if (col == boardColSize) {
			// right col
			return board[(row-1)*boardColSize+col-2]
				 + board[(row-2)*boardColSize+col-2] + board[(row-2)*boardColSize+col-1]
				 + board[(row)*boardColSize+col-2] + board[(row)*boardColSize+col-1];
		}
		// Cases of all the cells in the middle
		else {
			// Middle cells
			return board[(row-1)*boardColSize+col-2] + board[(row-1)*boardColSize+col] 
				 + board[(row-2)*boardColSize+col-2] + board[(row-2)*boardColSize+col-1] + board[(row-2)*boardColSize+col]
				 + board[(row)*boardColSize+col-2] + board[(row)*boardColSize+col-1] + board[(row)*boardColSize+col];
		}
	}

}



/*
 * Update the game board to the next step.
 * Input: 
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: board is updated with new values for next step.
 */
void updateBoard(int* board, int boardRowSize, int boardColSize) {
	int live[boardRowSize*boardColSize];	// Create an int array to store the index of live cells
	int dead[boardColSize*boardColSize];	// Create an int array to store the index of dead cells
	int i, j, l = 0, d = 0;	// initialize l and d to 0 and declare i
	for (j = 0; j < boardRowSize*boardColSize; j++) {
		live[j] = 0; // initialize every element in live to 0
		dead[j] = 0; // initialize every element in dead to 0
	}
	
	for (i = 0; i < boardRowSize*boardColSize; i++) {
		// 0: dead cell
		if (board[i] == 0) {
			// If the cell is dead and it has 3 live neighbors, rescue it
			if (countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) == 3) {
				live[l] = i;// Store the index of live cells to array live
				l++;		// Increment l by 1
			}
			else {
				dead[d] = i;// Store the index of dead cells to array dead
				d++;		// Increment d by 1
			}
		}
		else {//board[i]==1
			// If the cell is alive and it has 2 live neighbors, keep it alive
			if (countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) == 2) {
				live[l] = i;// Store the index of live cells to array live
				l++;		// Increment l
			}
			// If the cell is alive and it has 3 live neighbors, keep it alive
			else if (countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) == 3) {
				live[l] = i;// Store the index of live cells to array live
				l++;		// Increment l
			}
			else {
				dead[d] = i;// Store the index of dead cells to array dead
				d++;		// Increment d
			}
		}
	}
	
	int m = 1, n = 1;
	
	// rescue the first element in live
	board[live[0]] = 1;
	// Go through the live array except the first one element
	while (live[m] != 0) {
		board[live[m]] = 1;
		m++;
	}
	
	
	// kill the last element in dead
	board[dead[0]] = 0;
	// Go through the dead array except the last one element
	while (dead[n] != 0) {
		board[dead[n]] = 0;
		n++;
	}
	
}

/*
 * aliveStable
 * Checks if the alive cells stay the same for next step
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: return 1 if the alive cells for next step is exactly the same with 
 * current step or there is no alive cells at all.
 * return 0 if the alive cells change for the next step.
 */ 
int aliveStable(int* board, int boardRowSize, int boardColSize){
	
	int i, change = 0;
	// Go through every cell and check its next update value
	for (i = 0; i < boardRowSize*boardColSize; i++) {
		if (board[i] == 0) {
			if (countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) == 3)
				change++; // If a dead cell is rescued, change++
		}
		else if (board[i] == 1) {
			if (countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) != 2 &&
			    countLiveNeighbor(board, boardRowSize, boardColSize, (i)/boardColSize, (i)%boardColSize) != 3)
				change++; // If a live cell is killed, change++
		}
	}
	
	// Check is change remains 0
	if (change == 0)
		return 1; // If change == 0, no changes for the next update, return 1
	else 
		return 0; // If change != 0, there aree changes for the next update, return 0
}

				
				
			

