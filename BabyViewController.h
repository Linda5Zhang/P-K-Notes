//
//  BabyViewController.h
//  MyFinalApp
//
//  Created by yueling zhang on 3/16/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "AudioToolbox/AudioToolbox.h"
#import "AVFoundation/AVFoundation.h"
#import "PaintView.h"

@interface BabyViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *babypage_background;

- (IBAction)addEmotions:(UITapGestureRecognizer *)sender;

- (IBAction)happyButtonTapped:(id)sender;
- (IBAction)laughButtonTapped:(id)sender;
- (IBAction)xixiButtonTapped:(id)sender;
- (IBAction)sadButtonTapped:(id)sender;
- (IBAction)angryButtonTapped:(id)sender;




@end
