//
//  ZZWLabelFlowlayout.h
//  ZZWLabelFlowLayout
//
//  Created by zzw on 2017/8/1.
//  Copyright © 2017年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZWLabelFlowlayout;
@protocol ZZWLabelFlowlayoutDelegate <NSObject>
//动态获取item宽度
- (CGFloat)WaterfallFlowLayout:(ZZWLabelFlowlayout*)layout widthForItemAtIndexPath:(NSIndexPath*)indexPath;
@end
@interface ZZWLabelFlowlayout : UICollectionViewLayout

@property (nonatomic) CGFloat minimumLineSpacing;//上下间距
@property (nonatomic) CGFloat minimumInteritemSpacing;//左右间距
@property (nonatomic) UIEdgeInsets sectionInset;//上下左右边距
@property (nonatomic) id<ZZWLabelFlowlayoutDelegate>delegate;
@property (nonatomic) CGFloat H;//item 高度
@end
