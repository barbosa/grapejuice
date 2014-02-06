//
//  GJImgView.h
//  GrapeJuice
//
//  Created by Gustavo Barbosa on 2/5/14.
//  Copyright (c) 2014 Globo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJLayout;

@interface GJImgView : UIImageView

@property (nonatomic, strong) GJLayout* layout;

-( void )consumesChildHtmlNode:( OGElement* )element;

@end
