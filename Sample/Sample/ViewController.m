//
//  ViewController.m
//  Sample
//
//  Created by Ross Gibson on 15/10/2013.
//  Copyright (c) 2013 Triggertrap. All rights reserved.
//

#import "ViewController.h"

#import "TTCounterLabel.h"

typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

@interface ViewController () <TTCounterLabelDelegate> {
    IBOutlet TTCounterLabel *_counterLabel;
    IBOutlet UIButton *_startStopButton;
    IBOutlet UIButton *_resetButton;
}

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
     // Uncomment this code to use the label as a count down timer
     self.counterLabel.countDirection = kCountDirectionDown;
     [self.counterLabel setStartValue:60000];
     self.counterLabel.countdownDelegate = self;
     */
    
    // Optional
    [self customiseAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)startStopTapped:(id)sender {
    if (_counterLabel.isRunning) {
        [_counterLabel stop];
        
        [self updateUIForState:kTTCounterStopped withSource:_counterLabel];
    } else {
        [_counterLabel start];
        
        [self updateUIForState:kTTCounterRunning withSource:_counterLabel];
    }
}

- (IBAction)resetTapped:(id)sender {
    [_counterLabel reset];
    
    [self updateUIForState:kTTCounterReset withSource:_counterLabel];
}

#pragma mark - Private

- (void)customiseAppearance {
    [_counterLabel setBoldFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:55]];
    [_counterLabel setRegularFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:55]];
    
    // The font property of the label is used as the font for H,M,S and MS
    [_counterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25]];
    
    // Default label properties
    _counterLabel.textColor = [UIColor darkGrayColor];
    
    // After making any changes we need to call update appearance
    [_counterLabel updateApperance];
}

- (void)updateUIForState:(NSInteger)state withSource:(TTCounterLabel *)label {
    switch (state) {
        case kTTCounterRunning:
            [_startStopButton setTitle:NSLocalizedString(@"Stop", @"Stop") forState:UIControlStateNormal];
            _resetButton.hidden = YES;
            break;
            
        case kTTCounterStopped:
            [_startStopButton setTitle:NSLocalizedString(@"Resume", @"Resume") forState:UIControlStateNormal];
            _resetButton.hidden = NO;
            break;
            
        case kTTCounterReset:
            [_startStopButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            _resetButton.hidden = YES;
            _startStopButton.hidden = NO;
            break;
            
        case kTTCounterEnded:
            _startStopButton.hidden = YES;
            _resetButton.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark - TTCounterLabelDelegate

- (void)countdownDidEndForSource:(TTCounterLabel *)source {
    [self updateUIForState:kTTCounterEnded withSource:source];
}

@end
