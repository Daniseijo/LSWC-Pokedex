//
//  RaceCollectionViewController.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokedexModel.h"
#import "Type.h"

@interface RaceCollectionViewController : UICollectionViewController
@property (nonatomic, strong) Type *type;
@end
