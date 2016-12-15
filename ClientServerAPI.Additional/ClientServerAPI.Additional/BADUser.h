//
//  ASUser.h
//  APITest
//
//  Created by Oleksii Skutarenko on 20.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "BADServerObject.h"

@interface BADUser : BADServerObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;

@end
