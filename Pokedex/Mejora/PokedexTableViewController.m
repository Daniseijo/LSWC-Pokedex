//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 19/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "PokemonViewController.h"
#import "EditPokemonTableViewController.h"

#import "Pokedex.h"
#import "Pokemon.h"

@interface PokedexTableViewController ()
@property (strong, nonatomic) IBOutlet Pokedex *pokedex;
@end

@implementation PokedexTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.pokedex.pokemons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Pokedex Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Pokemon *poke = self.pokedex.pokemons[indexPath.row];
    // Rellenar la celda
    cell.textLabel.text = [poke.name capitalizedString];
    cell.detailTextLabel.text = [poke.race.name capitalizedString];
    
    cell.imageView.image = [UIImage imageNamed:poke.race.icon];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.pokedex.pokemons removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Pokemon *pokemonToMove = [self.pokedex.pokemons objectAtIndex:fromIndexPath.row];
    [self.pokedex.pokemons removeObjectAtIndex:fromIndexPath.row];
    [self.pokedex.pokemons insertObject:pokemonToMove atIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)pokemonWasChanged:(UIStoryboardSegue*)segue {
    NSIndexPath * ip = [self.tableView indexPathForSelectedRow];
    [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:YES];
}

- (IBAction)pokemonWasCancel:(UIStoryboardSegue*)segue {
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    Race *race = [self.pokedex.pokemons objectAtIndex:ip.row];
    if ([race.name isEqualToString:@""]) {
        [self.pokedex.pokemons removeObjectAtIndex:ip.row];
        [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Showing Pokemon"]) {
        
        // Get the new view controller using [segue destinationViewController].
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        PokemonViewController *pvc = segue.destinationViewController;
        
        // Pass the selected object to the new view controller.
        pvc.pokemon = self.pokedex.pokemons[ip.item];
        pvc.pokedex = self.pokedex;
    } else if ([segue.identifier isEqualToString:@"Adding Pokemon"]) {
        EditPokemonTableViewController *eptvc = segue.destinationViewController;
        
        Pokemon *pokemon = [[Pokemon alloc] initWithName:@"" andRace:[[Race alloc] initWithCode:[NSNumber numberWithInt:0] name:@"" icon:@"000.gif"]];
        [self.pokedex.pokemons insertObject:pokemon atIndex:0];
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        eptvc.pokemon = pokemon;
        eptvc.pokedex = self.pokedex;
        
        eptvc.lengthTextField = pokemon.race.name.length;
        [eptvc searchAutocompleteEntriesWithSubstring:[pokemon.race.name lowercaseString]];
    }
}


@end
