//
//  DGPhotoPageViewModel.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DGPhotoPageViewModel : NSObject

@property (strong, nonatomic) UIImage* photo;
@property (nonatomic) NSInteger index;

-(void) loadPhotoWithId:(NSString*) photoId;
-(void) loadPhotoWithAlbumId:(NSString*) albumId;

@end
