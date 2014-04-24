//
//  AutocompleteTableView.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 20/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "AutocompleteTableView.h"

#import "Race.h"

@implementation AutocompleteTableView

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.eptvc.lengthTextField == 0)
        return [self.pokedexModel.races count];
    return [self.eptvc.autocompleteRace count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Autocomplete Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Race *race;
    if (self.eptvc.lengthTextField == 0) {
        race = self.pokedexModel.races[indexPath.row];
        cell.textLabel.text = race.name;
        cell.imageView.image = [UIImage imageNamed:race.icon];
    } else {
        race = self.eptvc.autocompleteRace[indexPath.row];
        cell.textLabel.text = race.name;
        cell.imageView.image = [UIImage imageNamed:race.icon];
    }
    return cell;
}

#pragma mark UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if ([self.eptvc.raceTextField.text length] != 0
        && newLength != 0
        && [self.eptvc.autocompleteRace count] != 0) {
        [self.eptvc.saveButton setEnabled:YES];
    } else {
        [self.eptvc.saveButton setEnabled:NO];
    }
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.eptvc.raceTextField.text = selectedCell.textLabel.text;
    [self.eptvc.raceTextField reloadInputViews];
    [self.eptvc.autocompleteRace removeAllObjects];
    Race *finalRace = [self.pokedexModel searchRaceWithName:selectedCell.textLabel.text];
    if (finalRace) {
        [self.eptvc.autocompleteRace addObject:finalRace];
        self.eptvc.lengthTextField = [selectedCell.textLabel.text length];
    }
    [self reloadData];
}

@end
