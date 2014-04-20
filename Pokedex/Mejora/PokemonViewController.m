//
//  PokemonViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 19/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "PokemonViewController.h"
#import "EditPokemonTableViewController.h"

@interface PokemonViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *raceLabel;
@end

@implementation PokemonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text = self.pokemon.name;
    
    // Obtenemos de internet una foto de mejor calidad
    NSString* img = [NSString stringWithFormat:@"http://img.pokemondb.net/artwork/%@.jpg", [self.pokemon.race.name lowercaseString]];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    
    // Si se consigue, se pone, si no, se pone el icono original ya descargado
    if (data)
        self.pokemonImage.image = [UIImage imageWithData:data];
    else
        self.pokemonImage.image = [UIImage imageNamed:self.pokemon.race.icon];
    
    self.raceLabel.text = self.pokemon.race.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Editing Pokemon"]) {
        EditPokemonTableViewController *eptvc = segue.destinationViewController;
        
        eptvc.pokemon = self.pokemon;
        eptvc.pokedex = self.pokedex;
        
        eptvc.lengthTextField = self.pokemon.race.name.length;
        [eptvc searchAutocompleteEntriesWithSubstring:[self.pokemon.race.name lowercaseString]];
    }
}


@end
