//
//  GJView.h
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJStyle;
@class GJStylesheet;
@class OGElement;

@interface GJLayout : NSObject

@property (nonatomic, strong) GJStylesheet* stylesheet;

@property (nonatomic, strong) GJStyle* style;

@property (nonatomic, strong) NSArray* classes;

@property (nonatomic, strong) NSString* id;

@end
