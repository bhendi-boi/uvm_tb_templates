// ? Step 11: Model your dut in c
int model(
    int reset_n,
    int d_in)
{
    if (!reset_n)
        return 0;
    else
        return d_in;
}