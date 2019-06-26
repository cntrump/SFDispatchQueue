# SFDispatchQueue [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
simple dispatch_queue_t wrapper.

add to your project with `Carthage`
```
github "cntrump/SFDispatchQueue" "master"
```

for Objective-C
```objc
@import SFDispatchQueue;
```

## Example

```objc
_customQueue = [SFDispatchQueue queueWithLabel:"queue.lvv.me" attr:SFDispatchQueueConcurrent];
[_customQueue async:^{
  NSLog(@"custom working 11 ...");
}];
```

dispatch after
```objc
[_customQueue after:dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC) block:^{
  NSLog(@"custom working after 0.3s ...");
}];
```

global queue
```objc
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
```

set target queue
```objc
_customQueue = [SFDispatchQueue queueWithLabel:"queue.lvv.me" attr:SFDispatchQueueConcurrent];
_customQueue.targetQueue = SFDispatchQueue.globalHighQueue;
```

### SFDispatchGroup example
```objc
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
```
