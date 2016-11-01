//
//  DGPhotoPage.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGPhotoPageViewModel.h"

@interface DGPhotoPage : UIViewController

@property (nonatomic) NSInteger index;
@property (nonatomic) NSString* albumId;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) DGPhotoPageViewModel* viewModel;

@end
