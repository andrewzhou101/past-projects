#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include "../src/priority_queue.h"
#include "../src/validate.h"

#define NPRIOS 1
#define PRIO   0
#define VALUE  1

int main(int argc, char *argv[]){
    PriorityQueue *pqueue = pqueue_init(NPRIOS);
    struct PQNode *head = pqueue -> head;
    struct PQNode *node = pqueue_peek(pqueue);


    /* Verify*/
    if(!pqueue_validate(pqueue)){
        puts("failed 1");
        return 1;
    }

    if(head != node){
        puts("failed 2");
        return 1;
    }

    pqueue_free(pqueue);
    
    puts("passed");
    return 0;
}
