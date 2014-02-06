//
//  GJImgView.m
//  GrapeJuice
//
//  Created by Gustavo Barbosa on 2/5/14.
//  Copyright (c) 2014 Globo.com. All rights reserved.
//

#import "GJImgView.h"

#import "UIImageView+AFNetworking.h"

// grapejuice
#import "UIView+HtmlLayout.h"
#import "GJLayout.h"
#import "GJStyle.h"
#import "GJStylesheet.h"

@interface GJImgView ()
@property ( nonatomic, readwrite ) CGSize computedSize;
@end

@implementation GJImgView

-( id )initWithFrame:( CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

-( id )initWithCoder:( NSCoder* )aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

-( void )consumesChildHtmlNode:( OGElement* )element
{
    NSString *forcedWidth = element.attributes[@"width"];
    _computedSize.width = forcedWidth ? [forcedWidth intValue] : .0f;
    
    NSString *forcedHeight = element.attributes[@"height"];
    _computedSize.height = forcedHeight ? [forcedHeight intValue] : .0f;
    
    NSString* src = element.attributes[@"src"];
    if ([self isRemoteResource:src]) {
        [self loadRemoteImageWithURL:[NSURL URLWithString:src]];
    } else {
        [self loadLocalImageWithURL:[[NSBundle mainBundle] URLForResource:[[src lastPathComponent] stringByDeletingPathExtension]
                                                            withExtension:[src pathExtension]]];
    }
}

-( BOOL )isRemoteResource:(NSString* )src
{
    NSURL *url = [NSURL URLWithString:src];
    return url && url.scheme && url.host;
}

-( void )loadRemoteImageWithURL:( NSURL* )url
{
    NSURLRequest* imageRequest = [NSURLRequest requestWithURL:url];
    
    __block typeof(self) weakSelf = self;
    [self setImageWithURLRequest: imageRequest
                placeholderImage: nil
                         success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                             weakSelf.image = image;
                             [weakSelf setNeedsLayout];
                         } failure: nil];
}

-( void )loadLocalImageWithURL:( NSURL *)url
{
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

-( void )addSubview:( UIView* )view
{
    // Cannot add subviews to images, so we do nothing here
}

-( void )layoutSubviews
{
    GJStyle* style = [self.layout.stylesheet computedStyleForTag: self.layout.tag
                                                         classes: self.layout.classes];
    
    CGFloat width = _computedSize.width > 0 ? _computedSize.width : self.image.size.width;
    CGFloat height = _computedSize.height > 0 ? _computedSize.height: self.image.size.height;
    
    CGSize imageSize = CGSizeMake(width, height);
    imageSize.width += style.paddingLeft + style.paddingRight;
    imageSize.height += style.paddingTop + style.paddingBottom;
    
    CGRect myFrame = self.frame;
    myFrame.size = imageSize;
    self.frame = myFrame;
    
    NSLog(@"-----> %@", NSStringFromCGRect(myFrame));
}

@end
