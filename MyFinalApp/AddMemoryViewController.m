//
//  AddMemoryViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.

//***************ABOUT this class*****************************
//this class is for parent user to add a new note
//************************************************************

#import "AddMemoryViewController.h"
#import "MemoriesTableViewController.h"


@interface AddMemoryViewController ()
@property (weak, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *theTime;
@end


@implementation AddMemoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //Show notes table view with brief information
    self.tapToKeepMemories.delegate = self;
    self.tapToKeepMemories.returnKeyType = UIReturnKeyDone;
    self.tapToKeepMemories.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(theKeyboardAppeared:) name:UIKeyboardDidShowNotification object:self.view.window];
    
    [self theMemoryDate];
}


/*******************************************************************************
 * @method      key board method
 * @abstract
 * @description called when the keyboard appears
*******************************************************************************/
- (void)theKeyboardAppeared:sender
{
    NSLog(@"Keyboard Appeared");
}

/*******************************************************************************
 * @method      date method
 * @abstract
 * @description show memory note date
 *******************************************************************************/
- (void)theMemoryDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    self.memoryDate.text = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"The new memory date is %@",self.memoryDate.text);
}

/*******************************************************************************
 * @method      get accurate time method
 * @abstract
 * @description show the memory note's accurate date
 *******************************************************************************/
- (void)accurateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss--mm--hh--dd-MM-yyyy"];
    self.theTime = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"The accurate time is %@",self.theTime);
}

/*******************************************************************************
 * @method      done button method
 * @abstract
 * @description after click the done button, all the data are stored 
 *******************************************************************************/
- (IBAction)endTyping:(id)sender {

    NSString *tempString = [[NSString alloc]initWithString:[_tapToKeepMemories text]];
    NSLog(@"the text you typed in is \" %@ \"",tempString);

    if ([[tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Empty" message:@"Please keep down some memory~" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        [errorAlert show];
        
    }else{
        //Retrieve the NSUserDefaults dictionary
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        // Retrieve a mutable copy of the array of new memories or create  one if it doesn't exists
        NSMutableArray *newMemories = [[defaults arrayForKey:@"NewMemoryNote"] mutableCopy];
        
        if (!newMemories)
            newMemories = [NSMutableArray array];
        
        //create a new memory note object in s simple NSDictionary
        NSString *thisMemoryNoteDate = self.memoryDate.text;
        NSDictionary *abridgeMemoryNote;
        
        abridgeMemoryNote = @{@"Content" : tempString, @"Date" : thisMemoryNoteDate};
        NSLog(@"adridgeMemoryNote is %@",abridgeMemoryNote);
        
        //Add the new memory note to newMemories array
        [newMemories addObject:abridgeMemoryNote];
        
        //Call save image method
        [self saveImage];
        
        // Reset the newMemories array
        [defaults setObject:newMemories forKey:@"NewMemoryNote"];
        [defaults synchronize];
        
        //Push to Memories Table View Controller 
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        MemoriesTableViewController *mtvc = [storyboard instantiateViewControllerWithIdentifier:@"MemoryTVC"];
        [self.navigationController pushViewController:mtvc animated:YES];

    }
    
}

/*******************************************************************************
 * @method      save method
 * @abstract
 * @description save the image for furture use
 *******************************************************************************/
- (void)saveImage {
    //This pulls out PNG data of the image you've captured.
    NSData *pngData = UIImagePNGRepresentation(_image);
    // From here, write it to a file:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; //Get the docs directory
    [self accurateTime];
    NSString *imageName = self.theTime;
    NSString *savedImageName = [[NSString alloc]initWithFormat:@"%@.png",imageName];
    NSLog(@"saved image name : %@",savedImageName);
    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:savedImageName]; //Add the file name
    [pngData writeToFile:savedImagePath atomically:YES]; //Write the file
    
    //Retrieve the NSUserDefaults array
    NSUserDefaults *imageNames = [NSUserDefaults standardUserDefaults];
    // Retrieve a mutable copy of the array of new memories or create  one if it doesn't exists
    NSMutableArray *tempArray = [[imageNames arrayForKey:@"Names"] mutableCopy];
    
    if (!tempArray)
        tempArray = [NSMutableArray array];

    NSString *theName = savedImageName;
    
    //Add the new memory note to newMemories array
    [tempArray addObject:theName];
    // Reset the newMemories array
    [imageNames setObject:tempArray forKey:@"Names"];
    
    [imageNames synchronize];
    
}

/*******************************************************************************
 * @method      camera button tapped method
 * @abstract
 * @description click the camera button to choose a photo from camera roll
 *******************************************************************************/
- (IBAction)photoButton:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePicker.delegate = self;
    // Place image picker on the screen
    [self presentModalViewController:imagePicker animated:YES];
}

#pragma mark - Photo Picker Delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //Show the selected image
    self.addAPhoto.image = self.image;
    
    // Take image picker off the screen - call this dismiss method
    [self dismissModalViewControllerAnimated:YES];
    
    [self.tapToKeepMemories resignFirstResponder];
}

#pragma mark - Text View Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
    NSLog(@"Keyboard Disappeared");
}


@end
