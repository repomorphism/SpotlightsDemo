//
//  ViewController.m
//  SpotlightsDemo
//
//  Created by Paul on 6/20/15.
//  Copyright (c) 2015 Mathemusician.net. All rights reserved.
//

#import "ViewController.h"
#import "HPLSpotlightsView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HPLSpotlightsView *spotlightsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.spotlightsView.opaque = NO;
    self.spotlightsView.backgroundFillColor = [UIColor colorWithWhite:0.0 alpha:0.5];

    [self.spotlightsView addSpotlightAtCenter:CGPointMake(160.0, 150)
                                       radius:100.0
                                   blurRadius:15.0];

    [self.spotlightsView addSpotlightAtCenter:CGPointMake(187.5, 300)
                                       radius:50
                                   blurRadius:5.0];

    [self.spotlightsView addSpotlightAtCenter:CGPointMake(207.0, 450)
                                       radius:75
                                   blurRadius:20.0];
}


@end
