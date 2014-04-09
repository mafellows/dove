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

#define kCellIdentifier @"Cell"

@interface PhotoViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *images;

@end

@implementation PhotoViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"board"]; 
        self.images = @[ [UIImage imageNamed:@"dove-beach"],
                         [UIImage imageNamed:@"dove-family"],
                         [UIImage imageNamed:@"dove-man"],
                         [UIImage imageNamed:@"dove-friend"] ];
        
        self.navigationItem.title = @"Dove's Pin Board"; 
    }
    
    return self;
}

- (void)loadView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.backgroundColor = [UIColor whiteColor]; // FIXME: change color
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
                                           caption:@"Hello World"];
    
    cell.imageView.image = item.image;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        
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
