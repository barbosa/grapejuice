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
#import "GJBodyView.h"
#import "GJDivView.h"
#import "GJLayout.h"
#import "GJSpanView.h"
#import "GJTextView.h"
#import "GJButtonView.h"
#import "GJStylesheet.h"

@implementation UIViewController( GrapeJuice )

-( void )loadViewFromUrl:( NSURL* )url
{
    OGNode * data = [ObjectiveGumbo parseDocumentWithUrl: url];
    NSArray* bodyElements = [data elementsWithTag: GUMBO_TAG_BODY];
    if( bodyElements.count <= 0 )
        return;
    
    self.view = [[UIViewController grapeJuiceClassesMap][@(GUMBO_TAG_BODY)] new];

    NSArray* stylesheetElements = [data elementsWithTag: GUMBO_TAG_LINK];

    GJStylesheet* stylesheet = nil;

    for ( OGElement* stylesheetElement in stylesheetElements )
    {
        NSString* href = stylesheetElement.attributes[@"href"];
        NSURL* url = [[NSBundle mainBundle] URLForResource: [href stringByDeletingPathExtension] withExtension: [href pathExtension]];
        if ( url )
        {
            if ( !stylesheet )
                stylesheet = [GJStylesheet stylesheetFromUrl: url];
            else
                [stylesheet addStylesheetFromUrl: url];
        }
    }

    OGElement* body = bodyElements[0];
    
    [self loadViewFromElement: body withParent: self.view stylesheet: stylesheet];
}

-( void )loadViewFromElement:( OGElement* )element withParent:( UIView* )parent stylesheet:( GJStylesheet* )stylesheet
{
    for (OGElement* child in element.children) {

        if ([child isKindOfClass: [OGText class]])
        {
            OGText* textNode = ( OGText* )child;
            NSString* actualText = [textNode.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if( actualText.length > 0 )
            {
                GJTextView* mappedView = [[GJTextView alloc] init];
                mappedView.text = actualText;
                [parent addSubview: mappedView];
                
                // OGText nodes do not have children
            }
        }
        else
        {
            Class mappedClass = nil;
            NSString *customClassName = [child.attributes objectForKey:@"data-class"];
            Class defaultClass = ([UIViewController grapeJuiceClassesMap])[@(child.tag)];
            mappedClass = defaultClass;

            if (customClassName) {
                Class customClass = NSClassFromString(customClassName);
                if (![customClass isSubclassOfClass: defaultClass])
                    [NSException raise:@"Invalid class type" format:@"Class %@ should be a subclass of %@", customClass, defaultClass];
                mappedClass = customClass;
            }
            
            if (!mappedClass)
                [NSException raise:@"Class not found" format:@"Class %@ not found", mappedClass];

            UIView* mappedView = [[mappedClass alloc] init];
            [parent addSubview: mappedView];

            if ([mappedView respondsToSelector: @selector(setLayout:)])
            {
                GJLayout* layout = [GJLayout new];
                layout.stylesheet = stylesheet;
                layout.tag = [OGUtility tagForGumboTag: child.tag];
                layout.classes = child.classes;

                [mappedView performSelector: @selector(setLayout:) withObject: layout];
            }

            if ([mappedView respondsToSelector: @selector(consumesChildHtmlNode:)])
                [mappedView performSelector:  @selector(consumesChildHtmlNode:) withObject: child];
            else
                [self loadViewFromElement: child withParent: mappedView stylesheet: stylesheet];
        }
    }
}

+( NSDictionary* )grapeJuiceClassesMap
{
    static NSDictionary* classesMap = nil;
  
    if( !classesMap )
    {
        classesMap = @{
            @(GUMBO_TAG_BODY): [GJBodyView class],
            @(GUMBO_TAG_DIV): [GJDivView class],
            @(GUMBO_TAG_SPAN): [GJSpanView class],
            @(GUMBO_TAG_BUTTON): [GJButtonView class],
        };
    }
    
    return classesMap;
}

@end




















































