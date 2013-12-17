//
//  CallAlertButton.m
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "CallAlertButton.h"

@implementation CallAlertButton

-( id )initWithFrame:( CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [mappedButton addTarget: self action: @selector( onClick: ) forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

-( void )onClick:( id )sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle: @"Juice Maker"
                                                    message: @"Juice is good for your health!"
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
