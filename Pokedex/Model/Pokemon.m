//
//  Pokemon.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 19/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype) initWithName:(NSString *)name andRace:(Race *)race {
    if (self = [super init]) {
        _name = name;
        _race = race;
    }
    return self;
}

@end
