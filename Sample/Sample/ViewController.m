//
//  ViewController.m
//  Sample
//
//  Created by Ross Gibson on 15/10/2013.
//  Copyright (c) 2013 Triggertrap. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TTCounterLabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

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
    if (self.counterLabel.isRunning) {
        [self.counterLabel stop];
        
        [self updateUIForState:kTTCounterStopped withSource:self.counterLabel];
    } else {
        [self.counterLabel start];
        
        [self updateUIForState:kTTCounterRunning withSource:self.counterLabel];
    }
}

- (IBAction)resetTapped:(id)sender {
    [self.counterLabel reset];
    
    [self updateUIForState:kTTCounterReset withSource:self.counterLabel];
}

#pragma mark - Private

- (void)customiseAppearance {
    [self.counterLabel setBoldFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:55]];
    [self.counterLabel setRegularFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:55]];
    
    // The font property of the label is used as the font for H,M,S and MS
    [self.counterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25]];
    
    // Default label properties
    self.counterLabel.textColor = [UIColor darkGrayColor];
    
    // After making any changes we need to call update appearance
    [self.counterLabel updateApperance];
}

- (void)updateUIForState:(NSInteger)state withSource:(TTCounterLabel*) label {
    switch (state) {
        case kTTCounterRunning:
            [self.startStopButton setTitle:NSLocalizedString(@"Stop", @"Stop") forState:UIControlStateNormal];
            self.resetButton.hidden = YES;
            break;
            
        case kTTCounterStopped:
            [self.startStopButton setTitle:NSLocalizedString(@"Resume", @"Resume") forState:UIControlStateNormal];
            self.resetButton.hidden = NO;
            break;
            
        case kTTCounterReset:
            [self.startStopButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            self.resetButton.hidden = YES;
            self.startStopButton.hidden = NO;
            break;
            
        case kTTCounterEnded:
            self.startStopButton.hidden = YES;
            self.resetButton.hidden = NO;
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
