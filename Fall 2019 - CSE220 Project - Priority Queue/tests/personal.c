#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "../src/priority_queue.h"
#include "../src/validate.h"

/* Checks init and insert. Uses 2 PriorityQueues. (Third one to test free)
Runs through pqueue_validate 
Ends with free*/

int main(int argc, char *argv[])
{
    PriorityQueue *pqueue = pqueue_init(5);
    if(pqueue->head == NULL && pqueue->tails[0] == NULL && pqueue->tails[1] == NULL && pqueue->nprios == 5){
    }
    else{
    puts("failed1");
    return 1;
    }

    pqueue_insert(pqueue, 3, 0);
    if(!(pqueue->head->value == 3)){
        puts("failed2");
        return 1;
    }
    if(!(pqueue->head->priority == 0)){
        puts("failed3");
        return 1;
    }
    if(!(pqueue->tails[0]->value == 3)){
        puts("failed4");
        return 1;
    }
    
    pqueue_insert(pqueue, 6, 2);
    pqueue_insert(pqueue, 6, 4);

    if(!(pqueue->head->next->next->priority == 4)){
        puts("failed5");
        return 1;
    }
    if(!(pqueue->tails[3] == NULL)){
        puts("failed6");
        return 1;
    }
    if(!(pqueue->tails[2]->value == 6)){
        puts("failed7");
        return 1;
    }

    pqueue_insert(pqueue, 4, 2);
    
    if(!(pqueue->tails[2]->prev->value == 6)){
        puts("failed8");
        return 1;
    }

    PriorityQueue *pqueue2 = pqueue_init(3);

    pqueue_insert(pqueue2, 3, 2);
    pqueue_insert(pqueue2, 5, 0);
    if(!(pqueue2->head->value == 5)){
        puts("failed9");
        return 1;
    }

    pqueue_insert(pqueue2, 3, 0);
    pqueue_insert(pqueue2, 2, 0);
    pqueue_insert(pqueue2, 563, 0);
    pqueue_insert(pqueue2, 90, 0);

    if(!(pqueue2->head->next->next->next->next->next->value == 3)){
        puts("failed10");
        return 1;
    }

    if(!(pqueue_validate(pqueue))){
        puts("failed11");
        return 1;
    }
    if(!(pqueue_validate(pqueue2))){
        puts("failed12");
        return 1;
    }

    PriorityQueue* pqueue3 = pqueue_init(3);
    
    
    pqueue_free(pqueue);
    pqueue_free(pqueue2);
    pqueue_free(pqueue3);
    
    puts("passed");
    return 0;
}
