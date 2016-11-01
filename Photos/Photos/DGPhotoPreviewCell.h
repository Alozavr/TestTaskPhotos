//
//  DGPhotoPreviewCell.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGPhotoPreviewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) NSString* photoId;

@end
