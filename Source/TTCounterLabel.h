//
//  TTCounterLabel.h
//  TTCounterLabel
//
//  Created by Ross Gibson on 10/10/2013.
//  Copyright (c) 2013 Triggertrap. All rights reserved.
//

#import "TTTAttributedLabel.h"

typedef NS_ENUM(NSInteger, kCountDirection){
    kCountDirectionUp = 0,
    kCountDirectionDown
};

typedef NS_ENUM(NSInteger, kDisplayMode) {
    kDisplayModeFull = 0,
    kDisplayModeSeconds = 1
};

#pragma mark - TTCounterLabelDelegate

@protocol TTCounterLabelDelegate <NSObject>
@optional
- (void)countdownDidEnd;
@end

#pragma mark - TTCounterLabel

@interface TTCounterLabel : TTTAttributedLabel

@property (weak) id <TTCounterLabelDelegate> countdownDelegate;
@property (nonatomic, assign) unsigned long long currentValue;
@property (nonatomic, assign) unsigned long long startValue;
@property (nonatomic, assign) NSInteger countDirection;
@property (strong, nonatomic) UIFont *boldFont;
@property (strong, nonatomic) UIFont *regularFont;
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) kDisplayMode displayMode;

#pragma mark - Public Methods

- (void)start;
- (void)stop;
- (void)reset;
- (void)updateApperance;

@end
