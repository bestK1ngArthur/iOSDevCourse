//
//  Coder.h
//  DataTypesHW
//
//  Created by Artem Belkov on 18/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SkillJunior,
    SkillMiddle,
    SkillSenior
}Skill;

typedef enum {
    GenderMale,
    GenderFemale
}Gender;

@interface Coder : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) Gender gender;

@property (assign, nonatomic) Skill skill;

@end
