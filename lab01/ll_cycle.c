#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    if (head == NULL) return 0;
    node *tortoise = head, *hare = head;
    do {
        tortoise = tortoise->next->next;
        if (tortoise == NULL) {
            return 0;
        }
        hare = hare->next;
        if (tortoise == hare) {
            return 1;
        }
    } while(tortoise != NULL && tortoise->next != NULL);
    return 0;
}
