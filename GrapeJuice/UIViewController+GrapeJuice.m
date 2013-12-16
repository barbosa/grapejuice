//
//  UIViewController+GrapeJuice.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "UIViewController+GrapeJuice.h"

// objective gumbo
#import <ObjectiveGumbo/ObjectiveGumbo.h>

// grapejuice
#import "GPDivView.h"
#import "GPSpanView.h"

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
    
    [self loadViewFromElement: body withParent: self.view];
}

-( void )loadViewFromElement:( OGElement* )element withParent:( UIView* )parent
{
    for (OGElement* child in element.children) {
        
        if (![child isKindOfClass: [OGText class]])
        {
            Class mappedClass = ([UIViewController grapeJuiceClassesMap])[@(child.tag)];
            
            NSLog( @"class is %@", mappedClass );
            
            UIView* mappedView = [[mappedClass alloc] init];
            [parent addSubview: mappedView];
            
            [self loadViewFromElement: child withParent: mappedView];
        }
    }
}

+( NSDictionary* )grapeJuiceClassesMap
{
    static NSDictionary* classesMap = nil;
  
    if( !classesMap )
    {
        classesMap = @{
            @(GUMBO_TAG_DIV): [GPDivView class],
            @(GUMBO_TAG_SPAN): [GPSpanView class]
        };
    }
    
    return classesMap;
}

@end




















































