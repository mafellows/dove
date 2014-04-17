//
//  PhotoViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "PhotoViewController.h"
#import "DOVECollectionViewCell.h"
#import "PinItem.h"
#import "JTSImageInfo.h"
#import "JTSImageViewController.h"

#define kCellIdentifier @"Cell"

@interface PhotoViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *captions;

@end

@implementation PhotoViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"board"]; 
        self.images = @[ [UIImage imageNamed:@"dove-board-emmy"],
                         [UIImage imageNamed:@"dove-family"],
                         [UIImage imageNamed:@"dove-board-man"],
                         [UIImage imageNamed:@"dove-board-ryan"],
                         [UIImage imageNamed:@"dove-friend-beach"],
                         [UIImage imageNamed:@"dove-man"]];
        
        self.captions = @[ @"Love my friends Liv 2 and Maddie 2 :)",
                           @"Check out this new scene!",
                           @"Love of my life",
                           @"Amazing opening night with an amazing guy :)",
                           @"Let's go to the beach!",
                           @"My man :)" ];
        
        self.navigationItem.title = @"Dove's Pin Board"; 
    }
    
    return self;
}

- (void)loadView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = backgroundView;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:backgroundView.frame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[DOVECollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [backgroundView addSubview:collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DOVECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[DOVECollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, kBLScreenWidth / 2, kBLScreenWidth / 2)];
    }
    
    PinItem *item = [[PinItem alloc] initWithImage:[self.images objectAtIndex:indexPath.row]
                                           caption:[self.captions objectAtIndex:indexPath.row]];
    cell.imageView.image = item.image;
    cell.label.text = item.caption; 
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DOVECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = [self.images objectAtIndex:indexPath.row];
    imageInfo.referenceRect = cell.frame;
    imageInfo.referenceView = self.view;
    
    JTSImageViewController *imageViewController = [[JTSImageViewController alloc] initWithImageInfo:imageInfo
                                                                                               mode:JTSImageViewControllerMode_Image
                                                                                    backgroundStyle:JTSImageViewControllerBackgroundStyle_ScaledDimmedBlurred];
    [imageViewController showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition]; 
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 100.0f, 0); 
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kBLScreenWidth / 2, kBLScreenWidth / 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

@end
