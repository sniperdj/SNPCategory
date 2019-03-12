//
//  SNPDispatchUtils.m
//  SNPCategory
//
//  Created by Sniper on 2019/3/12.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import "SNPDispatchUtils.h"

@implementation SNPDispatchUtils

static dispatch_queue_t concurrentThread;
static dispatch_queue_t serialThread;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        concurrentThread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        serialThread = dispatch_queue_create("com.pa.Queue", DISPATCH_QUEUE_SERIAL);
    });
}

+ (dispatch_queue_t) getConcurrentQueue{
    if (!concurrentThread) {
        concurrentThread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return concurrentThread;
}

+ (dispatch_queue_t)getSerialQueue
{
    if (!serialThread) {
        serialThread = dispatch_queue_create("com.pa.Queue", DISPATCH_QUEUE_SERIAL);
    }
    return serialThread;
}

void doInMain(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void doInMainAfter(NSTimeInterval sec, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void doInSerial(dispatch_block_t block) {
    dispatch_async([SNPDispatchUtils getSerialQueue], block);
}

void doInSerialAfter(NSTimeInterval sec, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), [SNPDispatchUtils getSerialQueue], block);
}

void doInConcurrent(dispatch_block_t block) {
    dispatch_async([SNPDispatchUtils getConcurrentQueue], block);
}

void doInConCurrentAfter(NSTimeInterval sec, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), [SNPDispatchUtils getConcurrentQueue], block);
}

@end
