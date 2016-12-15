//
//  StudentTableViewCell.m
//  CoreData.HW
//
//  Created by Artem Belkov on 20/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "StudentTableViewCell.h"

@implementation StudentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor =  [UIColor colorWithRed: 179.f / 255.f
                                                      green: 220.f / 255.f
                                                       blue: 255.f / 255.f
                                                      alpha: 1.f ];
    self.selectedBackgroundView = backgroundView;
    
    if (highlighted) {
        
        self.fullNameLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                       green:  68.f / 255.f
                                                        blue: 111.f / 255.f
                                                       alpha: 1.f ];
        self.addressLabel.textColor = [UIColor colorWithRed:  38.f / 255.f
                                                      green:  68.f / 255.f
                                                       blue: 111.f / 255.f
                                                      alpha: 1.f ];
        
    } else {
            
        self.fullNameLabel.textColor = [UIColor whiteColor];
        self.addressLabel.textColor = [UIColor colorWithRed: 179.f / 255.f
                                                      green: 220.f / 255.f
                                                       blue: 255.f / 255.f
                                                      alpha: 1.f ];
        
        
    }
    
}


@end
