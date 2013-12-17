//
//  GJStylesheet.h
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GJStyle;

@interface GJStylesheet : NSObject

+( GJStylesheet* )stylesheetFromUrl:( NSURL* )url;
+( GJStylesheet* )stylesheetFromUrls:( NSArray* )urls;

-( GJStyle* )computedStyleForTag:( NSString* )tag classes:( NSArray* )classes;

-( void )addStylesheet:( NSDictionary* )dictionary;
-( void )addStylesheetFromUrl:( NSURL* )url;

@end
