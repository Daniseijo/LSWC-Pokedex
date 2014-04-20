//
//  EditPokemonTableViewController.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 20/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "Pokedex.h"

@interface EditPokemonTableViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, weak) Pokemon* pokemon;
@property (nonatomic) NSUInteger lengthTextField;
@property (nonatomic, strong) NSMutableArray* autocompleteRace;
@property (nonatomic, weak) Pokedex *pokedex;

@property (weak, nonatomic) IBOutlet UITextField *raceTextField;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end
