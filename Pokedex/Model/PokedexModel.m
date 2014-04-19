//
//  PokedexModel.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "PokedexModel.h"

#import "Race.h"
#import "Type.h"
#import "Generation.h"

@implementation PokedexModel
-(instancetype) init {
    if (self = [super init]) {
        // Carga lista de propiedades
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pokemons" ofType:@"plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary *allNames = [plist valueForKey:@"nombres"];
        NSDictionary *allIcons = [plist valueForKey:@"iconos"];
        NSDictionary *allTypes = [plist valueForKey:@"tipos"];
        NSDictionary *allGenerations = [plist valueForKey:@"generaciones"];
        
        // Variables para calcular el futuro valor de las propiedades de esta clase
        NSMutableArray *mutRaces = [NSMutableArray array];
        NSMutableArray *mutTypes = [NSMutableArray array];
        NSMutableArray *mutGenerations = [NSMutableArray array];
        
        // Calcular el valor de la propiedad self.races
        [allNames enumerateKeysAndObjectsUsingBlock:^(NSString *raceCode,
                                                      NSString *raceName,
                                                      BOOL *stop) {
            NSNumber* code = [NSNumber numberWithInt:[raceCode intValue]];
            [mutRaces addObject:[[Race alloc] initWithCode:code name:raceName icon:allIcons[raceCode]]];
        }];
        // Calcular el valor de la propiedad self.types
        [allTypes enumerateKeysAndObjectsUsingBlock:^(NSString *typeName,
                                                      NSArray *typeRaceCodes,
                                                      BOOL *stop) {
            NSIndexSet* indexes = [mutRaces indexesOfObjectsPassingTest:^BOOL (Race *race, NSUInteger idx, BOOL *stop) {
                return [typeRaceCodes indexOfObject:race.code] != NSNotFound;
            }];
            NSArray* typeRaces = [mutRaces objectsAtIndexes:indexes];
            [mutTypes addObject:[[Type alloc] initWithName:typeName races:typeRaces]];
        }];
        
        // Calcular el valor de la propiedad self.generations
        [allGenerations enumerateKeysAndObjectsUsingBlock:^(NSString *genName,
                                                      NSArray *genRaceCodes,
                                                      BOOL *stop) {
            NSIndexSet* indexes = [mutRaces indexesOfObjectsPassingTest:^BOOL (Race *race, NSUInteger idx, BOOL *stop) {
                return [genRaceCodes indexOfObject:race.code] != NSNotFound;
            }];
            NSArray* genRaces = [mutRaces objectsAtIndexes:indexes];
            [mutGenerations addObject:[[Generation alloc] initWithName:genName races:genRaces]];
        }];
        
        // Asignar valor a las propiedades
        _races = [mutRaces sortedArrayUsingComparator:^NSComparisonResult(Race* race1, Race* race2) {
            return [race1.name compare:race2.name];
        }];
        _types = [mutTypes sortedArrayUsingComparator:^NSComparisonResult(Type* type1, Type* type2) {
            return [type1.name compare:type2.name];
        }];
        _generations = [mutGenerations sortedArrayUsingComparator:^NSComparisonResult(Generation *gen1, Generation *gen2) {
            return [gen1.name compare:gen2.name];
        }];
        
    }
    return self;
}
@end
