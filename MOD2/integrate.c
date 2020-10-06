/* integrate.c --- calculates the integral of a function
 * 
 * 
 * Author: Tyler Hatch
 * Created: Mon Sep 21 19:15:11 2020 (-0400)
 * Version: 2.0
 * 
 * Description: Calculates the integral of a function using the
 * trapezoidal rule on the interval a-b. If the -n <steps> arguments
 * are present then it calculates the integral using n strips. If the
 * -p <precision> arguments are presents it will continue to recompute
 * the integral, doubling the number of strips used each time
 * (starting with 1), until the difference between successive results
 * is less then precision.
 * 
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <inttypes.h>
#include <stdint.h>
#include <math.h>

double f(double x){                                                                                                                                                                                   
  double y;                                                                                                                                                                                           
  y=2*x*x+9*x+4;                                                                                                                                                                                          
  return y;                                                                                                                                                                                            
}                                                                                                                                                                                                           
                                                                                                                                                                                                            
int main(int argc, char *argv[]){
  int i,nflag,pflag;                                          /* Variable Declarations */
  double a,b,precision,width,x,parsum,result,prevresult,diff;
  char *end,ch;
  uint32_t steps,stepcount;


  parsum=0;
  nflag=pflag=0;

  if (argc!=5) {
    printf("usage: integrate a b (-n <steps> | -p <precision>)\n Invalid number of arguments.");
    exit(EXIT_FAILURE);
  }

  ch=argv[3][1];
  
  switch (ch) {
    case 'n':
      nflag=1;
      steps=strtoul(argv[4],&end,10);
      break;
      
    case 'p':
      pflag=1;
      precision=strtod(argv[4],&end);
      break;

    default:
      printf("usage: integrate a b (-n <steps> | -p <precision>)");
      exit(EXIT_FAILURE);
    }
  
  a=strtod(argv[1],&end);
  if (a == 0) {
    exit(EXIT_FAILURE);
  }
  b=strtod(argv[2],&end);
  if (b == 0) {
    exit(EXIT_FAILURE);
  }
  if (a>b) {
    printf("usage: integrate a b (-n <steps> | -p <precision>)\n a must be less than b");
    exit(EXIT_FAILURE);
  }

  
  if (nflag==1) {
    if(steps>0){
      width=(b-a)/steps;
    
      for (i=1;i<steps;i++){
  	x=a+i*width;
  	parsum=parsum+2*f(x);
      }
    
      result=(width/2)*(f(a)+f(b)+parsum);
      printf("interval: [%lf-%lf], n:%u, result=%lf\n",a,b,steps,result);
      exit(EXIT_SUCCESS);
    }
    else {
      printf("usage: integrate a b (-n <steps> | -p <precision>)\n steps must be greater then 0.");
      exit(EXIT_FAILURE);
    }
  }
  else if (pflag==1) {
    if((precision>0) && (precision<1)){
      steps=1;
      prevresult=0;
      diff=1;

      while (diff>precision) {
	width=(b-a)/steps;
	stepcount=steps;
	parsum=0;
	
	for (i=1;i<steps;i++) {
	  x=a+i*width;
	  parsum=parsum+2*f(x);
	}

	result=(width/2)*(f(a)+f(b)+parsum);
	diff=fabs(prevresult-result);
	prevresult=result;
	steps=2*steps;
      }

      printf("interval: [%lf-%lf], strips:%u, result=%lf\n",a,b,stepcount,result);
      exit(EXIT_SUCCESS);
    }
    else {
      printf("usage: integrate a b (-n <steps> | -p <precision>)\n precision must be less than 1 and greater then 0.");
      exit(EXIT_FAILURE);
    }
  }
}




