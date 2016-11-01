//
//  PHAPI.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "PHAPI.h"

@implementation PHAPI

+(id) sharedInstance
{
    static PHAPI *api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[PHAPI alloc] init];
    });
    return api; //may be will be needed for future use
}

+(void) getAlbumsInfoWithCompletitionBlock:(void (^)(NSArray *infos)) completition
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        //options.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
        
        PHFetchResult *allAlbumsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                  subtype:PHAssetCollectionSubtypeAny options:options];
        NSMutableArray* albums = [NSMutableArray array];
        [allAlbumsResult enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
            PHFetchOptions *onlyImagesOptions = [[PHFetchOptions alloc] init];
            onlyImagesOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
            onlyImagesOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:onlyImagesOptions];
            
            NSString* name = collection.localizedTitle ? collection.localizedTitle : @"No name";
            id lastImage;
            if (result.count) {
                lastImage = [PHAPI getPhotoFromAsset:result.lastObject size:CGSizeMake(80, 80) isLowQuality:YES];
            }
            else
                lastImage = [NSNull null];
            
            NSDictionary* album = [NSDictionary dictionaryWithObjects:@[name,
                                                                        [NSString stringWithFormat:@"%lu", result.count],
                                                                        lastImage,
                                                                        collection.localIdentifier]
                                                              forKeys:@[@"name", @"count", @"image", @"id"]];
            
            [albums addObject:album];
        }];
        //        _albumsArray = [NSArray array];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completition) completition(albums);
        });
    });
}

+(UIImage*) getPhotoFromAsset: (PHAsset*) asset size:(CGSize) targetSize isLowQuality: (bool) lowQuality
{
    PHImageRequestOptions* requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = lowQuality ? PHImageRequestOptionsResizeModeFast : PHImageRequestOptionsResizeModeNone;
    requestOptions.deliveryMode = lowQuality ? PHImageRequestOptionsDeliveryModeFastFormat : PHImageRequestOptionsDeliveryModeHighQualityFormat;
    requestOptions.synchronous = true;
    
    PHImageManager *manager = [PHImageManager defaultManager];
    __block UIImage *image;
    
    if (targetSize.height == 0 && targetSize.width == 0)
        targetSize = PHImageManagerMaximumSize;
    
    [manager requestImageForAsset:asset targetSize:targetSize contentMode: lowQuality ? PHImageContentModeAspectFit : PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result? result : NULL;
    }];
    
    return image;
}

+(void) getPhotosForAlbum:(NSString*)albumId andCompletitionBlock:(void(^)(NSArray *photos)) completition
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[albumId] options:nil];
        PHAssetCollection *collection = userAlbums.firstObject;
        
        PHFetchOptions *onlyImagesOptions = [[PHFetchOptions alloc] init];
        onlyImagesOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
        onlyImagesOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:onlyImagesOptions];
        
        NSMutableArray *photos = [NSMutableArray array];
        [result enumerateObjectsUsingBlock:^(PHAsset* asset, NSUInteger idx, BOOL *stop) {
            UIImage* img = [PHAPI getPhotoFromAsset:asset size:CGSizeMake(80, 80) isLowQuality:YES];
            
            NSDictionary *photo = [NSDictionary dictionaryWithObjects:@[img ? img : [NSNull null], asset.localIdentifier] forKeys:@[@"image", @"id"]];
            [photos addObject:photo];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completition) completition(photos);
        });
    });
}
//TODO: bad idea, should load it with id;
+(void) loadPhotoWithIndex:(NSInteger) index albumId:(NSString*) albumId andCompletitionBlock:(void(^)(UIImage *photo, NSInteger newIndex)) completition
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSInteger newIndex = index;
        PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[albumId] options:nil];
        PHAssetCollection *collection = userAlbums.firstObject;
        
        PHFetchOptions *onlyImagesOptions = [[PHFetchOptions alloc] init];
        onlyImagesOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
        onlyImagesOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:onlyImagesOptions];
        if (newIndex < 0) {
            newIndex = 0;
        }
        else if (newIndex >= result.count)
            newIndex = result.count - 1;
        
        UIImage* img = [PHAPI getPhotoFromAsset:[result objectAtIndex:newIndex] size:CGSizeZero isLowQuality:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completition) completition(img, newIndex);
        });
    });

}

@end
