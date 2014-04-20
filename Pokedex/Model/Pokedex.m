//
//  Pokedex.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 19/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "Pokedex.h"
#import "Pokemon.h"
#import "PokedexModel.h"

@implementation Pokedex

- (NSMutableArray*) pokemons {
    if (!_pokemons) {
        _pokemons = [NSMutableArray array];
        
        PokedexModel* pokedex = [[PokedexModel alloc] init];
        
        [_pokemons addObjectsFromArray:
         @[[[Pokemon alloc] initWithName:@"Pistacho"
                                 andRace:pokedex.races[25]],
           [[Pokemon alloc] initWithName:@"Miutu"
                                 andRace:pokedex.races[150]],
           [[Pokemon alloc] initWithName:@"Dolly"
                                 andRace:pokedex.races[179]]
           ]];
    }
    return _pokemons;
}

@end
