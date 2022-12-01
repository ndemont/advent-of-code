#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
    char const* const fileName = argv[1];
    FILE* file = fopen(fileName, "r");
    char line[256];
    long max_calories;
    long sum;

    max_calories = 0;
    sum = 0;
    while (fgets(line, sizeof(line), file)) {
        if (line[0] == '\n')
        {
            if (sum > max_calories)
                max_calories = sum;
            sum = 0;
        }
        sum += atol(line);
    }
    if (sum > max_calories)
        max_calories = sum;

    fclose(file);
    printf("The Elf carrying the most Calories holds %ld\n", max_calories);
    return 0;
}
