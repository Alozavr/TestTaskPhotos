//
//  DGAlbumsVC.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGAlbumsVC.h"
#import "DGAlbumsViewModel.h"
#import "DGAlbumsCell.h"
#import "PHAPI.h"
#import "DGPhotosVC.h"

static NSString* const AlbumsCellIdentifier = @"AlbumCell";

@interface DGAlbumsVC ()

@property (nonatomic, strong) DGAlbumsViewModel* viewModel;

@end

@implementation DGAlbumsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[DGAlbumsViewModel alloc] init];
    [self.viewModel addObserver:self forKeyPath:@"albumsArray" options:NSKeyValueObservingOptionNew context:nil];
    [self reloadData];
    
}

- (void) dealloc
{
    [self.viewModel removeObserver:self forKeyPath:@"albumsArray" context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath compare:@"albumsArray"] == NSOrderedSame) {
        [self.tableView reloadData];
    }
}

-(void) reloadData
{
    [self.viewModel updateAlbums];
}

- (void)viewDidAppear:(BOOL)animated
{
    switch ([PHPhotoLibrary authorizationStatus]) {
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Access is denied" message:@"Please allow access to photo library in settings" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.albumsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGAlbumsCell *cell = [tableView dequeueReusableCellWithIdentifier:AlbumsCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *albumInfo = [self.viewModel.albumsArray objectAtIndex:indexPath.row];
    cell.albumName.text = albumInfo[@"name"];
    cell.photoCount.text = albumInfo[@"count"];
    cell.imageView.image = albumInfo[@"image"];
    cell.albumId = albumInfo[@"id"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier compare:@"photoView"] == NSOrderedSame) {
        DGPhotosVC* dest = (DGPhotosVC*) [segue destinationViewController];
        DGAlbumsCell *cell = (DGAlbumsCell*)sender;
        dest.albumId = cell.albumId;
    }
}


@end
