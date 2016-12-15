//
//  BADPostCell.h
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 05/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;

+ (CGFloat)heightForText:(NSString *)text;

@end
