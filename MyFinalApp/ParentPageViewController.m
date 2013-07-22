//
//  ParentPageViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/16/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

//***************ABOUT this class*****************************
//this class is an bridge for parents to go to the note page
//************************************************************

#import "ParentPageViewController.h"

@interface ParentPageViewController ()

@end

@implementation ParentPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //show a button for custom to click, and go to the note page
    UIImage *image = [UIImage imageNamed:@"parentpage_background"];
    self.parentPagePic.layer.contents = (id) image.CGImage;
    _parentPagePic.layer.backgroundColor = [UIColor clearColor].CGColor;
    [_parentPagePic.layer setOpaque: NO];
    [_parentPagePic.layer setOpacity: 0.65];
    _parentPagePic.opaque = NO;
}


@end
