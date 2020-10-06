/* integratemod.c --- implements the interface designated in integrate.h                                                                                                                                   
 *                                                                                                                                                                                                         
 *                                                                                                                                                                                                         
 * Author: Tyler Hatch                                                                                                                                                                                     
 * Created: Mon Sep 28                                                                                                                                                               
 * Version: 1.0                                                                                                                                                                                            
 *                                                                                                                                                                                                         
 * Description:                                                                                                                                        
 *                                                                                                                                                                                                         
 */
#include<inttypes.h>
#include<integrate.h>
#include<math.h>
#include<stdio.h>

int32_t integrate(double (*f)(double x), double a, double b, double p, double *rp, uint32_t *sp) {
  if (a>b) {
    printf("a = %lf, b = %lf, a must be smaller than b",a,b);
    return 1;
  }

  double diff,prev,width,parsum,x;
  int i;
  uint32_t stepcount;
  
  if ((p>0) && (p<1)) {
    *sp=1;
    *rp=1;
    prev=0;
    diff=1;

    while (diff>p) {
      width=(b-a)/(*sp);
      parsum=0;
      stepcount=*sp;
      
      for (i=1;i<*sp;i++) {
	x=a+i*width;
	parsum=parsum+2*f(x);
      }

      *rp=(width/2)*(f(a)+f(b)+parsum);
      diff=fabs(prev-*rp);
      prev=*rp;
      *sp=2*(*sp);
    }

    printf("interval: [%lf-%lf], p = %lf, # of strips = %u, result = %lf.\n",a,b,p,stepcount,*rp);
    return 0;
  }
  else {
    printf("p = %lf, p must be greater than 0 and less than 1",p);
    return 1;
  }
}
