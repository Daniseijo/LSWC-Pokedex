//
//  PokemonSearchTableViewController.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 24/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type.h"
#import "Generation.h"

@interface PokemonSearchViewController : UIViewController
@property (nonatomic, strong) Type *type;
@property (nonatomic, strong) Generation *gen;
@end
