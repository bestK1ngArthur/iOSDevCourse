//
//  BADViewController.h
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 03/12/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BADAccessToken;

typedef void(^BADLoginCompletionBlock)(BADAccessToken *token);

@interface BADLoginViewController : UIViewController

- (instancetype) initWithCompletionBlock:(BADLoginCompletionBlock) completionBlock;

@end
