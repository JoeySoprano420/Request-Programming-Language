#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

// Assembly-compiled function prototype
extern void compile_request_code();

int main() {
    printf("[ReQuest JIT] Initializing...\n");

    // Allocate executable memory for JIT
    void *exec_mem = mmap(NULL, 4096, PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    if (exec_mem == MAP_FAILED) {
        perror("mmap failed");
        return 1;
    }

    // Copy compiled machine code into executable memory
    memcpy(exec_mem, (void *)compile_request_code, 4096);

    // Execute JIT-compiled function
    void (*jit_func)() = exec_mem;
    printf("[ReQuest JIT] Executing...\n");
    jit_func();

    // Free memory
    munmap(exec_mem, 4096);
    printf("[ReQuest JIT] Execution complete.\n");

    return 0;
}
