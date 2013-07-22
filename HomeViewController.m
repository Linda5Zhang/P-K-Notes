//
//  HomeViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.

//***************ABOUT this class***********************
//This class is home page with instructions for users
//******************************************************

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Add home page image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover.jpg"]];
    [self.view addSubview:imageView];
    
    //Add info button
    UIButton *infoButton;
    infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [infoButton setUserInteractionEnabled:YES];
    [infoButton setFrame:CGRectMake(270, 3, 50, 50)];
    [infoButton addTarget:self action:@selector(infoButtonTapped:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:infoButton];

}


//Actions when info button was tapped--show a instruction view
- (IBAction)infoButtonTapped:(id)sender {
    
    UIAlertView *instructionMsg = [[UIAlertView alloc] initWithTitle:@"INSTRUCTIONS:\n 1.Parents text to keep a diary\n2.Kids can doodle, click or drag\n3.Kids save the screenshot by shaking the phone\n Enjoy~ " message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [instructionMsg show];
    
}


@end
