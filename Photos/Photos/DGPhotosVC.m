//
//  DGPhotosVC.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGPhotosVC.h"
#import "DGPhotoPreviewCell.h"
#import "DGPhotoPage.h"

@interface DGPhotosVC ()

@end

@implementation DGPhotosVC

@synthesize albumId;

static NSString * const reuseIdentifier = @"previewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    //[self.collectionView registerClass:[DGPhotoPreviewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.allowsMultipleSelection = NO;
    self.viewModel = [[DGPhotosViewModel alloc] init];
    [self.viewModel addObserver:self forKeyPath:@"photosArray" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel updatePhotosInAlbum:albumId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [self.viewModel removeObserver:self forKeyPath:@"photosArray" context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath compare:@"photosArray"] == NSOrderedSame) {
        [self.collectionView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DGPhotoPreviewCell *cell = (DGPhotoPreviewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSDictionary *info = [self.viewModel.photosArray objectAtIndex:indexPath.row];
    [cell.imageView setImage:info[@"image"]];
    cell.photoId = info[@"id"];
    
    return cell;
}

#pragma mark Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pageView"])
    {
        DGPhotoPage* dest = (DGPhotoPage*)[segue destinationViewController];
        dest.albumId = albumId;
        dest.index = [self.collectionView indexPathsForSelectedItems].lastObject.row;
        
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
