//
//  MemoriesDetailViewController.h
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@interface MemoriesDetailViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSDictionary *currentMemoryNote;
@property (nonatomic, strong) UIImage *getTheImage;


@property (weak, nonatomic) IBOutlet UITextView *theMemoryNoteDetails;
@property (weak, nonatomic) IBOutlet UILabel *theDetailedDate;
@property (weak, nonatomic) IBOutlet UIImageView *theDetailedImage;


- (IBAction)shareButton:(id)sender;


@end
