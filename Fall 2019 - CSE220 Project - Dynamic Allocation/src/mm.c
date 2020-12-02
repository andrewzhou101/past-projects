#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

/* Copied directly from my PA2 */
/*
 * A single linked list node in the priority queue.
 */
typedef struct PQNode {
    int priority;
    int bulksize;
    void *value;
    struct PQNode *next;
    struct PQNode *prev;
} PQNode;

/*
 * A Priority Queue.
 */
typedef struct PriorityQueue {
    PQNode *head;       /* Head of the list of all nodes on this queue */
    PQNode **tails;     /* Array of pointers to the tails of each priority */
    int nprios;         /* The number of valid priorities (and entries in tails) */
} PriorityQueue;


/* When requesting memory from the OS using sbrk(), request it in
 * increments of CHUNK_SIZE. */
#define CHUNK_SIZE (1<<12)

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

/* I took the code from my PA2 that I coded earlier this year */

/*
 * Create a new PriorityQueue structure and return it.
 *
 * The newly-created structure should have a NULL head, and every tail
 * pointer in its tails table should be NULL.
 *
 * nprios: The maximum number of priorities to support
 */
PriorityQueue *pqueue_init(int nprios){
    int i;
    void *heap;

    heap = sbrk(CHUNK_SIZE);
    
    if(nprios < 1){
        return NULL;
    }
    struct PriorityQueue* qpointer = (struct PriorityQueue*) heap;
    heap = heap + sizeof(PriorityQueue);
    qpointer->head = NULL;
    qpointer->nprios = nprios;
    struct PQNode** holdtails = (struct PQNode**) heap;
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
void pqueue_insert(PriorityQueue *pqueue, void *value, int priority, void *location, int bulksize){
    int i;
    
    i = priority - 1;
    
    if(priority < 0 || pqueue->nprios <= priority){
        return;
    }
    
    /* Made the node and put in the integer values */
    struct PQNode* holdInsert = location;
    holdInsert->prev = NULL;
    holdInsert->next = NULL;
    holdInsert->priority = priority;
    holdInsert->value = value;
    holdInsert->bulksize = bulksize;
    /* bulksize is equal to the metadata + the user data*/

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













static PriorityQueue *freeTable = NULL;


/*
 * This function, defined in bulk.c, allocates a contiguous memory
 * region of at least size bytes.  It MAY NOT BE USED as the allocator
 * for pool-allocated regions.  Memory allocated using bulk_alloc()
 * must be freed by bulk_free().
 *
 * This function will return NULL on failure.
 */
extern void *bulk_alloc(size_t size);

/*
 * This function is also defined in bulk.c, and it frees an allocation
 * created with bulk_alloc().  Note that the pointer passed to this
 * function MUST have been returned by bulk_alloc(), and the size MUST
 * be the same as the size passed to bulk_alloc() when that memory was
 * allocated.  Any other usage is likely to fail, and may crash your
 * program.
 */
extern void bulk_free(void *ptr, size_t size);

/*
 * This function computes the log base 2 of the allocation block size
 * for a given allocation.  To find the allocation block size from the
 * result of this function, use 1 << block_size(x).
 *
 * Note that its results are NOT meaningful for any
 * size > 4088!
 *
 * You do NOT need to understand how this function works.  If you are
 * curious, see the gcc info page and search for __builtin_clz; it
 * basically counts the number of leading binary zeroes in the value
 * passed as its argument.
 */
static inline __attribute__((unused)) int block_index(size_t x) {
    if (x <= 8) {
        return 5;
    } else {
        return 32 - __builtin_clz((unsigned int)x + 7);
    }
}

/*
 * You must implement malloc().  Your implementation of malloc() must be
 * the multi-pool allocator described in the project handout.
 */
void *malloc(size_t size) {
    fprintf(stderr, "malloc, size = %ld\n", size);
    int i;
    PQNode *wanted;
    void *givethem;

    if(size == 0){
        return NULL;
    }
    
    if(freeTable == NULL){
        freeTable = pqueue_init(13);
    }
    
    if(size > 4088){
        void *bulkchunk = bulk_alloc(size + (sizeof(void) * 8));
        givethem = bulkchunk + 8;
        struct PQNode* bulkNode = bulkchunk;
        bulkNode->priority = 1;
        bulkNode->value = givethem;
        bulkNode->bulksize = size + (sizeof(void) * 8);
        return givethem;
    }
   
    int blockindex = block_index(size);
    int bytesize = 1<<blockindex;
    int numofblocks = 4096 / bytesize;
    
    if(freeTable->tails[blockindex] != NULL){
        wanted = freeTable->tails[blockindex];
        if(wanted == freeTable->head){
            givethem = (pqueue_get(freeTable))->value;
        }
        else{
            if(wanted->next == NULL){
                if(wanted->prev != NULL){
                    wanted->prev->next = NULL;
                }
                else{
                    freeTable->head = NULL;
                }
            }
            else{
                if(wanted->prev != NULL){
                    wanted->prev->next = wanted->next;
                    wanted->next->prev = wanted->prev;
                }
                else{
                    wanted->next->prev = NULL;
                    freeTable->head = wanted->next;
                }
            }
            if(wanted->prev != NULL){
                if(wanted->prev->priority == blockindex){
                    freeTable->tails[blockindex] = wanted->prev;
                }
                else{
                    freeTable->tails[blockindex] = NULL;
                }
            }
            else{
                freeTable->tails[blockindex] = NULL;
            }
            givethem = wanted->value;
        }
        return givethem;
    }
    else{
        void *chunk = sbrk(CHUNK_SIZE);
        for(i = 0; i != numofblocks; i++){
            pqueue_insert(freeTable, chunk + (sizeof(void) * 8), blockindex, chunk, bytesize);
            chunk = chunk + bytesize;
        }
        wanted = freeTable->tails[blockindex];
        
        if(wanted->next == NULL){
            if(wanted->prev != NULL){
                wanted->prev->next = NULL;
            }
            else{
                freeTable->head = NULL;
            }
        }
        else{
            if(wanted->prev != NULL){
                wanted->prev->next = wanted->next;
                wanted->next->prev = wanted->prev;
            }
            else{
                wanted->next->prev = NULL;
                freeTable->head = wanted->next;
            }
        }
        if(wanted->prev != NULL){
            if(wanted->prev->priority == blockindex){
                freeTable->tails[blockindex] = wanted->prev;
            }
            else{
                freeTable->tails[blockindex] = NULL;
            }
        }
        else{
            freeTable->tails[blockindex] = NULL;
        }
        givethem = wanted->value;
        return givethem;
        
    }
}

/*
 * You must also implement calloc().  It should create allocations
 * compatible with those created by malloc().  In particular, any
 * allocations of a total size <= 4088 bytes must be pool allocated,
 * while larger allocations must use the bulk allocator.
 *
 * calloc() (see man 3 calloc) returns a cleared allocation large enough
 * to hold nmemb elements of size size.  It is cleared by setting every
 * byte of the allocation to 0.  You should use the function memset()
 * for this (see man 3 memset).
 */
void *calloc(size_t nmemb, size_t size) {
    fprintf(stderr, "calloc, nmemb = %ld, size = %ld\n", nmemb, size);
    int i;
    PQNode *wanted;
    void *givethem;

    if(size * nmemb == 0){
        return NULL;
    }

    
    if(freeTable == NULL){
        freeTable = pqueue_init(13);
    }
    
    if((size * nmemb) > 4088){
        void *bulkchunk = bulk_alloc((size * nmemb) + (sizeof(void) * 8));
        givethem = bulkchunk + 8;
        struct PQNode* bulkNode = bulkchunk;
        bulkNode->priority = 1;
        bulkNode->value = givethem;
        bulkNode->bulksize = size + (sizeof(void) * 8);
        memset(bulkchunk, 0, size * nmemb);
        return givethem;
    }
    size = size * nmemb;
    int blockindex = block_index(size);
    int bytesize = 1<<blockindex;
    int numofblocks = 4096 / bytesize;
    
    if(freeTable->tails[blockindex] != NULL){
        wanted = freeTable->tails[blockindex];
        if(wanted == freeTable->head){
            givethem = (pqueue_get(freeTable))->value;
        }
        else{
            if(wanted->next == NULL){
                if(wanted->prev != NULL){
                    wanted->prev->next = NULL;
                }
                else{
                    freeTable->head = NULL;
                }
            }
            else{
                if(wanted->prev != NULL){
                    wanted->prev->next = wanted->next;
                    wanted->next->prev = wanted->prev;
                }
                else{
                    wanted->next->prev = NULL;
                    freeTable->head = wanted->next;
                }
            }
            if(wanted->prev != NULL){
                if(wanted->prev->priority == blockindex){
                    freeTable->tails[blockindex] = wanted->prev;
                }
                else{
                    freeTable->tails[blockindex] = NULL;
                }
            }
            else{
                freeTable->tails[blockindex] = NULL;
            }
            
            givethem = wanted->value;
        }
        memset(givethem, 0, size);
        return givethem;
    }
    else{
        void *chunk = sbrk(CHUNK_SIZE);
        for(i = 0; i != numofblocks; i++){
            pqueue_insert(freeTable, chunk + 8, blockindex, chunk, bytesize);
            chunk = chunk + bytesize;
        }
        wanted = freeTable->tails[blockindex];
        if(wanted->next == NULL){
            if(wanted->prev != NULL){
                wanted->prev->next = NULL;
            }
            else{
                freeTable->head = NULL;
            }
        }
        else{
            if(wanted->prev != NULL){
                wanted->prev->next = wanted->next;
                wanted->next->prev = wanted->prev;
            }
            else{
                wanted->next->prev = NULL;
                freeTable->head = wanted->next;
            }
        }
        if(wanted->prev != NULL){
            if(wanted->prev->priority == blockindex){
                freeTable->tails[blockindex] = wanted->prev;
            }
            else{
                freeTable->tails[blockindex] = NULL;
            }
        }
        else{
            freeTable->tails[blockindex] = NULL;
        }
        
        givethem = wanted->value;
        
        memset(givethem, 0, size);
        return givethem;
        
    }

    
}

/*
 * You must also implement realloc().  It should create allocations
 * compatible with those created by malloc(), honoring the pool
 * alocation and bulk allocation rules.  It must move data from the
 * previously-allocated block to the newly-allocated block if it cannot
 * resize the given block directly.  See man 3 realloc for more
 * information on what this means.
 *
 * It is not possible to implement realloc() using bulk_alloc() without
 * additional metadata, so the given code is NOT a working
 * implementation!
 */
void *realloc(void *ptr, size_t size) {
    fprintf(stderr, "realloc, size = %ld\n", size);
    void *new; 
    if(size <= 0){
        free(ptr);
        return NULL;
    }
    if(ptr == NULL){
        new = malloc(size);
        return new;
    }
    if(freeTable == NULL){
        freeTable = pqueue_init(13);
    }
    
    PQNode *metadata = (ptr - (sizeof(void) * 8));
    

    if((metadata->bulksize - 8) >= size){
        return ptr;
    }
    
    new = malloc(size);
    memcpy(new, ptr, metadata->bulksize - 8);
    free(ptr);
    return new;
}

/*
 * You should implement a free() that can successfully free a region of
 * memory allocated by any of the above allocation routines, whether it
 * is a pool- or bulk-allocated region.
 *
 * The given implementation does nothing.
 */
void free(void *ptr) {
    if(ptr != NULL){
        fprintf(stderr, "free, size = %d\n", ((PQNode *)(ptr - (sizeof(void) * 8)))->bulksize);
        }
    if(ptr == NULL){
        return;
    }
    
    PQNode *metadata = (ptr - (sizeof(void) * 8));
    if(metadata->priority == 1){
        bulk_free(metadata, metadata->bulksize);
        return;
    }
    
    pqueue_insert(freeTable, ptr, metadata->priority, metadata, metadata->bulksize);
    
    return;
}

