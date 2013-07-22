//
//  MemoriesTableViewController.m
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.

//***************ABOUT this class***********************
//This class is a table view class to show all the notes
//******************************************************
#import "MemoriesTableViewController.h"
#import "MemoriesDetailViewController.h"
#import "NoteCustomCell.h"

@interface MemoriesTableViewController ()

@property (nonatomic, strong) NSMutableArray *theMemoryNotes;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSMutableArray *names;
//@property (nonatomic, strong) NSMutableArray *theImages;


@end

@implementation MemoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults* imageNames = [NSUserDefaults standardUserDefaults];
    if ([imageNames arrayForKey:@"Names"] != NULL){
        self.names = [imageNames objectForKey:@"Names"];
        NSLog(@"IN TableView: ViewDidLoad // names array is : !!!!: %@",self.names);
    }
    
    [self memoryNotes];
//    [self getImage];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults* imageNames = [NSUserDefaults standardUserDefaults];
    if ([imageNames arrayForKey:@"Names"] != NULL){
        self.names = [imageNames objectForKey:@"Names"];
        NSLog(@"IN TableView: ViewWillAppear // names array is : !!!!: %@",self.names);
    }
    [self memoryNotes];
//    [self getImage];
}

/*******************************************************************************
 * @method      method
 * @abstract
 * @description get the data pass from other controller 
 *              that are stored in NSUserDefaults
 *******************************************************************************/
- (void) memoryNotes
{
        // Get the stored tweet in viewDidLoad
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _theMemoryNotes = [defaults objectForKey:@"NewMemoryNote"];
        NSLog(@"We've get the adridgeMemoryNote: %@",_theMemoryNotes);
        
        // Reload the the UITableViewController's tableView
        [self.tableView reloadData];
    
}

- (void)getImage:(int)index {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *theImageName = [self.names objectAtIndex:index];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:theImageName];
    self.img = [UIImage imageWithContentsOfFile:getImagePath];
    
//    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
//    UIImage *image = [UIImage imageWithData:pngData];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
//    self.img = [UIImage imageWithContentsOfFile:getImagePath];
    
//    self.theImages = [[NSMutableArray alloc] init];
//    [self.theImages addObject:self.img];
//    NSLog(@"the images %@",self.theMemoryNotes);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.theMemoryNotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemoryCell";
    NoteCustomCell *memoryCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
        forIndexPath:indexPath];
 
    
    // Configure the cell...
    memoryCell.showContent.text = [self.theMemoryNotes objectAtIndex:indexPath.row][@"Content"];
    memoryCell.showDate .text = [self.theMemoryNotes objectAtIndex:indexPath.row][@"Date"];
    int index = indexPath.row;
    [self getImage:index];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *theImageName = [self.names objectAtIndex:indexPath.row];
//    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:theImageName];
//    self.img = [UIImage imageWithContentsOfFile:getImagePath];
    
    
    memoryCell.showImage.image = self.img;
    
    return memoryCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


# pragma mark - Segue
/*******************************************************************************
 * @method          prepareForSegue:sender
 * @abstract        Call before the segue
 * @description     Pass the animal data
 ******************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"tapped the 'add button' to add a new memory note");
    NSLog(@"prepare For MemoriesDetailSegue...");
    
    if ([[segue identifier] isEqualToString:@"MemoriesDetailSegue"]) {
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        NSDictionary *note = [self.theMemoryNotes objectAtIndex:indexpath.row];
         
        MemoriesDetailViewController *mdvc= [segue destinationViewController];
        mdvc.currentMemoryNote = note;
        
        
        [self getImage:indexpath.row];
        mdvc.getTheImage = self.img;
        NSLog(@"mdvc get the image is : %@",mdvc.getTheImage);
        
        NSLog(@"the currentMemoryNote is : %@",note);
    }
    
}


@end
