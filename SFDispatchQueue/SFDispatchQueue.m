//
//  SFDispatchQueue.m
//  SFDispatchQueue
//
//  Created by vvveiii on 2019/6/24.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "SFDispatchQueue.h"

@interface SFDispatchQueue ()

@end

@implementation SFDispatchQueue

+ (instancetype)queueWithLabel:(const char *)label attr:(SFDispatchQueueAttr)attr {
    return [[self alloc] initWithLabel:label attr:attr];
}

+ (instancetype)mainQueue {
    return [[self alloc] initWithMainQueue];
}

+ (instancetype)globalQueueWithPriority:(SFDispatchQueuePriority)priority {
    return [[self alloc] initWithGlobalQueue:priority];
}

+ (instancetype)queueWithQueue:(dispatch_queue_t)queue {
    return [[self alloc] initWithQueue:queue];
}

- (instancetype)initWithLabel:(const char *)label attr:(SFDispatchQueueAttr)attr {
    return [self initWithQueue:dispatch_queue_create(label, attr)];
}

- (instancetype)initWithMainQueue {
    return [self initWithQueue:dispatch_get_main_queue()];
}

- (instancetype)initWithGlobalQueue:(SFDispatchQueuePriority)priority {
    return [self initWithQueue:dispatch_get_global_queue(priority, 0)];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    if (self = [super init]) {
        _queue = queue;
        _label = dispatch_queue_get_label(queue);
    }

    return self;
}

- (instancetype)init {
    const char *label = NSUUID.UUID.UUIDString.UTF8String;
    
    return [self initWithLabel:label attr:SFDispatchQueueSerial];
}

- (void)setTargetQueue:(SFDispatchQueue *)targetQueue {
    _targetQueue = targetQueue;
    dispatch_set_target_queue(_queue, targetQueue.queue);
}

- (void)async:(SFDispatchBlock)block {
    dispatch_async(_queue, block);
}

- (void)sync:(SFDispatchBlock)block {
    dispatch_sync(_queue, block);
}

- (void)barrierAsync:(SFDispatchBlock)block {
    dispatch_barrier_async(_queue, block);
}

- (void)barrierSync:(SFDispatchBlock)block {
    dispatch_barrier_sync(_queue, block);
}

- (void)after:(SFDispatchTime)when block:(SFDispatchBlock)block {
    dispatch_after(when, _queue, block);
}

- (void)setSpecific:(void *)context forKey:(const void *)key {
    dispatch_queue_set_specific(_queue, key, context, NULL);
}

- (void *)specificForKey:(const void *)key {
    return dispatch_get_specific(key);
}

@end


@implementation SFDispatchQueue (SFDispatchQueue)

+ (instancetype)serialQueueWithLabel:(const char *)label {
    return [self queueWithLabel:label attr:SFDispatchQueueSerial];
}

+ (instancetype)concurrentQueueWithLabel:(const char *)label {
    return [self queueWithLabel:label attr:SFDispatchQueueConcurrent];
}

+ (instancetype)globalDefaultQueue {
    return [self globalQueueWithPriority:SFDispatchQueuePriorityDefault];
}

+ (instancetype)globalBackgroundQueue {
    return [self globalQueueWithPriority:SFDispatchQueuePriorityBackground];
}

+ (instancetype)globalLowQueue {
    return [self globalQueueWithPriority:SFDispatchQueuePriorityLow];
}

+ (instancetype)globalHighQueue {
    return [self globalQueueWithPriority:SFDispatchQueuePriorityHigh];
}

@end
