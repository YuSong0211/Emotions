//
//  BSEmotionView.m
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import "BSEmotionView.h"
#import "REDSelectEmotionKindView.h"
#import "REDCategoryEmotionView.h"
#import "REKeyboardDEmotionView.h"
@interface BSEmotionView()<UIScrollViewDelegate>
@property(nonatomic, strong) NSArray *items;
@property (nonatomic, strong) REDCategoryEmotionView *categoryEmotionView;
@property (nonatomic, strong) REKeyboardDEmotionView *keyboardemotionView;
@property (nonatomic, strong) REDSelectEmotionKindView *selectEmotionView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic, assign) BOOL recodeClickCategoryBool;
@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kItemHeight  (kScreenWidth - 30)/5


@implementation BSEmotionView

-(instancetype)init{
    if (self == [super init]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{

    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.keyboardemotionView];
    [self.scrollView addSubview:self.selectEmotionView];
    [self addSubview:self.categoryEmotionView];
    [self addSubview:self.pageControl];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    _categoryEmotionView.frame = CGRectMake(0, self.scrollView.frame.size.height, kScreenWidth, 50);
}

-(void)switchEmotionKeyboard:(REDCategoryEmotionKind)kind{
    
    if (kind == REDCategoryEmotionKindKeyboard) {
        [self scrollEmotionAtcion:0];
        
    }else if(kind == REDCategoryEmotionKindHot){
        [self scrollEmotionAtcion:kScreenWidth];
    }
}

-(void)scrollEmotionAtcion:(CGFloat)sizeWidth{
    if (sizeWidth == 0) {
        self.pageControl.numberOfPages = self.keyboardemotionView.pageCount / 12.0;
        self.keyboardemotionView.collectionView.contentOffset = CGPointZero;
        self.pageControl.currentPage = 0;
        self.recodeClickCategoryBool = YES;
    }else{
        self.pageControl.numberOfPages = self.keyboardemotionView.pageCount / 10.0;
        self.selectEmotionView.collectionView.contentOffset = CGPointZero;
        self.recodeClickCategoryBool = NO;


    }
    self.scrollView.contentOffset = CGPointMake(sizeWidth, 0);
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    CGFloat offsetx = scrollView.contentOffset.x;
    if (offsetx == 0) {
        NSLog(@"===%ld",(long)self.pageControl.currentPage);
        if (!self.recodeClickCategoryBool) {
            self.pageControl.currentPage = self.keyboardemotionView.pageCount / 12.0;
            self.recodeClickCategoryBool = NO;
            self.keyboardemotionView.collectionView.contentOffset = CGPointMake(self.pageControl.currentPage * kScreenWidth, 0);
        }else{
            self.pageControl.numberOfPages = self.keyboardemotionView.pageCount / 12.0;
            [self.categoryEmotionView switchEmotionKeyboard:REDCategoryEmotionKindKeyboard];
        }
       
    }else if(offsetx == kScreenWidth){
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.keyboardemotionView.pageCount / 10.0;
        [self.categoryEmotionView switchEmotionKeyboard:REDCategoryEmotionKindHot];
        self.recodeClickCategoryBool = NO;

    }
    NSLog(@"%f",scrollView.contentOffset.x);
}


-(REDCategoryEmotionView *)categoryEmotionView{
    if (!_categoryEmotionView) {
        _categoryEmotionView = [[REDCategoryEmotionView alloc]initWithFrame:CGRectMake(0,200 , kScreenWidth, 50)];
        __weak typeof(self) weakSelf = self;
        _categoryEmotionView.categoryEmotionBlock = ^(REDCategoryEmotionKind kind) {
            [weakSelf switchEmotionKeyboard:kind];
        };
    }
    return _categoryEmotionView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,220)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

-(REKeyboardDEmotionView *)keyboardemotionView{
    if (!_keyboardemotionView) {
        _keyboardemotionView = [[REKeyboardDEmotionView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 200)];
        __weak typeof(self) weakSelf = self;
        _keyboardemotionView.pageControlBlock = ^(NSInteger intPage) {
            weakSelf.pageControl.currentPage = intPage;
        };
        _keyboardemotionView.initPageControlBlock = ^(NSInteger intPage) {
            weakSelf.pageControl.numberOfPages = 6;
        };
    }
    return _keyboardemotionView;
}

-(REDSelectEmotionKindView *)selectEmotionView{
    if (!_selectEmotionView) {
        _selectEmotionView = [[REDSelectEmotionKindView alloc]initWithFrame:CGRectMake(kScreenWidth, 20, kScreenWidth,  200)];
        __weak typeof(self) weakSelf = self;
        _selectEmotionView.pageControlBlock = ^(NSInteger intPage) {
            weakSelf.pageControl.currentPage = intPage;
        };
    }
    return _selectEmotionView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 185, self.frame.size.width, 10)];
        _pageControl.numberOfPages = 5;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}

@end
