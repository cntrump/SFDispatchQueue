//
//  SFDispatchGroup.h
//  SFDispatchQueue
//
//  Created by vvveiii on 2019/6/24.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFDispatchDefine.h"

@interface SFDispatchGroup : NSObject

+ (instancetype)group;

- (void)enter;
- (void)leave;

- (void)wait;
- (void)waitForTimeout:(SFDispatchTime)timeout;

- (void)asyncQueue:(SFDispatchQueue *)queue block:(SFDispatchBlock)block;
- (void)notifyQueue:(SFDispatchQueue *)queue block:(SFDispatchBlock)block;

@end
