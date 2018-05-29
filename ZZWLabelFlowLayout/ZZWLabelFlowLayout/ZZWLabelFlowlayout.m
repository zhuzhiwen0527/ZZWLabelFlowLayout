//
//  ZZWLabelFlowlayout.m
//  ZZWLabelFlowLayout
//
//  Created by zzw on 2017/8/1.
//  Copyright © 2017年 zzw. All rights reserved.
//
#define VIEW_WIDTH  [UIScreen mainScreen].bounds.size.width
#import "ZZWLabelFlowlayout.h"
@interface ZZWLabelFlowlayout()

@property (nonatomic) CGFloat RW;
@property (nonatomic) CGFloat RH;
//用于保存所有的item的属性(frame)
@property (nonatomic)NSMutableArray * itemsAttributes;
@end
@implementation ZZWLabelFlowlayout

-(void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing{
    if (_minimumInteritemSpacing != minimumInteritemSpacing) {
        _minimumInteritemSpacing = minimumInteritemSpacing;
        [self invalidateLayout];
    }
    
}
-(void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{
    if (_minimumLineSpacing != minimumLineSpacing) {
        _minimumLineSpacing = minimumLineSpacing;
        [self invalidateLayout];
    }
    
}
-(void)setSectionInset:(UIEdgeInsets)sectionInset{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
    
}
//重写方法1：准备布局
- (void)prepareLayout{
    [super prepareLayout];
    //真正的布局在这里完成
    if (_itemsAttributes) {
        [_itemsAttributes removeAllObjects];
    }else{
        _itemsAttributes = [[NSMutableArray alloc] init];
    }
    //起始高度
    self.RH = self.sectionInset.top;
    //左边距
    self.RW = self.sectionInset.left;
    //item的总数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0;  i < count; i++) {
        
        
        //构造indePath
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //动态获取宽度
        CGFloat  w  = 0;
        if ([self.delegate respondsToSelector:@selector(WaterfallFlowLayout:widthForItemAtIndexPath:)]) {
            w = [self.delegate WaterfallFlowLayout:self widthForItemAtIndexPath:indexPath];
        }
        if (VIEW_WIDTH - self.RW < w) {
            self.RH = self.minimumLineSpacing + self.H + self.RH;
            self.RW = self.sectionInset.left;
        }
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame =CGRectMake(self.RW , self.RH, w, self.H);
        //保存到item属性到数组中
        [_itemsAttributes addObject:attr];
        //更新布局到的一列（最短的）的高度
        self.RW = self.RW + self.minimumInteritemSpacing+w;
    }
    //刷新显示
    [self.collectionView reloadData];
}
//重写方法2；返回指定区域的item的属性（frame）
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * array = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes * attr in _itemsAttributes) {
        //判断两个矩形是否有交集
        if (CGRectIntersectsRect(attr.frame, rect)  ) {
            [array addObject:attr];
        }
    }
    return array;
    
}
//重写方法3：返回内容的尺寸
-(CGSize)collectionViewContentSize{
    
    CGFloat width =self.collectionView.frame.size.width;
    
    return CGSizeMake(width, self.RH+self.sectionInset.bottom);
}
@end
