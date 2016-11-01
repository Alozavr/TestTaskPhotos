//
//  DGPhotosViewModel.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGPhotosViewModel.h"
#import "PHAPI.h"

@implementation DGPhotosViewModel

-(instancetype)init{
    self = [super init];
    _photosArray = [NSArray array];
    return self;
}

-(void) updatePhotosInAlbum:(NSString*) albumId
{
    [PHAPI getPhotosForAlbum:albumId andCompletitionBlock:^(NSArray* photos){
        [[self mutableArrayValueForKey:@"photosArray"] setArray:photos];
    }];
}

@end
