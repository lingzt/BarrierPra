//
//  ViewController.m
//  Pra
//
//  Created by ling toby on 11/9/16.
//  Copyright (c) 2016 ling toby. All rights reserved.
//

#import "ViewController.h"


NSString *_name;

@interface ViewController ()
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonnull, strong, nonatomic) dispatch_queue_t syncQueue;
@end

@implementation ViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for(int i=0; i<1000; i++){
        NSString *tempName = [NSString stringWithFormat:@"%d",i];
        [self name];
        [self setName:tempName];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//并行队列

//用同步
- (NSString *)name{
    __block NSString *localName;
    dispatch_sync(_syncQueue, ^{
        localName =_name;
        NSLog(@"getter");
        NSLog(localName);
    });
    return localName;
}
//利用异步栅栏块
- (void)setName:(NSString *)name{
    dispatch_barrier_async(_syncQueue, ^{
        _name = name;
        NSLog(@"settter");
        NSLog(_name);
    });
}


@end
