//
//  REKeyboardDEmotionView.m
//  Emoticon
//
//  Created by wangyusong on 2023/2/28.
//

#import "REKeyboardDEmotionView.h"
#import "BSEmotionCollectionCell.h"
#import "BSCollectionViewHorizontalLayout.h"
static NSString * emotionCellID = @"EmotionCollectionCellID";
@interface REKeyboardDEmotionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic, assign) NSUInteger pageCount;
@property(nonatomic, strong) NSArray *items;
@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kItemHeight  (kScreenWidth - 30)/6


@implementation REKeyboardDEmotionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    _items = @[@"a", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5",@"b", @"c",@"a", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5",@"b", @"c",@"a", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5",@"b", @"c",@"a", @"b", @"c", @"4", @"5", @"b", @"c", @"4", @"5", @"b", @"c", @"4"];
    NSLog(@"%f", _items.count / 12.0);
    _pageCount = _items.count;
    while (_pageCount % 12 != 0) {
        ++_pageCount;
    }
    if (self.initPageControlBlock) {
        self.initPageControlBlock(_pageCount / 12.0);
    }
//    self.pageControl.numberOfPages = _pageCount / 12.0;
//    [self addSubview:self.pageControl];
    [self addSubview:self.collectionView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 35, self.frame.size.width, 10);
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pageCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BSEmotionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:emotionCellID forIndexPath:indexPath];
   
    if (indexPath.item >= _items.count){
        cell.coverView.hidden = NO;
        
    }else{
        cell.coverView.hidden = YES;
        
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item >= _items.count) {
        NSLog(@"点击了====空白");
    } else {
        NSLog(@"点击了=====%ld",indexPath.row);
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    //获得页码
    CGFloat doublePage = scrollView.contentOffset.x/kScreenWidth;
    int intPage = (int)(doublePage +0.5);
    //设置页码
    self.pageControl.currentPage= intPage;
    if (self.pageControlBlock) {
        self.pageControlBlock(intPage);
    }
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        BSCollectionViewHorizontalLayout *layout = [[BSCollectionViewHorizontalLayout alloc]init];
       
//        CGFloat kItemHeight = (kScreenWidth - 30)/7;
        layout.itemSize = CGSizeMake(kItemHeight,kItemHeight);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.rowCount = 2;
        layout.itemCountPerRow = 6;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30,kItemHeight * 2 + 10)  collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[BSEmotionCollectionCell class] forCellWithReuseIdentifier:emotionCellID];
    }
    return _collectionView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 155, self.frame.size.width, 10)];
        _pageControl.numberOfPages = 6;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}

@end
