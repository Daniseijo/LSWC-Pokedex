//
//  EditPokemonTableViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 20/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "EditPokemonTableViewController.h"

#import "PokedexModel.h"
#import "AutocompleteTableView.h"

@interface EditPokemonTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet PokedexModel *pokedexModel;
@property (weak, nonatomic) IBOutlet AutocompleteTableView *autocompleteTableView;


@end

@implementation EditPokemonTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray*)autocompleteRace {
    if (!_autocompleteRace)
        _autocompleteRace = [[NSMutableArray alloc] init];
    return _autocompleteRace;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Preparamos la tabla predictiva
    self.raceTextField.delegate = self;
    
    self.autocompleteTableView.eptvc = self;
    self.autocompleteTableView.pokedexModel = self.pokedexModel;
    self.autocompleteTableView.dataSource = self.autocompleteTableView;
    self.autocompleteTableView.delegate = self.autocompleteTableView;
    self.autocompleteTableView.scrollEnabled = YES;
    
    // Inicializamos los valores del Pokemon
    self.nameTextField.text = self.pokemon.name;
    self.raceTextField.text = self.pokemon.race.name;
    
    [self.nameTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.autocompleteRace removeAllObjects];
    for(Race *curRace in self.pokedexModel.races) {
        NSString *curString = [curRace.name lowercaseString];
        NSRange substringRange = [curString rangeOfString:[substring lowercaseString]];
        if (substringRange.location == 0) {
            [self.autocompleteRace addObject:curRace];
        }
    }
    [self.autocompleteTableView reloadData];
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self.nameTextField becomeFirstResponder];
            break;
        case 1:
            [self.raceTextField becomeFirstResponder];
            break;
        default:
            break;
    }
}

- (IBAction)returnPressed:(UITextField *)sender {
    if (sender == self.nameTextField) {
        [self.raceTextField becomeFirstResponder];
    }
}

#pragma mark UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    self.lengthTextField = newLength;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.autocompleteRace == 0)
        return [self.pokedexModel.races count];
    return [self.autocompleteRace count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Autocomplete Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Race *race;
    if (self.autocompleteRace == 0) {
        race = self.pokedexModel.races[indexPath.row];
        cell.textLabel.text = race.name;
        cell.imageView.image = [UIImage imageNamed:race.icon];
    } else {
        race = self.autocompleteRace[indexPath.row];
        cell.textLabel.text = race.name;
        cell.imageView.image = [UIImage imageNamed:race.icon];
    }
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Save Pokemon"]) {
        Race *raceSave = [self.pokedexModel searchRaceWithName:self.raceTextField.text];
        self.pokemon.name = [self.nameTextField.text capitalizedString];
        self.pokemon.race = raceSave;
    } else if ([segue.identifier isEqualToString:@"Cancel Pokemon"]) {
        
    }
}

@end
