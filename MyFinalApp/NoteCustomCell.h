//
//  NoteCustomCell.h
//  MyFinalApp
//
//  Created by yueling zhang on 3/7/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *showContent;
@property (weak, nonatomic) IBOutlet UILabel *showDate;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@end
