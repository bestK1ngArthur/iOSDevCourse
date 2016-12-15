//
//  UniversityTableViewCell.h
//  CoreData.HW
//
//  Created by Artem Belkov on 12/09/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coursesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *teachersCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *coursesLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *teachersLabel;

@end
