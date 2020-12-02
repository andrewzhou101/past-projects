#include <stdlib.h>
#include <stdbool.h>
#include "priority_queue.h"

/*
 * Create a new PriorityQueue structure and return it.
 *
 * The newly-created structure should have a NULL head, and every tail
 * pointer in its tails table should be NULL.
 *
 * nprios: The maximum number of priorities to support
 */
PriorityQueue *pqueue_init(int nprios) {
    int i;
    if(nprios < 1){
        return NULL;
    }
    struct PriorityQueue* qpointer = (struct PriorityQueue*) calloc(1, sizeof(struct PriorityQueue));
    qpointer->head = NULL;
    qpointer->nprios = nprios;
    struct PQNode** holdtails = (struct PQNode**) calloc(nprios, sizeof(struct PQNode*));
    for(i = 0; i != nprios; i++){
        holdtails[i] = NULL;
    }
    qpointer->tails = holdtails;
    return qpointer;
}

/*
 * Free all structures associated with this priority queue, including their
 * queue structure itself.  Any access to pqueue after this function returns
 * should be considered invalid.
 *
 * pqueue: the queue to free
 */
void pqueue_free(PriorityQueue *pqueue) {
    if(pqueue->head == NULL){
        free(pqueue->tails);
        free(pqueue);
        return;
    }
    struct PQNode* temp;
    temp = pqueue->head;
    while(temp->next != NULL && sizeof(temp->next) == sizeof(PQNode*)){
        temp = temp->next;
        free(temp->prev);
    }
    free(temp);
    free(pqueue->tails);
    free(pqueue);
}

/*
 * Insert a new node into a queue by priority and value.
 *
 * pqueue: the queue into which the new node should be inserted
 * value: the opaque value being inserted into the queue
 * priority: the priority at which this value is to be inserted
 */
void pqueue_insert(PriorityQueue *pqueue, int value, int priority) {
    int i;
    
    i = priority - 1;
    
    if(priority < 0 || pqueue->nprios <= priority){
        return;
    }
    /* Made the node and put in the integer values */
    struct PQNode* holdInsert = (struct PQNode*) calloc(1, sizeof(struct PQNode));
    holdInsert->priority = priority;
    holdInsert->value = value;
    
    if(pqueue->head == NULL){
        /* If empty queue, easy solution */
        holdInsert->prev = NULL;
        holdInsert->next = NULL;
        pqueue->head = holdInsert;
        pqueue->tails[priority] = holdInsert;
        return;
    }
    if(priority < pqueue->head->priority){
        holdInsert->next = pqueue->head;
        pqueue->head->prev = holdInsert;
        pqueue->head = holdInsert;
        holdInsert->prev = NULL;
        pqueue->tails[priority] = holdInsert;
        return;
    }
    else{
        if(pqueue->tails[priority] != NULL){
            if(pqueue->tails[priority]->next == NULL){
                holdInsert->next = NULL;
            }
            else{
                holdInsert->next = pqueue->tails[priority]->next;
                pqueue->tails[priority]->next->prev = holdInsert;
            }
            holdInsert->prev = pqueue->tails[priority];
            pqueue->tails[priority]->next = holdInsert;
        }
        else{
            while(i > -1){
                if(pqueue->tails[i] != NULL){
                    if(pqueue->tails[i]->next == NULL){
                        holdInsert->next = NULL;
                    }
                    else{
                        holdInsert->next = pqueue->tails[i]->next;
                        pqueue->tails[i]->next->prev = holdInsert;
                    }
                    
                    holdInsert->prev = pqueue->tails[i];
                    pqueue->tails[i]->next = holdInsert;
                    i = -2;
                }
                else{
                    i = i - 1;
                }
            }
        }
    }
    pqueue->tails[priority] = holdInsert;

}

/*
 * Return the head queue node without removing it.
 */
PQNode *pqueue_peek(PriorityQueue *pqueue) {
    return pqueue->head;
}

/*
 * Remove and return the head queue node.
 */
PQNode *pqueue_get(PriorityQueue *pqueue) {
    if(pqueue->head == NULL){
        return NULL;
    }
    struct PQNode* ilya;
    ilya = pqueue->head;
    if(ilya->next == NULL){
        pqueue->head = NULL;
        pqueue->tails[ilya->priority] = NULL;
        return ilya;
    }
    if(!(ilya->priority == ilya->next->priority)){
        pqueue->tails[ilya->priority] = NULL;
    }
    pqueue->head = ilya->next;
    ilya->next->prev = NULL;
    
    return ilya;
}
