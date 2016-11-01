//
//  DGAlbumsViewModel.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface DGAlbumsViewModel : NSObject

@property (nonatomic) NSArray* albumsArray;

-(void) updateAlbums;

@end
