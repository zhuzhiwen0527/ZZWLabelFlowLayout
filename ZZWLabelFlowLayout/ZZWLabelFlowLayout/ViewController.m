//
//  ViewController.m
//  ZZWLabelFlowLayout
//
//  Created by zzw on 2017/8/1.
//  Copyright © 2017年 zzw. All rights reserved.
//
#define Random arc4random()%256/255.0
#define randomColor [UIColor colorWithRed:Random green:Random blue:Random alpha:1.0]
#define VIEW_WIDTH  [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT self.view.frame.size.height
#import "ViewController.h"
#import "ZZWLabelFlowlayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZZWLabelFlowlayoutDelegate>
@property (nonatomic)UICollectionView * collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ZZWLabelFlowlayout*)createLayout{
    ZZWLabelFlowlayout * layout = [[ZZWLabelFlowlayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing =20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.H = 20;
    layout.delegate =self;
    
    return layout;
}
- (void)createCollectionView{
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, VIEW_WIDTH, VIEW_HEIGHT-20) collectionViewLayout:[self createLayout]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_collectionView];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    UILabel * label = nil;
    NSArray * array = cell.contentView.subviews;
    if (array.count) {
        label = array[0];
    }else{
        
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:30];
        [cell.contentView addSubview:label];
    }
    label.frame =  cell.bounds;
    label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    cell.backgroundColor = randomColor;
    return cell;
}

- (CGFloat)WaterfallFlowLayout:(ZZWLabelFlowlayout*)layout widthForItemAtIndexPath:(NSIndexPath*)indexPath{
    return arc4random()%150+50;
}

@end
