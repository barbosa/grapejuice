//
//  GrapeJuiceViewController.m
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GrapeJuiceViewController.h"

#import "UIViewController+GrapeJuice.h"

@interface GrapeJuiceViewController ()

@end

@implementation GrapeJuiceViewController

-( void )viewDidLoad
{
    [super viewDidLoad];
}

-( void )didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-( void )loadView
{
    [self loadViewFromUrl: [[NSBundle mainBundle] URLForResource: @"simple" withExtension: @"html"]];
}

@end
