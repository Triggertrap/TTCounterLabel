//
//  TTCounterLabel.m
//  TTCounterLabel
//
//  Created by Ross Gibson on 10/10/2013.
//  Copyright (c) 2013 Triggertrap. All rights reserved.
//

#import "TTCounterLabel.h"

@interface TTCounterLabel () {
    
}

@property (strong, nonatomic) NSString *valueString;
@property (strong, nonatomic) NSTimer *clockTimer;
@property (nonatomic, assign) unsigned long value;
@property (nonatomic, assign) unsigned long resetValue;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) BOOL running;

@end

@implementation TTCounterLabel

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // Initialization code
    self.valueString = @"";
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:25];
    self.boldFont = [UIFont boldSystemFontOfSize:55];
    self.regularFont = [UIFont systemFontOfSize:55];
    self.countDirection = kCountDirectionUp;
    self.value = 0;
    self.startValue = 0;
}

#pragma mark - Setters

- (void)setValue:(unsigned long)value {
    _value = value;
    self.currentValue = _value;
    [self updateDisplay];
}

- (void)setStartValue:(unsigned long)startValue {
    _startValue = startValue;
    self.resetValue = _startValue;
    [self setValue:startValue];
}

#pragma mark - Private

- (void)updateDisplay {
    if (self.countDirection == kCountDirectionDown && _value < 100) {
        [self stop];
        self.valueString = @"00s.00";
        
        // Inform any delegates
        if (self.countdownDelegate && [self.countdownDelegate respondsToSelector:@selector(countdownDidEnd)]) {
            [self.countdownDelegate performSelector:@selector(countdownDidEnd)];
        }
    } else {
        self.valueString = [self timeFormattedStringForValue:_value];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self setText:self.valueString afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        // Hours
        if (weakSelf.value > 3599999) {
            // The hours will be bold font, we need to set the font for the mins and secs
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)weakSelf.regularFont.fontName, weakSelf.regularFont.pointSize, NULL);
            
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(4, 2)];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(8, 2)];
                CFRelease(font);
            }
        }
        
        // Mins
        if (weakSelf.value > 59999) {
            // The mins will be bold font, we need to set the font for the secs
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)weakSelf.regularFont.fontName, weakSelf.regularFont.pointSize, NULL);
            
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(4, 2)];
                CFRelease(font);
            }
        }
        
        CTFontRef boldFont = CTFontCreateWithName((__bridge CFStringRef)weakSelf.boldFont.fontName, weakSelf.boldFont.pointSize, NULL);
        
        if (boldFont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)boldFont range:NSMakeRange(0, 2)];
            CFRelease(boldFont);
        }
        
        return mutableAttributedString;
    }];
    
    [self setNeedsDisplay];
}

- (void)clockDidTick:(NSTimer *)timer {
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime;
    
    // Convert the double to milliseconds
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    
    if (self.countDirection == kCountDirectionDown) {
        [self setValue:(_startValue - milliSecs)];
    } else {
        [self setValue:(_startValue + milliSecs)];
    }
}

- (NSString *)timeFormattedStringForValue:(unsigned long)value {
    int msperhour = 3600000;
    int mspermin = 60000;
    
    int hrs = value / msperhour;
    int mins = (value % msperhour) / mspermin;
    int secs = ((value % msperhour) % mspermin) / 1000;
    int frac = value % 1000 / 10;
    
    NSString *formattedString = @"";
    
    if (hrs == 0) {
        if (mins == 0) {
            formattedString = [NSString stringWithFormat:@"%02ds.%02d", secs, frac];
        } else {
            formattedString = [NSString stringWithFormat:@"%02dm %02ds.%02d", mins, secs, frac];
        }
    } else {
        formattedString = [NSString stringWithFormat:@"%02dh %02dm %02ds.%02d", hrs, mins, secs, frac];
    }
    
    return formattedString;
}

#pragma mark - Public

- (void)start {
    if (self.running) return;
    
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    self.running = YES;
    self.isRunning = self.running;
    
    self.clockTimer = [NSTimer timerWithTimeInterval:0.02
                                              target:self
                                            selector:@selector(clockDidTick:)
                                            userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
}

- (void)stop {
    if (self.clockTimer) {
        [self.clockTimer invalidate];
        self.clockTimer = nil;
        
        _startValue = self.value;
    }
    
    self.running = NO;
    self.isRunning = self.running;
}

- (void)reset {
    [self stop];
    
    self.startValue = self.resetValue;
    [self setValue:self.resetValue];
}

- (void)updateApperance {
    [self setValue:_currentValue];
}

@end
