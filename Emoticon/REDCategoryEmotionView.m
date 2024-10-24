//
//  REDCategoryEmotionView.m
//  Emoticon
//
//  Created by wangyusong on 2023/2/28.
//

#import "REDCategoryEmotionView.h"
#import "BSEmotionCollectionCell.h"
#import "BSCollectionViewHorizontalLayout.h"
static NSString * selectEmotionCellID = @"selectEmotionKindCollectionCellID";
@interface REDCategoryEmotionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic, assign) NSUInteger pageCount;
@property(nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, assign) REDCategoryEmotionKind kind;
@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation REDCategoryEmotionView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    _items = @[@"a", @"b"];
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.collectionView];
    [self addSubview:self.leftView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];

}


-(void)switchEmotionKeyboard:(REDCategoryEmotionKind)kind{
    
    NSIndexPath *indexPath;
    if (kind == REDCategoryEmotionKindKeyboard) {
         indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }else if (kind == REDCategoryEmotionKindHot){
         indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BSEmotionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectEmotionCellID forIndexPath:indexPath];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.coverView.hidden = YES;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        self.kind = REDCategoryEmotionKindKeyboard;
        _leftView.backgroundColor = [UIColor grayColor];
    }else{
        _leftView.backgroundColor = [UIColor whiteColor];
        self.kind = REDCategoryEmotionKindHot;
    }

    if (self.categoryEmotionBlock) {
        self.categoryEmotionBlock(self.kind);
    }
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        BSCollectionViewHorizontalLayout *layout = [[BSCollectionViewHorizontalLayout alloc]init];
        CGFloat hw = 50;
        layout.itemSize = CGSizeMake(hw,hw);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.rowCount = 1;
        layout.itemCountPerRow = 7;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30,hw)  collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[BSEmotionCollectionCell class] forCellWithReuseIdentifier:selectEmotionCellID];
    }
    return _collectionView;
}

-(UIView *)leftView{
    if (!_leftView) {

        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 50)];
        _leftView.backgroundColor = [UIColor grayColor];
    }
    return _leftView;
}
@end

