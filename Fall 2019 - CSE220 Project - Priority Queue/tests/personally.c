#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "../src/priority_queue.h"
#include "../src/validate.h"


/* 
Used Primarily to test pqueue_validate.
Do not depend on the structure of these PriorityQueues,
they have been purposefully malformed to test pqueue_validate 
*/

int main(int argc, char *argv[])
{
    struct PriorityQueue* pqueue1 = pqueue_init(10);
    struct PriorityQueue* pqueue2 = pqueue_init(10);
    struct PriorityQueue* pqueue3 = pqueue_init(10);
    struct PriorityQueue* pqueue4 = pqueue_init(10);
    struct PriorityQueue* pqueue5 = pqueue_init(10);
    struct PriorityQueue* pqueue6 = pqueue_init(10);
    struct PriorityQueue* pqueue7 = pqueue_init(4);

    
    pqueue1->nprios = 15;
    if(pqueue_validate(pqueue1)){
        puts("failed1");
        return 1;
    }

    
    struct PQNode* temp = (PQNode*) calloc(1, sizeof(PQNode));
    pqueue2->head = temp;
    if(pqueue_validate(pqueue2)){
        puts("failed2");
        return 1;
    }

    
    pqueue_insert(pqueue3, 6, 0);
    pqueue_insert(pqueue3, 5, 4);
    pqueue_insert(pqueue3, 5, 3);
    pqueue_insert(pqueue3, 7, 3);
    pqueue3->tails[3]->priority = 2;
    if(pqueue_validate(pqueue3)){
        puts("failed3");
        return 1;
    }


    pqueue_insert(pqueue4, 6, 0);
    pqueue4->head->priority = 16;
    if(pqueue_validate(pqueue4)){
        puts("failed4");
        return 1;
    }


    pqueue_insert(pqueue5, 6, 0);
    pqueue_insert(pqueue5, 5, 4);
    pqueue_insert(pqueue5, 5, 3);
    pqueue_insert(pqueue5, 7, 3);
    pqueue5->head->prev = pqueue5->tails[3];
    if(pqueue_validate(pqueue5)){
        puts("failed5");
        return 1;
    }


    pqueue_insert(pqueue6, 6, 0);
    pqueue_insert(pqueue6, 5, 4);
    pqueue_insert(pqueue6, 5, 3);
    pqueue_insert(pqueue6, 7, 3);
    pqueue6->tails[4]->next = pqueue6->tails[3];
    if(pqueue_validate(pqueue6)){
        puts("failed6");
        return 1;
    }

    pqueue_insert(pqueue7, 2, 2);
    if(!pqueue_validate(pqueue7)){
        puts("failed7");
        return 1;
    }
        
    puts("passed");
    return 0;
}
