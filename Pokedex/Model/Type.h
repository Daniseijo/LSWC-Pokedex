//
//  Type.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type : NSObject

@property (nonatomic, strong)NSString* name;
@property (nonatomic, strong)NSArray* races;

- (instancetype) initWithName:(NSString*)name
                        races:(NSArray*)races;
@end
