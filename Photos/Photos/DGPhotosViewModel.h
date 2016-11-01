//
//  DGPhotosViewModel.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGPhotosViewModel : NSObject

@property (nonatomic) NSArray* photosArray;

-(void) updatePhotosInAlbum:(NSString*) albumId;

@end
