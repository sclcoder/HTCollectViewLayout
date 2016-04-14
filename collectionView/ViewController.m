//
//  ViewController.m
//  collectionView
//
//  Created by sunchunlei on 15/8/12.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "ViewController.h"
#import "HTCollectionViewCell.h"
#import "HTCollectionViewCellX.h"
#import "HTLineLayout.h"
#import "HTCircle.h"
#import "HTStack.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) HTLineLayout *lineLayout;

@property (nonatomic, strong) HTStack *stackLayout;

@property (nonatomic, strong) HTCircle *circleLayout;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@end

static NSString *const ID = @"image";
static NSString *const IDX = @"text";

@implementation ViewController

- (NSMutableArray *)images{

    if (_images == nil) {
        
        self.images = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            
            [self.images  addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _images = self.images;
    }
    return _images;
}

- (HTLineLayout *)lineLayout{

    if (_lineLayout == nil) {
        _lineLayout = [[HTLineLayout alloc] init];
    }
    
    return _lineLayout;
}
- (HTStack *)stackLayout{
    
    if (_stackLayout == nil) {
        _stackLayout = [[HTStack alloc] init];
    }
    
    return _stackLayout;
}
- (HTCircle *)circleLayout{

    if (_circleLayout == nil) {
        _circleLayout = [[HTCircle alloc] init];
    }
    return _circleLayout;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *lineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lineBtn.frame = CGRectMake(50, 300, 50, 50);
    [lineBtn setTitle:@"线" forState:UIControlStateNormal];
    lineBtn.backgroundColor = [UIColor blueColor];
    lineBtn.tag = 100;
    [lineBtn addTarget:self action:@selector(setCustomLayout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lineBtn];

    UIButton *stackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stackBtn.frame = CGRectMake(150, 300, 50, 50);
    [stackBtn setTitle:@"堆" forState:UIControlStateNormal];
    stackBtn.backgroundColor = [UIColor blueColor];
    stackBtn.tag = 101;
    [stackBtn addTarget:self action:@selector(setCustomLayout:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:stackBtn];
    
    
    UIButton *circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [circleBtn setTitle:@"圆" forState:UIControlStateNormal];

    circleBtn.frame = CGRectMake(250, 300, 50, 50);
    circleBtn.backgroundColor = [UIColor blueColor];
    circleBtn.tag = 102;
    [circleBtn addTarget:self action:@selector(setCustomLayout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleBtn];
    
    
    
    
    
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 0,w,200);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.lineLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;

    [collectionView registerNib:[UINib nibWithNibName:@"HTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:@"HTCollectionViewCellX" bundle:nil] forCellWithReuseIdentifier:IDX];
    
    collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}


- (void)setCustomLayout:(UIButton *)btn{

    
    CGFloat w = self.view.frame.size.width;
    
    switch (btn.tag) {
        case 100:
            [self.collectionView setCollectionViewLayout:self.lineLayout animated:NO];
            self.layout = self.lineLayout;
            self.collectionView.frame = CGRectMake(0, 0, w, 200);
            [self.collectionView reloadData];
            break;
        case 101:
            [self.collectionView setCollectionViewLayout:self.stackLayout animated:NO];
            self.layout = self.stackLayout;

            self.collectionView.frame = CGRectMake(0, 0, w, 200);
            [self.collectionView reloadData];

            break;
        case 102:
            [self.collectionView setCollectionViewLayout:self.circleLayout animated:NO];
            self.layout = self.circleLayout;

            self.collectionView.frame = CGRectMake(0, 0, w, 300);
            [self.collectionView reloadData];

            break;
            
        default:
            break;
    }

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.layout == self.stackLayout) {

        HTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.imageName = self.images[indexPath.item];
        return cell;
        
    } else {
    
        HTCollectionViewCellX *cellX = [collectionView dequeueReusableCellWithReuseIdentifier:IDX forIndexPath:indexPath];
        
        cellX.textName = [NSString stringWithFormat:@"%zd",indexPath.item];
        return cellX;
    }
    
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 删UI(刷新UI)
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


// 这个用来返回每个cell的size  遵守了UICollectionViewDelegateFlowLayout就相当于遵守了UICollectionViewDelegate协议
#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return CGSizeMake(arc4random_uniform(100)+20, arc4random_uniform(100)+20);
//}


@end
