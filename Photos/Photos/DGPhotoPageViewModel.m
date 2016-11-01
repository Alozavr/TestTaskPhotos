//
//  DGPhotoPageViewModel.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGPhotoPageViewModel.h"
#import "PHAPI.h"

@implementation DGPhotoPageViewModel

-(void) loadPhotoWithAlbumId:(NSString*) albumId
{
    [PHAPI loadPhotoWithIndex:self.index albumId:albumId andCompletitionBlock:^(UIImage* photo, NSInteger newIndex){
        [self setValue:photo forKey:@"photo"];
        self.index = newIndex;
    }];
}

-(void) loadPhotoWithId:(NSString*) photoId
{
    
}

@end
