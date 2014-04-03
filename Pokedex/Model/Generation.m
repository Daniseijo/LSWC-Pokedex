//
//  Generation.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "Generation.h"

@implementation Generation

-(instancetype) initWithName:(NSString *)name races:(NSArray *)races {
    if (self = [super init]) {
        _name = name;
        _races = races;
    }
    return self;
}
@end
