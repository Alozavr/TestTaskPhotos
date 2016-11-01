//
//  DGAlbumsViewModel.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGAlbumsViewModel.h"
#import "PHAPI.h"

@implementation DGAlbumsViewModel

-(instancetype)init{
    self = [super init];
    _albumsArray = [NSArray array];
    return self;
}

-(void) updateAlbums
{
    [PHAPI getAlbumsInfoWithCompletitionBlock:^(NSArray *infos) {
        [[self mutableArrayValueForKey:@"albumsArray"] setArray:infos];
    }];
}

@end
