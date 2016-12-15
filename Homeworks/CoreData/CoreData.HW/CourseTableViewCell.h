//
//  CourseTableViewCell.h
//  CoreData.HW
//
//  Created by Artem Belkov on 05/09/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *teachersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelView;

@property (weak, nonatomic) IBOutlet UILabel *studentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *teachersLabel;

@end
