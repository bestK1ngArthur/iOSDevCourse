//
//  User.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *firstNames[] = {
    
    @"Spencer", @"Roger", @"Willis", @"Rodrigo", @"Quinton",
    @"Ward", @"Phillip", @"Gerry", @"Carlton", @"James",
    @"Roosevelt", @"Lewis", @"Andrew", @"Philip", @"Eldridge",
    @"Derrick", @"Randal", @"Jackson", @"Christopher", @"Dario",
    @"Les", @"Bernardo", @"Clyde", @"Ricardo", @"Stacey",
    @"Otha", @"Desmond", @"Rashad", @"Bret", @"Barton",
    @"Freddie", @"Levi", @"Jamie", @"Grover", @"Shelby",
    @"Wendell", @"Edmond", @"Brendan", @"Sanford", @"Samuel",
    @"Waylon", @"Kirk", @"Lacy", @"Van",@"Hans",
    @"William", @"Vance", @"Tommie", @"Kurtis", @"Gregorio"
    
};

static NSString *lastNames[] = {
    
    @"Ruf", @"Raco", @"Castiglione", @"Siegle", @"Byas",
    @"Klatt", @"Hogan", @"Vanmeter", @"Harbert", @"Petties",
    @"Laffoon", @"Finch", @"Wilford", @"Scovil", @"Gourlay",
    @"Parkin", @"Havlik", @"Foti", @"Gamez", @"Brighton",
    @"Borland", @"Petrin", @"Phillippe", @"Carlo", @"Walder",
    @"Mcnerney", @"Strasser",@"Delafuente", @"Mcenaney", @"Reny",
    @"Whittenburg", @"Gammons", @"Stamey", @"Youngblood", @"Alcala",
    @"Osborne", @"Pigeon", @"Weitz", @"Waite", @"Wester",
    @"Low", @"Besecker", @"Selander", @"Wolak", @"Maricle",
    @"Fritzler", @"Wheatley", @"Rasmussen", @"Register", @"Mullinax"
    
};

static NSString *carModelNames[] = {
    @"Dodge", @"Toyota", @"BMW", @"Mersedess", @"Audi"
};

@interface User : Object

- (NSString *)fullName;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
