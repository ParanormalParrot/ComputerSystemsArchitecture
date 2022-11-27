#include <stdio.h>
#include <limits.h>

double f(double a, double b, double x) {
    return a + b * x * x * x;
}

double integrate(double a, double b, int lower, int upper) {
    double step = 0.0000001;
    double res = 0.0;
    for (double i = lower; i < upper; i += step) {
        res += (f(a, b, i + step) + f(a, b, i)) * step / 2;
    }
    return res;
}

int main(int argc, char *argv[]) {
    double a = 0;
    double b = 0;
    int lower = 0;
    int upper = INT_MIN;
    double res;
    if (argc != 1 && argc != 2 && argc != 3) {
        printf("You need to specify 2 files in the command line arguments: input "
               "and output");
        return 1;
    } else if (argc == 1) {
        printf("Insert a(double):");
        scanf("%lf", &a);
        printf("Insert b(double):");
        scanf("%lf", &b);
        printf("Inser the lower bound(int):");
        scanf("%d", &lower);
        while (upper <= lower) {
            printf("Insert the upper bound(int):");
            scanf("%d", &upper);
        }
    } else if (argc == 2) {
        FILE *f = fopen(argv[1], "r");
        fscanf("%lf", &a);
        fscanf("%lf", &b);
        fscanf("%d", &lower);
        fscanf("%d", &upper);
        fclose(f);
    } else {
        FILE *f = fopen(argv[1], "r");
        fscanf("%lf", &a);
        fscanf("%lf", &b);
        fscanf("%d", &lower);
        fscanf("%d", &upper);
        fclose(f);
    }
    res = integrate(a, b, lower, upper);
    printf("%f", res);
}
