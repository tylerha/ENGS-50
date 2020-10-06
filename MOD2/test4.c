/*
 *
 *
 */
#include<integrate.h>
#include<inttypes.h>
#include<stdlib.h>
#include<stdio.h>

double testf1(double x) {
  double y;
  y=2*x*x+9*x+4;
  return y;
}

int main(void) {
  uint32_t sp = 0;
  double rp = 0;
  double a = 3.0;
  double b = 12.0;
  double p = 10;
  
  double (*f)(double x);
  f=testf1;
  
  int outcome = integrate(f, a, b, p, &rp, &sp);

  if (outcome == 0) {
    exit(EXIT_SUCCESS);
  }
  else {
    exit(EXIT_FAILURE);
  }
}
