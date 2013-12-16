//
//  UIViewController+GrapeJuice.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "UIViewController+GrapeJuice.h"

#import <ObjectiveGumbo/ObjectiveGumbo.h>

@implementation UIViewController( GrapeJuice )

-( void )loadViewFromUrl:( NSURL* )url
{
    OGNode * data = [ObjectiveGumbo parseDocumentWithUrl: url];
    NSArray* bodyElements = [data elementsWithTag: GUMBO_TAG_BODY];
    if( bodyElements.count <= 0 )
        return;
    
    UIWindow* window = [UIApplication sharedApplication].windows[0];
    self.view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, window.frame.size.width, window.frame.size.height )];
    
    OGElement* body = bodyElements[0];
    
    for (OGElement* element in body.children) {
        
        if (![element isKindOfClass: [OGText class]])
        {
            UIView* grapejuiceView = [[UIView alloc] initWithFrame: CGRectMake( 5, 5, window.frame.size.width - 10, window.frame.size.height - 10 )];
            grapejuiceView.backgroundColor = [UIColor grayColor];
            [self.view addSubview: grapejuiceView];
            grapejuiceView.layer.borderColor = [UIColor redColor].CGColor;
            grapejuiceView.layer.borderWidth = 1.0f;
        }
    }
}

@end
