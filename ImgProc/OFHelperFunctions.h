//
//  HelperFunctions.h
//  ImgProc
//
//  Created by Jamis Johnson on 2/24/12.
//  Copyright (c) 2012 University of Utah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OFHelperFunctions : NSObject
{
    
}

+ (void) printContentsOfFrame:(CGRect)rect withPrefixString:(NSString*)prefix;
+ (void) hideStatusBar;

@end
