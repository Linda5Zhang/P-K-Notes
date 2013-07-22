//
//  MemoriesDetailViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

//***************ABOUT this class*********************
//This class is to show the details of the note,
//and share the note through email
//****************************************************

#import "MemoriesDetailViewController.h"

@interface MemoriesDetailViewController ()
@property (weak, nonatomic) UIImage *image;
@end

@implementation MemoriesDetailViewController

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
    
    //Show note details
    self.theDetailedDate.text = self.currentMemoryNote[@"Date"];
    self.theMemoryNoteDetails.text = self.currentMemoryNote[@"Content"];
    self.theDetailedImage.image = self.getTheImage;
    
    [self.theMemoryNoteDetails setBackgroundColor:[UIColor clearColor]];
    [self.theMemoryNoteDetails setScrollEnabled:YES];
    [self.theMemoryNoteDetails setEditable:NO];
    
}

/*******************************************************************************
 * @method      share email method
 * @abstract
 * @description share the note through email
 *******************************************************************************/
- (IBAction)shareButton:(id)sender {
    if ([MFMailComposeViewController canSendMail] == YES ) {
        
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        
        mailController.mailComposeDelegate = self;
        
        //set the subObject
        [mailController setSubject:@"My baby's 'masterpiece'~"];
        
        //To recipients
        NSArray *toRecipients = [[NSArray alloc] initWithObjects:@"lindaylzh@gmail.com",nil];
        [mailController setToRecipients:toRecipients];
        
        //set CCRecipients
        NSArray *ccRecipients = [[NSArray alloc] initWithObjects:nil];
        [mailController setCcRecipients:ccRecipients];
        
        //Add text to mail body
        NSString *emailBody = self.currentMemoryNote[@"Content"];
        [mailController setMessageBody:emailBody isHTML:YES];
        
        //Add the detail image as an attachment
        UIImage *myImage = self.getTheImage;
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailController addAttachmentData:imageData mimeType:@"image/png" fileName:@"kidsImage"];
        
        //display the view controller
        [self presentViewController:mailController animated:YES completion:nil];

    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Your device can not send email" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        [errorAlert show];
    }
    
}

/******************************************************************************************
 * @method      other situation method
 * @abstract
 * @description handle cancel, send, save draft, fail etc. situation, then hide the mailer
 ******************************************************************************************/
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

@end
