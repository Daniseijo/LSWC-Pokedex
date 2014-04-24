//
//  PokemonSearchTableViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 24/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "PokemonSearchViewController.h"
#import "RaceCollectionViewController.h"

@interface PokemonSearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) RaceCollectionViewController *rcvc;
@property (nonatomic, strong) Type *typeTemp;
@property (nonatomic, strong) Generation *genTemp;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation PokemonSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.typeTemp = self.type;
    self.genTemp = self.gen;
    
    self.rcvc = (RaceCollectionViewController *)self.childViewControllers[0];
    self.rcvc.type = self.typeTemp;
    self.rcvc.gen = self.genTemp;
    
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *substring = [NSString stringWithString:searchBar.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:text];
    [self updateFilteredTypesOrGenWithText:substring];
    self.rcvc = (RaceCollectionViewController *)self.childViewControllers[0];
    self.rcvc.type = self.typeTemp;
    self.rcvc.gen = self.genTemp;
    return YES;
}

- (void)updateFilteredTypesOrGenWithText:(NSString *)text {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", text];
    if (self.type)
        self.typeTemp = [[Type alloc] initWithName:self.type.name
                                             races:[self.type.races filteredArrayUsingPredicate:pred]];
    else
        self.genTemp = [[Generation alloc] initWithName:self.gen.name
                                                  races:[self.gen.races filteredArrayUsingPredicate:pred]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Collection"]) {
        self.rcvc = segue.destinationViewController;
        self.rcvc.type = self.type;
        self.rcvc.gen = self.gen;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
