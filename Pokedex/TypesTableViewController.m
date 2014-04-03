//
//  TypesTableViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "TypesTableViewController.h"
#import "RaceCollectionViewController.h"
#import "WebViewController.h"

#import "PokedexModel.h"
#import "Race.h"
#import "Type.h"

@interface TypesTableViewController ()
@property (strong, nonatomic) IBOutlet PokedexModel *pokedexModel;
@end

@implementation TypesTableViewController

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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.pokedexModel.types count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Type Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Type* type = self.pokedexModel.types[indexPath.row];
    
    // Rellenar la celda
    cell.textLabel.text = [type.name capitalizedString];
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Races"]) {
        
        // Get the new view controller using [segue destinationViewController].
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        RaceCollectionViewController *rcvc = segue.destinationViewController;
        
        // Pass the selected object to the new view controller.
        rcvc.type = self.pokedexModel.types[ip.item];
    }
    
    if ([segue.identifier isEqualToString:@"Show Type Web"]) {
        
        // Get the new view controller using [segue destinationViewController].
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        WebViewController *wvc = segue.destinationViewController;
        
        Type *type = self.pokedexModel.types[ip.item];
        
        NSString *str = [NSString stringWithFormat:@"http://es.pokemon.wikia.com/wiki/Tipo_%@", type.name];
        
        // Pass the selected object to the new view controller.
        wvc.str = str;
        wvc.webTitle = [type.name capitalizedString];
    }
}

@end
