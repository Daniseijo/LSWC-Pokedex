//
//  WebViewController.m
//  Pokedex
//
//  Created by Daniel Sánchez Seijo on 03/04/14.
//  Copyright (c) 2014 g102 DIT UPM. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURL *url;
@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.webTitle;
    
    self.str = [self.str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.url = [NSURL URLWithString:self.str];
    NSURLRequest *req = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)share:(UIBarButtonItem *)sender {
    
    NSArray *objectsToShare = @[self.url];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    // Presentando el controlador
    [self presentViewController:controller animated:YES completion:nil];
}

@end
