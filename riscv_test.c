int main()
{
    volatile int *p=(int*)0x100;
    *p=1234;
    while(1);
}