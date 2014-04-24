//
//  AutocompleteTableView.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 20/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokedexModel.h"

#import "EditPokemonTableViewController.h"

@interface AutocompleteTableView : UITableView <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, weak) EditPokemonTableViewController *eptvc;
@property (nonatomic, weak) PokedexModel *pokedexModel;
@end
