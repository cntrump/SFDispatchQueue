//
//  SFDispatchGroup.m
//  SFDispatchQueue
//
//  Created by vvveiii on 2019/6/24.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "SFDispatchGroup.h"
#import "SFDispatchQueue.h"

@interface SFDispatchGroup ()

@property(nonatomic, strong) dispatch_group_t group;

@end

@implementation SFDispatchGroup

+ (instancetype)group {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _group = dispatch_group_create();
    }

    return self;
}

- (void)enter {
    dispatch_group_enter(_group);
}

- (void)leave {
    dispatch_group_leave(_group);
}

- (void)wait {
    [self waitForTimeout:DISPATCH_TIME_FOREVER];
}

- (void)waitForTimeout:(SFDispatchTime)timeout {
    dispatch_group_wait(_group, timeout);
}

- (void)asyncQueue:(SFDispatchQueue *)queue block:(SFDispatchBlock)block {
    dispatch_group_async(_group, queue.queue, block);
}

- (void)notifyQueue:(SFDispatchQueue *)queue block:(SFDispatchBlock)block {
    dispatch_notify(_group, queue.queue, block);
}

@end
