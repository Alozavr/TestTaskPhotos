//
//  DGPhotoPage.m
//  Photos
//
//  Created by Dmitry grebenshchikov on 01.11.16.
//  Copyright © 2016 Dmitry Grebenshchikov. All rights reserved.
//

#import "DGPhotoPage.h"

@interface DGPhotoPage ()

@end

@implementation DGPhotoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    


    UISwipeGestureRecognizer *swiperLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swiperLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.imageView addGestureRecognizer:swiperLeft];
    
    UISwipeGestureRecognizer *swiperRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swiperRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.imageView addGestureRecognizer:swiperRight];
    
    self.viewModel = [[DGPhotoPageViewModel alloc] init];
    self.viewModel.index = _index;
    [self.viewModel addObserver:self forKeyPath:@"photo" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self reload];
    //Layout Debug
//    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
//    self.imageView.layer.borderWidth = 2.0f;
    
}

-(void) reload
{
    [self.viewModel loadPhotoWithAlbumId:_albumId];
}

- (void) dealloc
{
    [self.viewModel removeObserver:self forKeyPath:@"photo" context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath compare:@"photo"] == NSOrderedSame) {
        [self.imageView setImage:self.viewModel.photo];
        //self.viewModel.photo = nil;
    }
}


-(void) handleSwipe:(UISwipeGestureRecognizer*) sender
{
    NSLog(@"Swiped");
    
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            self.viewModel.index--;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            self.viewModel.index++;
        default:
            break;
    }
    [self reload];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
