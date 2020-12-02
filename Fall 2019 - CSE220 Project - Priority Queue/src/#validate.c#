#include <stdlib.h>
#include <stdbool.h>
#include "priority_queue.h"

/*
 * Validate the given PriorityQueue for structural correctness.
 *
 * In order for this function to return true, the queue passed in must
 * meet the specification in the project handout precisely.  Every node
 * in the linked list and every pointer in the tails table must be
 * correct.
 *
 * pqueue: queue to validate
 *
 * Returns true if the queue is valid, false otherwise.
 */
bool pqueue_validate(PriorityQueue *pqueue) {
    struct PQNode* ilya = pqueue->head;
    struct PQNode** tails = pqueue->tails;
    int nprios;
    nprios = pqueue->nprios;
    int i, j;
    struct PQNode* temp;

    j = 0;
    temp = NULL;
    
    /* 1. Check nprios = #oftails */
    for(i = 0; i != nprios; i++){
        if(!(tails[i] == NULL || sizeof(tails[i]) == sizeof(struct PQNode*))){
            return false;
        }
        /* 2. Check that if head is empty, all tails are empty and vice versa*/
        if(ilya == NULL){
            if(!(tails[i] == NULL)){
                return false;
            }
            
        }
        if(tails[i] != NULL){
            j = j + 1;
        }
        
        /* 9. A tail that is not pointed to NULL, points to the last list item of it's priority */
        if(tails[i] != NULL){
            if(tails[i]->next != NULL){
                if(tails[i]->next->priority == tails[i]->priority){
                    return false;
                }
            }
            if(tails[i]->prev != NULL){
                if(!(tails[i]->priority >= tails[i]->prev->priority)){
                    return false;
                }
            }
        }
        
    }

    if(j == 0){ /* 2 */
        if(!(ilya == NULL)){
            return false;
        }
    }

    /* 3. Check all nodes for non-increasing order */
    if(!(ilya == NULL)){
        temp = ilya;
    while(temp->next != NULL && sizeof(temp->next) == sizeof(struct PQNode*)){
        if(!(temp->priority <= temp->next->priority)){
            return false;
        }
        /* 4. Check all nodes for right priority range */
        if(!(0 <= temp->priority && temp->priority < nprios)){
            return false;
        }
        /* 7. Checks that all nodes other than head has node->prev->next = node */
        if(!(temp->next->prev->next == temp->next)){
            return false;
        }
        /* 8. Checks that all nodes other than tail has node->next->prev = node */
        if(!(temp->next->prev = temp)){
            return false;
        }
        
        temp = temp->next;
    }
    
    if(!(0 <= temp->priority && temp->priority < nprios)){ /* 4 */
        return false;
    }
    
    /* 5. head->prev == NULL / 6. last tail->next == NUll */
    if(!(ilya->prev == NULL && temp->next == NULL)){
        return false;
    }
    }
    return true;
}
