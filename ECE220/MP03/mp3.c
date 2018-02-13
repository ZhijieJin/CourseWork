#include <stdio.h>
#include <stdlib.h>

int main()
{
  int row_index;

  printf("Enter the row index : ");
  scanf("%d",&row_index);
	
	int k, i, n=row_index;
	
	// compute the coefficient of each column
	for (k = 0; k <= n; k++){
		double factup=1, factn_k=1;
		
		// Use a loop to compute n*(n-1)*...*k
		for (i = 1; i <= n-k; i++) {
			factup = factup*(n-i+1);
		}
		
		// Use a loop to compute n-k factorial
		for (i = 1; i <= n-k; i++) {
			factn_k = factn_k*i;
		}
		
		// If the coefficient is the last num to print, print a new line
		if (k == n){
			printf("%lu\n", (unsigned long)(factup/factn_k));
			break;
		}
		// Print each coefficent with a space in the back
		printf("%lu ", (unsigned long)(factup/factn_k));
		
	}
	
  return 0;
}

