//
//  UIColorUtils.h
//  Components
//
//  Created by Daniel L. Alves on 5/16/11.
//  Copyright 2011 Jack & Towers. All rights reserved.
//

#ifndef UICOLOR_UTILS_H
#define UICOLOR_UTILS_H

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString* const COLOR_DICT_COMPONENT_KEY_RED;
FOUNDATION_EXPORT NSString* const COLOR_DICT_COMPONENT_KEY_GREEN;
FOUNDATION_EXPORT NSString* const COLOR_DICT_COMPONENT_KEY_BLUE;
FOUNDATION_EXPORT NSString* const COLOR_DICT_COMPONENT_KEY_ALPHA;


#define ARGB_TO_HEX( alpha, red, green, blue ) ( (( ( uint8_t )alpha & 0xFF ) << 24 ) \
											   | (( ( uint8_t )red   & 0xFF ) << 16 ) \
											   | (( ( uint8_t )green & 0xFF ) <<  8 ) \
											   |  ( ( uint8_t )blue  & 0xFF ))

#define RGBA_TO_HEX( red, green, blue, alpha ) ( (( ( uint8_t )red   & 0xFF ) << 24 ) \
											   | (( ( uint8_t )green & 0xFF ) << 16 ) \
											   | (( ( uint8_t )blue  & 0xFF ) <<  8 ) \
											   |  ( ( uint8_t )alpha & 0xFF ))

@interface UIColor( GLBUIColorUtils )

//+( UIColor* )colorFromDictionary:( NSDictionary* )colorDict;

+( UIColor* )colorFromRGBHex:( uint32_t )rgb;

+( UIColor* )colorFromRGBAHex:( uint32_t )rgba;
+( UIColor* )colorFromARGBHex:( uint32_t )argb;

+( UIColor* )colorWithARGBHexString:( NSString* )str;

+( UIColor* )colorWithByteRed:( uint8_t )r byteGreen:( uint8_t )g byteBlue:( uint8_t )b byteAlpha:( uint8_t )a;

-( CGFloat )red;
-( CGFloat )green;
-( CGFloat )blue;
-( CGFloat )alpha;

-( uint8_t )byteRed;
-( uint8_t )byteGreen;
-( uint8_t )byteBlue;
-( uint8_t )byteAlpha;

@end

#endif
