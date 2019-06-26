//
//  ViewController.m
//  DispatchQueueExample
//
//  Created by vvveiii on 2019/6/24.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "ViewController.h"
@import SFDispatchQueue;

@interface ViewController () {
    SFDispatchQueue *_customQueue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SFDispatchQueue.globalDefaultQueue async:^{
        NSLog(@"default global queue ...");
    }];

    [SFDispatchQueue.globalBackgroundQueue async:^{
        NSLog(@"background global queue ...");
    }];

    [SFDispatchQueue.globalLowQueue async:^{
        NSLog(@"low global queue ...");
    }];

    [SFDispatchQueue.globalHighQueue async:^{
        NSLog(@"high global queue ...");
    }];

    _customQueue = [SFDispatchQueue queueWithLabel:"queue.lvv.me" attr:SFDispatchQueueConcurrent];
    _customQueue.targetQueue = SFDispatchQueue.globalHighQueue;
    [_customQueue async:^{
        NSLog(@"custom working 11 ...");
    }];

    [_customQueue async:^{
        NSLog(@"custom working 22 ...");
    }];

    [_customQueue after:SFDispatchDelay(0.3) block:^{
        NSLog(@"custom working after 0.3s ...");
    }];

    SFDispatchGroup *group = SFDispatchGroup.group;

    [group enter];
    [group asyncQueue:_customQueue block:^{
        NSLog(@"group working 1 ...");
        [group leave];
    }];

    [group enter];
    [group asyncQueue:_customQueue block:^{
        NSLog(@"group working 2 ...");
        [group leave];
    }];

    [group notifyQueue:SFDispatchQueue.mainQueue block:^{
        NSLog(@"group all done.");
    }];
}

@end
