//
//  DGPhotosVC.h
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGPhotosViewModel.h"

@interface DGPhotosVC : UICollectionViewController

@property (strong, nonatomic) DGPhotosViewModel* viewModel;
@property (weak, nonatomic) NSString* albumId;

@end
