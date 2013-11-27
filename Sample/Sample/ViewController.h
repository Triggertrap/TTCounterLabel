//
//  ViewController.h
//  Sample
//
//  Created by Ross Gibson on 15/10/2013.
//  Copyright (c) 2013 Triggertrap. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TTCounterLabel.h"

@interface ViewController : UIViewController <TTCounterLabelDelegate>

#pragma mark - Actions

- (IBAction)startStopTapped:(id)sender;
- (IBAction)resetTapped:(id)sender;

@end
