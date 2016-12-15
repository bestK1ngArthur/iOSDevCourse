//
//  ViewController.h
//  IBOutletsHW
//
//  Created by Artem Belkov on 29/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *chessBoard;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blackCells;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *whiteCells;


@end

