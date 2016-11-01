//
//  PHAPI.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface PHAPI : NSObject

+(id) sharedInstance;
+(UIImage*) getPhotoFromAsset: (PHAsset*) asset size:(CGSize) targetSize isLowQuality: (bool) lowQuality;
+(void) getAlbumsInfoWithCompletitionBlock:(void (^)(NSArray *infos)) completition;
+(void) getPhotosForAlbum:(NSString*)albumId andCompletitionBlock:(void(^)(NSArray *photos)) completition;
+(void) loadPhotoWithIndex:(NSInteger) index albumId:(NSString*) albumId andCompletitionBlock:(void(^)(UIImage *photo, NSInteger newIndex)) completition;

@end
