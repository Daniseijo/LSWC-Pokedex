//
//  RaceCollectionViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "RaceCollectionViewController.h"
#import "WebViewController.h"

#import "Race.h"
#import "PokemonCVCell.h"

@interface RaceCollectionViewController ()
@property (nonatomic, strong)NSArray *racesSorted;
@end

@implementation RaceCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Ordenamos los pokemons
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"code" ascending:YES];
    if (self.type) {
        self.title = [self.type.name capitalizedString];
        self.racesSorted = [self.type.races sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    } else if (self.gen) {
        self.title = [self.gen.name capitalizedString];
        self.racesSorted = [self.gen.races sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.racesSorted count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"PokemonCell";
    
    PokemonCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    NSInteger item = indexPath.item;
    
    
    
    Race *race = self.racesSorted[item];
    
    cell.nameLabel.text = race.name;
    cell.iconImageView.image = [UIImage imageNamed:race.icon];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Pokemon Web"]) {
        
        NSIndexPath *ip = [self.collectionView indexPathForCell:sender];
        
        // Get the new view controller using [segue destinationViewController].
        WebViewController *wvc = segue.destinationViewController;
        
        
        Race *race = self.racesSorted[ip.item];
        
        NSString *str = [NSString stringWithFormat:@"http://es.pokemon.wikia.com/wiki/%@", race.name];
        
        // Pass the selected object to the new view controller.
        wvc.str = str;
        wvc.webTitle = race.name;
    }
}

@end
