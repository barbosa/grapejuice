//
//  GrapeJuiceViewController.m
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GrapeJuiceViewController.h"

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
    OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:[[NSBundle mainBundle] URLForResource: @"simple" withExtension: @"html"]];
    
    UIWindow* window = [UIApplication sharedApplication].windows[0];
    self.view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, window.frame.size.width, window.frame.size.height )];
    
    OGElement* body = [data elementsWithTag: GUMBO_TAG_BODY][0];
    
    for (OGElement* element in body.children) {
        UIView* grapejuiceView = [[UIView alloc] initWithFrame: CGRectMake( 5, 5, window.frame.size.width - 10, window.frame.size.height - 10 )];
        grapejuiceView.backgroundColor = [UIColor grayColor];
        [self.view addSubview: grapejuiceView];
        grapejuiceView.layer.borderColor = [UIColor redColor].CGColor;
        grapejuiceView.layer.borderWidth = 1.0f;
    }
}

@end
