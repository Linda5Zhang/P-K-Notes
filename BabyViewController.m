//
//  BabyViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/16/13.
//  Copyright (c) 2013 yueling. All rights reserved.

//*********************************ABOUT this class*****************************************
//This BabyViewController class is for the baby part.
//There're some functions as follows:
//(1)addGestureRecognizer to the face images,
//kids can choose different face images to add on the screen.
//(2)Kids can doodle as they like
//(3)If shake the phone, the screen will be saved as a screenshot to the camera roll,
//and show a new screen to draw
//******************************************************************************************


#import "BabyViewController.h"

@interface BabyViewController ()

@property (strong, nonatomic) NSArray *frameImages;
@property (strong, nonatomic) NSArray *buttonImages;
@property (strong, nonatomic) NSArray *tapImages;
@property (strong, nonatomic) NSMutableArray *buttons;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIView *babypage;
@property (strong, nonatomic) UIButton *button;
@property PaintView *paintView;
@property CGPoint locationInView;
@property BOOL flag;
@property int *i;

@end

@implementation BabyViewController

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
    
    //call showBackground method
    [self showBackground];

    //Give kids instructions about how to play
    UIAlertView *chooseAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Honey~\nClick one at the bottom or draw your own picture~" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [chooseAlert show];

}

- (void)viewWillAppear:(BOOL)animated
{
    //call showBackground method
    [self showBackground];
}

/*******************************************************************************
 * @method      basic method
 * @abstract
 * @description Show background image and face images that kids can click
 *******************************************************************************/
- (void)showBackground{
    
    self.babypage_background.frame = CGRectMake(0, 0, 320, 440);
    
    // Select a random image from frameImages array
    _frameImages = @[@"baby_background1", @"baby_background2",@"baby_background3",@"baby_background4"];
    int randomIndex = arc4random()%4;
    
    UIImage *image = [UIImage imageNamed:[self.frameImages objectAtIndex:randomIndex]];
    self.babypage_background.image = image;
    _babypage_background.layer.backgroundColor = [UIColor clearColor].CGColor;
    [_babypage_background.layer setOpaque: NO];
    [_babypage_background.layer setOpacity: 0.9];
    _babypage_background.opaque = NO;
    _babypage_background.userInteractionEnabled = YES;
    
    //Add paint view to babypage_background image view
    CGRect bounds = CGRectMake(5, 5, 310, 400);
    self.paintView = [[PaintView alloc] initWithFrame:bounds];
    [self.babypage_background addSubview:self.paintView];
    [self.paintView setUserInteractionEnabled:YES];
}

/*******************************************************************************
 * @method      method
 * @abstract
 * @description when click on the screen, the gesture will call, and add the 
 *              image that has been defined(changed on the different image chosen)
 *******************************************************************************/
- (IBAction)addEmotions:(UITapGestureRecognizer *)sender {
    
    //Kids need to choose one image, otherwise there's a alert view
    if (self.flag == true) {
        NSLog(@">>>> Single Tap from %@",sender);
        
        _locationInView = [sender locationInView:[_babypage superview]];
        NSLog(@"\ntap location: x:%5.2f y:%5.2f",_locationInView.x,_locationInView.y);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:_image];
        imageView.center = _locationInView;
        imageView.userInteractionEnabled = YES;
        [_babypage_background addSubview:imageView];

        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
        [panGesture setMaximumNumberOfTouches:2];
        [panGesture setDelegate:self];
        [imageView addGestureRecognizer:panGesture];
        
    } else {
        UIAlertView *chooseAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Honey~\nClick one at the bottom or draw your own picture~" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [chooseAlert show];
    }
    
}

/*******************************************************************************
 * @method      panPiece:
 * @abstract    <# abstract #>
 * @description shift the piece's center by the pan amount
 *              reset the gesture recognizer's translation to {0, 0} after applying so the next
 *              callback is a delta from the current position
 *******************************************************************************/
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    [[piece superview] bringSubviewToFront:piece];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

/*******************************************************************************
 * @method      screen shot method
 * @abstract
 * @description This method takes a screenshot of the screen
 *******************************************************************************/
-(void)ScreenShot
{
    UIGraphicsBeginImageContext(self.babypage_background.bounds.size);
    [self.babypage_background.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    
    UIAlertView *screenShotAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"You've saved the picture to your photo library, open it and see!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [screenShotAlert show];
    
}

/*******************************************************************************
 * @method      clear
 * @abstract
 * @description clear the screen 
 *******************************************************************************/
-(void)clearScreen{
    //Get the background view and remove all subviews
    for (UIView *subview in [_babypage_background subviews]) {
        [subview removeFromSuperview];
    }
    [self viewWillAppear:YES];
}

//Button Tapped Mehtods
- (IBAction)happyButtonTapped:(id)sender {
    _flag = true;
    _image = [self resizedImage:[UIImage imageNamed:@"happy"]];
}

- (IBAction)laughButtonTapped:(id)sender {
    _flag = true;
    _image = [self resizedImage:[UIImage imageNamed:@"laugh"]];
}

- (IBAction)xixiButtonTapped:(id)sender {
    _flag = true;
    _image = [self resizedImage:[UIImage imageNamed:@"xixi"]];
}

- (IBAction)sadButtonTapped:(id)sender {
    _flag = true;
    _image = [self resizedImage:[UIImage imageNamed:@"sad"]];
}

- (IBAction)angryButtonTapped:(id)sender {
    _flag = true;
    _image = [self resizedImage:[UIImage imageNamed:@"angry"]];
}

#pragma mark resize images
-(UIImage *)resizedImage:(UIImage *)originImage
{
    UIGraphicsBeginImageContext(CGSizeMake(50, 50));
    [originImage drawInRect: CGRectMake(0, 0, 50, 50)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

#pragma mark - Shake delegate
/*******************************************************************************
 * @method      become firest responder method
 * @abstract    Let the view controller respond to motion events
 * @description
 *******************************************************************************/
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/*******************************************************************************
 * @method      begin method
 * @abstract
 * @description
 *******************************************************************************/
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion != UIEventSubtypeMotionShake) return;
}

/*******************************************************************************
 * @method       end method
 * @abstract
 * @description
 *******************************************************************************/
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventTypeMotion && event.type == UIEventSubtypeMotionShake) {
        NSLog(@"Motion Ended on %@", [NSDate date]);
        
        //Call screenshot method to take a screen shot
        [self ScreenShot];
        //Call clearScreen method to clear the screen, then start new one
        [self clearScreen];
        
    }
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

/*******************************************************************************
 * @method       cancell method
 * @abstract
 * @description
 *******************************************************************************/
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {}

@end
