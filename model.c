// ? Step 11: Model your dut in c
#include <svdpi.h>

int find_quotient(
    int divisor, int dividend)
{
    return dividend / divisor;
}

int find_remainder(
    int divisor,
    int dividend)
{
    return dividend % divisor;
}