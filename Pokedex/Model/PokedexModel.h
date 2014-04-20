//
//  PokedexModel.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Race.h"

@interface PokedexModel : NSObject
@property (nonatomic, strong) NSArray* races;
@property (nonatomic, strong) NSArray* types;
@property (nonatomic, strong) NSArray* generations;

- (Race*)searchRaceWithName:(NSString*)name;
@end
