//
//  BADAccessToken.h
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 03/12/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADAccessToken : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSString *userID;

@end
