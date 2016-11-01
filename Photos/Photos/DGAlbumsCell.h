//
//  AlbumsCell.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGAlbumsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *latAlbumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *photoCount;
@property (weak, nonatomic) NSString* albumId;


@end
