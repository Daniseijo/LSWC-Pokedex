//
//  Pokemon.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 19/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Race.h"

@interface Pokemon : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) Race* race;

- (instancetype) initWithName:(NSString*)name
                      andRace:(Race*)race;
@end
