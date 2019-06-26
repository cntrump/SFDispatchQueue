//
//  SFDispatchQueue.h
//  SFDispatchQueue
//
//  Created by vvveiii on 2019/6/24.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFDispatchDefine.h"
#import "SFDispatchGroup.h"

@interface SFDispatchQueue : NSObject

@property(nonatomic, readonly) const char *label;
@property(nonatomic, readonly) dispatch_queue_t queue;
@property(nonatomic, strong) SFDispatchQueue *targetQueue;

+ (instancetype)queueWithLabel:(const char *)label attr:(SFDispatchQueueAttr)attr;
+ (instancetype)mainQueue;
+ (instancetype)globalQueueWithPriority:(SFDispatchQueuePriority)priority;

+ (instancetype)queueWithQueue:(dispatch_queue_t)queue;

- (void)async:(SFDispatchBlock)block;
- (void)sync:(SFDispatchBlock)block;

- (void)barrierAsync:(SFDispatchBlock)block;
- (void)barrierSync:(SFDispatchBlock)block;

- (void)after:(SFDispatchTime)when block:(SFDispatchBlock)block;

- (void)setSpecific:(void *)specific forKey:(const void *)key;
- (void *)specificForKey:(const void *)key;

@end


@interface SFDispatchQueue (SFDispatchQueue)

+ (instancetype)serialQueueWithLabel:(const char *)label;
+ (instancetype)concurrentQueueWithLabel:(const char *)label;

+ (instancetype)globalDefaultQueue;
+ (instancetype)globalBackgroundQueue;
+ (instancetype)globalLowQueue;
+ (instancetype)globalHighQueue;

@end
