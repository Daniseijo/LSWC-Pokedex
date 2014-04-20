//
//  EditPokemonTableViewController.h
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 20/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface EditPokemonTableViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, weak) Pokemon* pokemon;
@property (weak, nonatomic) IBOutlet UITextField *raceLabel;
@end
