//
//  WYCollectionViewController.m
//  WYMenuAnimate
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import "WYCollectionViewController.h"
#import "WYCollectionViewCell.h"

@interface WYCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)  NSArray *first;
@property (nonatomic,strong)  NSArray *second;
@property (nonatomic,strong)  NSMutableArray *firsts;
@property (nonatomic,strong)  NSMutableArray *seconds;
@property (nonatomic,strong)  NSMutableArray *lfirst;
@property (nonatomic,strong)  NSMutableArray *lsecond;
@end

@implementation WYCollectionViewController
/**
 *  初始化C
 */
-(NSMutableArray *)firsts
{
    if (!_firsts) {
        self.firsts=[[NSMutableArray alloc]init];
    }
    return _firsts;
}

-(NSMutableArray *)seconds
{
    if (!_seconds) {
        self.seconds=[[NSMutableArray alloc]init];
    }
    return _seconds;
}

-(NSMutableArray *)lfirst
{
    if (!_lfirst) {
        self.lfirst=[[NSMutableArray alloc]init];
    }
    return _lfirst;
}

-(NSMutableArray *)lsecond
{
    if (!_lsecond) {
        self.lsecond=[[NSMutableArray alloc]init];
    }
    return _lsecond;
}
- (instancetype)init
{
    //初始化布局类(UICollectionViewLayout的子类)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置布局类中cell的大小
    layout.headerReferenceSize=CGSizeMake(320, 30);
    layout.itemSize = CGSizeMake(70, 40);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.first=@[@"头条",@"娱乐",@"健康",@"星座",@"社会",@"佛教",@"时事",@"时尚",@"军事",@"旅游"];
    self.second=@[@"房产",@"汽车",@"港澳",@"教育",@"历史",@"文化",@"财经",@"读书",@"台湾",@"体育",@"科技",@"评论"];
    [self.firsts addObjectsFromArray:self.first];
    [self.seconds addObjectsFromArray:self.second];
    [self.collectionView registerClass:[WYCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[WYCollectionViewCell class] forCellWithReuseIdentifier:@"old"];
    [self.collectionView registerClass:[WYCollectionViewCell class] forCellWithReuseIdentifier:@"new"];
    //设置垂直方向是否反弹
    self.collectionView.alwaysBounceVertical = YES;
    //设置代理和数据源
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return self.firsts.count;
    }else
        return self.seconds.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify = @"Cell";
    WYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    if (indexPath.section==0) {
        cell.titlelable.text =self.firsts[indexPath.row];
    }else
    {
        cell.titlelable.text =self.seconds[indexPath.row];
    }
    cell.layer.cornerRadius=10;
    //NSLog(@"(%f,%f)",cell.frame.origin.x,cell.frame.origin.y);
    //CGRect from=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    //[self initailzerAnimationWithToPostion:cell.frame formPostion:from atView:cell beginTime:0.2*indexPath.row];
    return cell;
}

//设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 40);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextindexPath=nil;
    if (indexPath.section==0) {
        [self.seconds insertObject:self.firsts[indexPath.row] atIndex:self.seconds.count];
        [self.firsts removeObjectAtIndex:indexPath.row];
        nextindexPath=[NSIndexPath indexPathForRow:self.seconds.count-1 inSection:1];
    }else
    {
        [self.firsts insertObject:self.seconds[indexPath.row] atIndex:self.firsts.count];
        [self.seconds removeObjectAtIndex:indexPath.row];
        nextindexPath=[NSIndexPath indexPathForRow:self.firsts.count-1 inSection:0];
    }
    [collectionView moveItemAtIndexPath:indexPath toIndexPath:nextindexPath];
    //[self initailzerAnimationWithToPostion:newcell.frame formPostion:oldcell.frame atView:oldcell beginTime:1];
    //[self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    // NSLog(@"%@",nextindexPath);
    //NSLog(@"%f,%f,%@",oldcell.frame.origin.x,oldcell.frame.origin.y,oldcell.titlelable.text);
    // NSLog(@"%f,%f,%@",newcell.frame.origin.x,newcell.frame.origin.y,newcell.titlelable.text);
    //[self.collectionView reloadData];
    
}

//- (void)initailzerAnimationWithToPostion:(CGRect)toRect formPostion:(CGRect)fromRect atView:(UIView *)view beginTime:(CFTimeInterval)beginTime {
//    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
//    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    springAnimation.removedOnCompletion = YES;
//    springAnimation.beginTime = beginTime + CACurrentMediaTime();
//    CGFloat springBounciness = 10 - beginTime * 2;
//    springAnimation.springBounciness = springBounciness;    // value between 0-20
//    
//    CGFloat springSpeed = 12 - beginTime * 2;
//    springAnimation.springSpeed = springSpeed;     // value between 0-20
//    springAnimation.toValue = [NSValue valueWithCGRect:toRect];
//    springAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
//    
//    [view pop_addAnimation:springAnimation forKey:@"POPSpringAnimationKey"];
//}

//- (CGRect)nextframeForAtIndex:(NSUInteger)section row:(NSInteger)row collectionView:(UICollectionView *)collectionView
//{
//
////    NSUInteger rowCount = self.buttons.count / columnCount + (self.buttons.count%columnCount>0?1:0);
////    NSUInteger rowIndex = index / columnCount;
////    CGFloat itemHeight = (WIAnimateButtonImageHeight + WIAnimateButtonTitleHeight) * rowCount + (rowCount > 1?(rowCount - 1) * WIAnimateButtonHorizontalMargin:0);
////    CGFloat offsetY = (self.bounds.size.height - itemHeight) / 2.0;
////    CGFloat verticalPadding = (self.bounds.size.width - WIAnimateButtonHorizontalMargin * 2 - WIAnimateButtonImageHeight * WIAnimateMenucolumnCount) / 2.0;
////    CGFloat offsetX = WIAnimateButtonHorizontalMargin;
////    offsetX += (WIAnimateButtonImageHeight+ verticalPadding) * columnIndex;
////    offsetY += (WIAnimateButtonImageHeight + WIAnimateButtonTitleHeight + WIAnimateButtonVerticalPadding) * rowIndex;
//    //return CGRectMake(offsetX, offsetY, WIAnimateButtonImageHeight, (WIAnimateButtonImageHeight+WIAnimateButtonTitleHeight));
//
//}

@end
