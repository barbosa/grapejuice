//
//  GJImgView.m
//  GrapeJuice
//
//  Created by Gustavo Barbosa on 2/5/14.
//  Copyright (c) 2014 Globo.com. All rights reserved.
//

#import "GJImgView.h"

// grapejuice
#import "UIView+HtmlLayout.h"
#import "GJLayout.h"
#import "GJStyle.h"
#import "GJStylesheet.h"

@interface GJImgView ()
@property ( nonatomic ) CGSize computedSize;
@end

@implementation GJImgView

-( void )consumesChildHtmlNode:( OGElement* )element
{
    NSString* src = element.attributes[@"src"];
    NSURL* imageURL = [[NSBundle mainBundle] URLForResource:[src stringByDeletingPathExtension]
                                              withExtension:[src pathExtension]];
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    
    CGSize newSize = self.image.size;
    NSString *forcedWidth = element.attributes[@"width"];
    if (forcedWidth)
        newSize.width = [forcedWidth intValue];
    NSString *forcedHeight = element.attributes[@"height"];
    if (forcedHeight)
        newSize.height = [forcedHeight intValue];
    _computedSize = newSize;
}

-( void )addSubview:( UIView* )view
{
    // Cannot add subviews to images, so we do nothing here
}

-( void )layoutSubviews
{
    GJStyle* style = [self.layout.stylesheet computedStyleForTag: self.layout.tag
                                                         classes: self.layout.classes];
    
    CGSize imageSize = _computedSize;
    imageSize.width += style.paddingLeft + style.paddingRight;
    imageSize.height += style.paddingTop + style.paddingBottom;
    
    CGRect myFrame = self.frame;
    myFrame.size = imageSize;
    self.frame = myFrame;
}

@end
