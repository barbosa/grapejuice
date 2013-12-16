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

-( void )loadViewsFromHTML:( NSString* )html
{
    OGNode* data = [ObjectiveGumbo parseDocumentWithString: html];
    
    NSArray* bodyElements = [data elementsWithTag: GUMBO_TAG_BODY];
    if( bodyElements.count <= 0 )
        return;
    
    OGElement* body = bodyElements[0];
    
    for( OGElement* div in [body elementsWithTag: GUMBO_TAG_DIV] )
    {
        NSLog(@"%@", div.attributes[@"class"]);
    }
}

@end
