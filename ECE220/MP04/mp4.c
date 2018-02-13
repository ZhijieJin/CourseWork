#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double numb;

double pow(double x, double y) {
	double result = 1;
	if (y == 0) {
		result = 1;
	}
	else {
		int i;
		for (i = 0; i < y; i++) {
			result = x * result;
		}
	}
	return result;
}

double abs_double(double y)
{
   	// if y < 0, flip the sign, otherwise do nothing
    if (y < 0){
    	y = -y;
    }
    // Return |y|
    return y;
}

double fx_val(double a, double b, double c, double d, double e, double x)
{
    
    double val;
    // result = ax^4+bx^3+cx^2+dx+e
    val = a*pow(x,4)+b*pow(x,3)+c*pow(x,2)+d*x+e;
    
    // Return ax^4+bx^3+cx^2+dx+e
    return val;
}

double fx_dval(double a, double b, double c, double d, double e, double x)
{
    
    double dval;
    // Derivative of fx is 4ax^3+3bx^2+2cx+d
    dval = 4*a*pow(x,3)+3*b*pow(x,2)+2*c*x+d;
    // Return 4ax^3+3bx^2+2cx+d
    return dval;
}

double fx_ddval(double a, double b, double c, double d, double e, double x)
{
    
    double ddval;
    // Double derivative of fx is 12ax^2+6bx+ac
    ddval = 12*a*pow(x,2)+6*b*x+2*c;
    // Return 12ax^2+6bx+ac
    return ddval;
}


double newrfind_halley(double a, double b, double c, double d, double e, double x)
{
	/* Declare f, fp, fpp, abs_fp, diff
		 f = f(x), fp = f'(x), fpp = f"(x), abs_fp = absolute value of fp
		 set diff = 1.0 to enter the loop
	*/
	double f, fp, fpp, abs_fp, diff = 1;
	int i = 0;
	while (abs_double(diff) > 0.000001 && i < 10000) {
		f = fx_val(a,b,c,d,e,x);
		fp = fx_dval(a,b,c,d,e,x);
		fpp = fx_ddval(a,b,c,d,e,x);
		abs_fp = abs_double(fp);
		diff = 2*f*fp/(2*abs_fp*abs_fp - f*fpp);
		
		x = x - diff;
	  i++;
	}
	
	if (i >= 10000) {
		printf("No roots found.\n");
	}
	else {
		printf("Root found: %lf \n", x);
	}
	
  // Return the approximated value of x
  return x;
}

int rootbound(double a, double b, double c, double d, double e, double r, double l)
{
    /* Calculate a' through e' and store them in an array.
    	 An array is easier to count the # of sign flips
		*/ 
    double sign1[5];
    sign1[0] = a; // a'
    sign1[1] = 4*a*l+b; // b'
    sign1[2] = 6*a*pow(l,2)+3*b*l+c; //c'
    sign1[3] = 4*a*pow(l,3)+3*b*pow(l,2)+2*c*l+d; // d'
    sign1[4] = a*pow(l,4)+b*pow(l,3)+c*pow(l,2)+d*l+e; //e'
    
    /* Create a new list to store the n bits of non-zero coefficient
    	 They are stored from checksign1[0] through checksign1[n-1]
    */
    int i = 0;
    int j = 0;
    double checksign1[5] = {0, 0, 0, 0, 0};
    for (i = 0; i < 5; i++) {
    	if (sign1[i] != 0) {
    		checksign1[j] = sign1[i];
    		j++;
    	}
    }
    //numb = checksign1[4];
    
    // Declare vl to store the number of upper bound
    double vl = 0;
    i = 0;
    // Go through checksign1 to count how many sign flips are there
    for (i = 0; i < 4; i++) {
			// If two adjacent coefficient has different sign, increment vl
    	if (checksign1[i]*checksign1[i+1]<0) {
    		vl = vl + 1;
    	}
    }
    
    /* Calculate a" through e" and store them in an array.
    	 An array is easier to count the # of sign flips
		*/ 
    double sign2[5];
    sign2[0] = a; // a"
    sign2[1] = 4*a*r+b; //b"
    sign2[2] = 6*a*pow(r,2)+3*b*r+c; // c"
    sign2[3] = 4*a*pow(r,3)+3*b*pow(r,2)+2*c*r+d; // d"
    sign2[4] = a*pow(r,4)+b*pow(r,3)+c*pow(r,2)+d*r+e; // e"
    
    /* Create a new list to store the n bits of non-zero coefficient
    	 They are stored from checksign2[0] through checksign2[n-1]
    */
    i = 0;
    j = 0;
    double checksign2[5] = {0, 0, 0, 0, 0};
    for (i = 0; i < 4; i++) {
    	if (sign2[i] != 0) {
    		checksign2[j] = sign2[i];
    		j++;
    	}
    }
    
    // Declare vr to store the number of upper bound
    double vr = 0;
    i = 0;
    // Go through checksign2 to count how many times of sign flips
    for (i = 0; i < 4; i++) {
    	// If two adjacent coefficient has different sign, increment vr
    	if (checksign2[i]*checksign2[i+1]<0) {
    		vr = vr + 1;
    	}
    }
    
    // Some type issue?
    double v = abs_double(vl-vr);
    
    return v;
}

int main(int argc, char **argv)
{
	double a, b, c, d, e, l, r;
	FILE *in;

	if (argv[1] == NULL) {
		printf("You need an input file.\n");
		return -1;
	}
	in = fopen(argv[1], "r");
	if (in == NULL)
		return -1;
	fscanf(in, "%lf", &a);
	fscanf(in, "%lf", &b);
	fscanf(in, "%lf", &c);
	fscanf(in, "%lf", &d);
	fscanf(in, "%lf", &e);
	fscanf(in, "%lf", &l);
	fscanf(in, "%lf", &r);
    
  if (rootbound(a,b,c,d,e,r,l)==0) {
  numb = (double)rootbound(a,b,c,d,e,r,l);
  	printf("The polynomial has no roots in the given interval.\n");
  }
  else {
  	double x = l;
  	while (x <= r) {
  		newrfind_halley(a,b,c,d,e,x);
  		/*halley = newrfind_halley(a,b,c,d,e,x);
  		if (halley < l  || halley > r) {
  			printf("No roots found.\n");
  		}
  		else {
  			printf("Root found: %lf \n", halley);
  		}*/
  		x = x+0.5;
  	}
  }
    //The values are read into the variable a, b, c, d, e, l and r.
    //You have to find the bound on the number of roots using rootbound function.
    //If it is > 0 try to find the roots using newrfind function.
    //You may use the fval, fdval and fddval funtions accordingly in implementing the halleys's method.
    
    
    fclose(in);
    
    return 0;
}
