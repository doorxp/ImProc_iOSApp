//
//  OFImageProcHelperFunctions.m
//  ImgProc
//
//  Created by Jamis Johnson on 2/27/12.
//  Copyright (c) 2012 University of Utah. All rights reserved.
//

#import "OFImageProcHelperFunctions.h"

@implementation OFImageProcHelperFunctions

+ (UIImage *) convertUIImageToShort:(UIImage*)image
{
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    // TODO: SCALE? e.g. image.size.width * self.scale
    int width  = image.size.width;
    int height = image.size.height;
    NSLog(@"width*height: %i", width*height);
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int x = 0; x < width; x++) {
        for(int y = 0; y < height; y++) {
            //unsigned short * rgbaPixel = (unsigned short*) &pixels[y * width + x];
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            //NSLog(@"rgbaPixel val: %hu", *rgbaPixel);
            //NSLog(@"gray value:    %i",   gray);
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef
                                                 scale:image.scale 
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}






+ (UIImage *) grayscaleImage:(UIImage*)image
{
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    // TODO: SCALE? e.g. image.size.width * self.scale
    int width  = image.size.width;
    int height = image.size.height;
    NSLog(@"width*height: %i", width*height);
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int x = 0; x < width; x++) {
        for(int y = 0; y < height; y++) {
            //unsigned short * rgbaPixel = (unsigned short*) &pixels[y * width + x];
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            //NSLog(@"rgbaPixel val: %hu", *rgbaPixel);
            //NSLog(@"gray value:    %i",   gray);
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef
                                                 scale:image.scale 
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}

@end
