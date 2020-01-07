//
//  ViewController.m
//  TechnologyPractice
//
//  Created by coolkernel on 2019/6/4.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import "ViewController.h"
#import "MHManager.h"
#import "MHLoad.h"
#import "MHPeron.h"

@interface ViewController ()
@property (nonatomic, strong) MHBlock *block;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^block1)(void);
@property (nonatomic, strong) dispatch_queue_t serialQueue;

@end

@implementation ViewController {
    dispatch_semaphore_t semaphore;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *a = @"a";
    NSString *b = [a copy];
    a = @"c";
    NSLog(@"a:%@, b:%@", a, b);

    NSMutableString *m_a = [[NSMutableString alloc] initWithString:@"a"];
    NSString *m_b = [m_a copy];
    m_a = @"c";
    NSLog(@"m_a:%@, m_b:%@", m_a, m_b);

    NSNumber *n1 = @1;
    NSNumber *n2 = [n1 copy];
    n1 = @3;
    NSLog(@"n1:%@, n2:%@", n1, n2);

    NSArray *arr1 = @[@1];
    NSArray *arr2 = [arr1 copy];
    arr1 = @[@2];
    NSLog(@"%p, %p", arr1, arr2);

    return;
//    [self cx_thread];
//    [self cx_semaphore];
//    [self cx_barrier];
//    [self kindOfBlock];
//    [self classCluster];
//    [self dispatchQueue];
    [self dispatchSemaphore];
//    [self blockReference];
}

- (void)blockReference {
    self.block = [[MHBlock alloc] init];
    [self.block blockReference];
}

- (void)kindOfBlock {
    static NSInteger gloable = 10;

    void (^block1)(void) = ^{
        gloable;
    };

    NSInteger age = 10;
    void (^block2)(void) = ^{
        age;
        gloable;
    };

    NSObject *obj = [NSObject new];
    void (^ block3)(void) = ^{
        obj;
    };

    self.block1 = nil;
    self.block1();

    block2();

    NSLog(@"1:%@, 2:%@, 3:%@, %@", block1, block2, block3, self.block1);
}

- (void)classCluster {
    NSNumber *num1 = [NSNumber alloc];
    NSNumber *num2 = [NSNumber alloc];

    NSMutableArray *arr1 = [NSMutableArray alloc];
    NSMutableArray *arr2 = [NSMutableArray alloc];

    NSObject *obj1 = [NSObject alloc];
    NSObject *obj2 = [NSObject alloc];
    NSObject *obj3 = [NSObject alloc];
    NSObject *obj10 = [[NSObject alloc] init];
}

- (void)dispatchQueue {
    dispatch_queue_t serial = dispatch_queue_create("serial queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent = dispatch_queue_create("concurrent queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(serial, ^{
        sleep(5);
        NSLog(@"1");
    });

    dispatch_async(serial, ^{
        sleep(3);
        NSLog(@"2");
    });

    dispatch_sync(concurrent, ^{
        sleep(5);
        NSLog(@"3");
    });

    dispatch_async(concurrent, ^{
        sleep(3);
        NSLog(@"4");
    });
}

- (void)dispatchSemaphore {
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(0);
    }

    if (!self.serialQueue) {
        self.serialQueue = dispatch_queue_create("888", DISPATCH_QUEUE_SERIAL);
    }
    __weak typeof(self) ws = self;
    dispatch_async(self.serialQueue, ^{
        NSLog(@"******1 %@", [NSThread currentThread]);
        __strong typeof(self) ss = ws;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), self.serialQueue, ^{
            dispatch_semaphore_signal(ss->semaphore);
            NSLog(@"signal");
        });
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(self.serialQueue, ^{
            NSLog(@"******2 %@", [NSThread currentThread]);
        });
    });
    NSInteger ret = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)cx_copy {
    MHPeron *parent = [MHPeron new];
    parent.name = @"zhangsan";
    parent.age = 30;

    MHPeron *son = [parent copy];

    son.name = @"lisi";
    son.age = 12;
    NSLog(@"parent pointer:%p, son pointer:%p, name:%@, age:%ld", parent, son, son.name, son.age);

    NSNumber *age1 = @20;
    NSNumber *age2 = [age1 copy];
    age1 = @22;
    NSLog(@"%p, %p, %@, %@", age1, age2, age1, age2);

    NSArray *arr1 = @[@"1", @"2"];
    NSLog(@"%p", arr1);
    NSArray *arr2 = [arr1 copy];
    arr1 = @[@"3", @"4"];
    NSLog(@"%p, %p, %@, %@", arr1, arr2, arr1, arr2);

    NSMutableDictionary *dic = [@{} mutableCopy];
    NSNumber *num1 = [NSNumber numberWithInt:1];
    NSNumber *num2 = [NSNumber numberWithInt:1];
    BOOL numIsEqual = [num1 isEqual:num2];
    [dic setObject:@"aa" forKey:num1];
    [dic setObject:@"bb" forKey:num2];
    NSLog(@"%@", dic);
}

- (void)cx_thread {
    dispatch_queue_t serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent = dispatch_queue_create("concurent", DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"1:%@", [NSThread currentThread]);
    dispatch_sync(concurrent, ^{
        NSLog(@"2:%@", [NSThread currentThread]);
    });

    dispatch_async(serial, ^{
        NSLog(@"3:%@", [NSThread currentThread]);
    });

    dispatch_async(serial, ^{
        NSLog(@"3-1:%@", [NSThread currentThread]);
    });

    dispatch_async(concurrent, ^{
        NSLog(@"4:%@", [NSThread currentThread]);
    });
}

- (void)cx_semaphore {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSLog(@"semaphore 1");
    dispatch_queue_t serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serial, ^{
        NSLog(@"semaphore 加一");
        dispatch_semaphore_signal(semaphore);
    });

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"semaphore 加一");
//        dispatch_semaphore_signal(semaphore);
//    });
    NSLog(@"semaphore 2");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore 3");
}

- (void)cx_barrier {
    dispatch_queue_t concurrent = dispatch_queue_create("concurent", DISPATCH_QUEUE_CONCURRENT);
    NSInteger i = 0;
    while (i < 10) {
        dispatch_async(concurrent, ^{
            NSLog(@"%ld", i);
        });
        i ++;
    }
    dispatch_barrier_sync(concurrent, ^{
        NSLog(@"barrier end");
    });

    NSLog(@"----");
}

//Lock:
- (void)iosLock {
//    OSSpinLock
//    dispatch_semaphore_t
//    pthread_mutex_t
//    NSLock
//    NSCondition
//    PTHREAD_MUTEX_RECURSIVE
//    NSRecursiveLock
//    NSConditionLock
//    synchronized
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}


@end
