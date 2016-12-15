//
//  UniversityTableViewCell.m
//  CoreData.HW
//
//  Created by Artem Belkov on 12/09/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "UniversityTableViewCell.h"

@implementation UniversityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor =  [UIColor colorWithRed: 179.f / 255.f
                                                      green: 220.f / 255.f
                                                       blue: 255.f / 255.f
                                                      alpha: 1.f ];
    self.selectedBackgroundView = backgroundView;
    
    if (selected) {
        
        self.nameLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                   green:  68.f / 255.f
                                                    blue: 111.f / 255.f
                                                   alpha: 1.f ];
        self.studentsCountLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                            green:  68.f / 255.f
                                                             blue: 111.f / 255.f
                                                            alpha: 1.f ];
        self.teachersCountLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                            green:  68.f / 255.f
                                                             blue: 111.f / 255.f
                                                            alpha: 1.f ];
        
    } else {
        
        self.nameLabel.textColor = [UIColor whiteColor];
        self.studentsCountLabel.textColor = [UIColor whiteColor];
        self.teachersCountLabel.textColor = [UIColor whiteColor];
        
    }
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        
        self.nameLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                   green:  68.f / 255.f
                                                    blue: 111.f / 255.f
                                                   alpha: 1.f ];
        self.studentsCountLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                            green:  68.f / 255.f
                                                             blue: 111.f / 255.f
                                                            alpha: 1.f ];
        self.teachersCountLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                            green:  68.f / 255.f
                                                             blue: 111.f / 255.f
                                                            alpha: 1.f ];
        self.coursesCountLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                         green:  68.f / 255.f
                                                          blue: 111.f / 255.f
                                                         alpha: 1.f ];
        self.coursesLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                 green:  68.f / 255.f
                                                  blue: 111.f / 255.f
                                                 alpha: 1.f ];
        self.studentsLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                       green:  68.f / 255.f
                                                        blue: 111.f / 255.f
                                                       alpha: 1.f ];
        self.teachersLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                       green:  68.f / 255.f
                                                        blue: 111.f / 255.f
                                                       alpha: 1.f ];
        
    } else {
        
        self.nameLabel.textColor = [UIColor whiteColor];
        self.studentsCountLabel.textColor = [UIColor whiteColor];
        self.teachersCountLabel.textColor = [UIColor whiteColor];
        self.coursesCountLabel.textColor = [UIColor whiteColor];
        
        self.coursesLabel.textColor = [UIColor colorWithRed: 179.f / 255.f
                                                 green: 220.f / 255.f
                                                  blue: 255.f / 255.f
                                                 alpha: 1.f ];
        self.studentsLabel.textColor = [UIColor colorWithRed: 179.f / 255.f
                                                       green: 220.f / 255.f
                                                        blue: 255.f / 255.f
                                                       alpha: 1.f ];
        self.teachersLabel.textColor = [UIColor colorWithRed: 179.f / 255.f
                                                       green: 220.f / 255.f
                                                        blue: 255.f / 255.f
                                                       alpha: 1.f ];
        
    }
    
}

@end
