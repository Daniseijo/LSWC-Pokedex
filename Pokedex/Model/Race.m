//
//  Race.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "Race.h"

@implementation Race

-(instancetype) initWithCode:(NSNumber*)code
                        name:(NSString*)name
                        icon:(NSString*)icon {
    if (self = [super init]) {
        _code = code;
        _name = name;
        _icon = icon;
    }
    return self;
}

@end
