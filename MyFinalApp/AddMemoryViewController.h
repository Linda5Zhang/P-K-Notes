//
//  AddMemoryViewController.h
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"

@interface AddMemoryViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) NSDictionary *currentMemoryNote;

@property (weak, nonatomic) IBOutlet UILabel *memoryDate;
@property (weak, nonatomic) IBOutlet UITextView *tapToKeepMemories;
@property (weak, nonatomic) IBOutlet UIImageView *addAPhoto;


- (IBAction)endTyping:(id)sender;
- (IBAction)photoButton:(id)sender;

@end
