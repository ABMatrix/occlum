#include <stdlib.h>
#include <stdio.h>

#define MAX_SIZE    (1*1024*1024)
#define MIN_SIZE    8

int main(void) {
    printf("Testing malloc and free...\n");
    for (size_t buf_size = MIN_SIZE; buf_size <= MAX_SIZE; buf_size *= 4) {
        printf("buf_size = %lu\n", buf_size);
        void* buf = malloc(buf_size);
        free(buf);
    }
    printf("Done.\n");
    return 0;
}
