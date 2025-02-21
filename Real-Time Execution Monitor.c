#include <stdio.h>

void debug_execution_monitor() {
    unsigned long long t1, t2;
    asm volatile ("rdtscp" : "=A"(t1));  // Read timestamp counter
    compile_request_code();              // Execute ReQuest code
    asm volatile ("rdtscp" : "=A"(t2));  // Read timestamp counter
    printf("[DEBUG] Execution cycles: %llu\n", t2 - t1);
}
