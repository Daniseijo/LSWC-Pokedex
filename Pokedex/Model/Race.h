//
//  Race.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Race : NSObject

@property (nonatomic, strong) NSNumber* code;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* icon;

-(instancetype) initWithCode:(NSNumber*)code
                        name:(NSString*)name
                        icon:(NSString*)icon;

@end
