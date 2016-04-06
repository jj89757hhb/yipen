//
//  ImagePlayerView.m
//  ImagePlayerView
//
//  Created by 陈颜俊 on 14-6-5.
//  Copyright (c) 2014年 Chenyanjun. All rights reserved.
//

#import "ImagePlayerView.h"

#define kDefaultScrollInterval  2

@interface ImagePlayerView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat scrollViewStartContentOffsetX;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, strong) NSMutableArray *pageControlConstraints;
@property (nonatomic, strong) NSMutableArray *scrollViewConstraints;
@end

@implementation ImagePlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithDelegate:(id<ImagePlayerViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _imagePlayerViewDelegate = delegate;
        [self _init];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"bounds"];
    _imagePlayerViewDelegate = nil;
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
}

- (void)_init
{
    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    
    _scrollViewConstraints = [NSMutableArray array];
    
    self.scrollInterval = kDefaultScrollInterval;
    self.currentPageIndex = 0;
    
    // scrollview
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
    }
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    
    // UIPageControl
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    _pageControl.userInteractionEnabled = YES;
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    _pageControl.numberOfPages = _totalPageCount;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": _pageControl}];
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": _pageControl}];
    _pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
    [_pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    [self addConstraints:_pageControlConstraints];

    self.edgeInsets = UIEdgeInsetsZero;
    
    [self reloadData];
}

- (void)setTotalPageCount:(NSInteger)totalPageCount
{
    _totalPageCount = totalPageCount;
    if (_totalPageCount > 0) {
        if (_totalPageCount > 1) {
            _scrollView.scrollEnabled = YES;
            _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
        } else {
            _scrollView.scrollEnabled = NO;
        }
        [self configContentViews];
    }
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
    _currentPageIndex = currentPageIndex;
    [_pageControl setCurrentPage:_currentPageIndex];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bounds"]) {
        [self reloadData];
    }
}

- (void)reloadData
{
    // remove subview from scrollview first
    for (UIView *subView in _scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    _totalPageCount = [_imagePlayerViewDelegate numberOfItems];
    
    _pageControl.numberOfPages = _totalPageCount;
    self.currentPageIndex = 0;
    
    if (!_totalPageCount) {
        return;
    }
    
    if (_totalPageCount <= 1) {
        [self stopTimer];
    } else {
        self.scrollInterval = kDefaultScrollInterval;
    }
    
    [self configContentViews];
}

#pragma mark - private methods
- (void)configContentViews
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in _contentViews) {
        
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [_scrollView addSubview:contentView];
    }
    if (_totalPageCount > 1) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    
    if (_contentViews == nil) {
        _contentViews = [@[] mutableCopy];
    }
    [_contentViews removeAllObjects];
    
    if (_imagePlayerViewDelegate) {
        id set = (_totalPageCount == 1)?[NSSet setWithObjects:@(previousPageIndex),@(_currentPageIndex),@(rearPageIndex), nil]:@[@(previousPageIndex),@(_currentPageIndex),@(rearPageIndex)];
        
        CGFloat width = self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right;
        CGFloat height = self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
        for (NSNumber *tempNumber in set) {
            NSInteger tempIndex = [tempNumber integerValue];
            if ([self isValidArrayIndex:tempIndex]) {
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds=YES;
                imageView.userInteractionEnabled = YES;
                imageView.translatesAutoresizingMaskIntoConstraints = NO;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
                [_scrollView addSubview:imageView];
                
                [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
                [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
                
                [_imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:tempIndex];
                [_contentViews addObject:imageView];
            }
        }
        
        // constraint
        NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
        NSMutableArray *imageViewNames = [NSMutableArray array];
        for (int i = 0; i < ((_totalPageCount == 2) ? 3 : [_contentViews count]); i++) {
            NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i];
            [imageViewNames addObject:imageViewName];
            
            UIImageView *imageView = _contentViews[i];
            [viewsDictionary setObject:imageView forKey:imageViewName];
        }
        
        [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", [imageViewNames objectAtIndex:0]]
                                                                                options:kNilOptions
                                                                                metrics:nil
                                                                                  views:viewsDictionary]];
        
        NSMutableString *hConstraintString = [NSMutableString string];
        [hConstraintString appendString:@"H:|-0"];
        for (NSString *imageViewName in imageViewNames) {
            [hConstraintString appendFormat:@"-[%@]-0", imageViewName];
        }
        [hConstraintString appendString:@"-|"];
        
        [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hConstraintString
                                                                                options:NSLayoutFormatAlignAllTop
                                                                                metrics:nil
                                                                                  views:viewsDictionary]];
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _totalPageCount, _scrollView.frame.size.height);
        _scrollView.contentInset = UIEdgeInsetsZero;
    }
}

- (BOOL)isValidArrayIndex:(NSInteger)index
{
    if (index >= 0 && index <= _totalPageCount - 1) {
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return _totalPageCount - 1;
    } else if (currentPageIndex == _totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark - actions
- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture
{
    if (_imagePlayerViewDelegate && [_imagePlayerViewDelegate respondsToSelector:@selector(imagePlayerView:didTapAtIndex:)]) {
        [_imagePlayerViewDelegate imagePlayerView:self didTapAtIndex:_currentPageIndex];
    }
}

#pragma mark - auto scroll

- (void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval = scrollInterval;
    
    if (_totalPageCount <= 1) {
        return;
    }
    
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
    
//    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
}

- (void)handleScrollTimer:(NSTimer *)timer
{
    [_scrollView setContentOffset:CGPointMake(2 * _scrollView.frame.size.width, _scrollView.contentOffset.y) animated:YES];
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // disable v direction scroll
    if (scrollView.contentOffset.y > 0 || _totalPageCount <= 1) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    }
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (_totalPageCount == 2) {
        if (_scrollViewStartContentOffsetX < contentOffsetX) {
            UIView *tempView = (UIView *)[_contentViews lastObject];
            tempView.frame = (CGRect){{2 * CGRectGetWidth(scrollView.frame), 0}, tempView.frame.size};
        } else if (_scrollViewStartContentOffsetX > contentOffsetX) {
            UIView *tempView = (UIView *)[_contentViews firstObject];
            tempView.frame = (CGRect){{0, 0}, tempView.frame.size};
        }
    }
    
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        NSLog(@"next，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//        NSLog(@"previous，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollViewStartContentOffsetX = scrollView.contentOffset.x;
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // when user scrolls manually, stop timer and start timer again to avoid next scroll immediatelly
    if (_autoScrollTimer && _autoScrollTimer.isValid) {
        [_autoScrollTimer invalidate];
    }
//    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
}

#pragma mark - settings
- (void)setPageControlPosition:(ICPageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case ICPageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ICPageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case ICPageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ICPageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        default:
            break;
    }
    
    [self removeConstraints:_pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": _pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": _pageControl}];
    
    [_pageControlConstraints removeAllObjects];
    [_pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [_pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:_pageControlConstraints];
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    _pageControl.hidden = hidePageControl;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    
    [self removeConstraints:_scrollViewConstraints];
    
    NSArray *scrollViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[scrollView]-bottom-|"
                                                                              options:kNilOptions
                                                                              metrics:@{@"top": @(self.edgeInsets.top),
                                                                                        @"bottom": @(self.edgeInsets.bottom)}
                                                                                views:@{@"scrollView": _scrollView}];
    NSArray *scrollViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[scrollView]-right-|"
                                                                              options:kNilOptions
                                                                              metrics:@{@"left": @(self.edgeInsets.left),
                                                                                        @"right": @(self.edgeInsets.right)}
                                                                                views:@{@"scrollView": _scrollView}];
    
    [_scrollViewConstraints removeAllObjects];
    [_scrollViewConstraints addObjectsFromArray:scrollViewHConstraints];
    [_scrollViewConstraints addObjectsFromArray:scrollViewVConstraints];
    
    [self addConstraints:_scrollViewConstraints];
    
    // update imageview constraints
    CGFloat width = self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat height = self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
    
    for (UIView *subView in _scrollView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)subView;
            for (NSLayoutConstraint *constraint in imageView.constraints) {
                if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = width;
                } else if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                    constraint.constant = height;
                }
            }
        }
    }
}

- (void)stopTimer
{
    if (_autoScrollTimer && _autoScrollTimer.isValid) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}

#pragma mark - deprecated methods
// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:edgeInsets];
}

// @deprecated implement ImagePlayerViewDelegate
- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

// @deprecated implement ImagePlayerViewDelegate
- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    _totalPageCount = count;
    _imagePlayerViewDelegate = delegate;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[scrollView]-%d-|", (int)edgeInsets.top, (int)edgeInsets.bottom]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": _scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%d-[scrollView]-%d-|", (int)edgeInsets.left, (int)edgeInsets.right]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": _scrollView}]];
    
    if (count == 0) {
        return;
    }
    
    _pageControl.numberOfPages = count;
    _pageControl.currentPage = 0;
    
    CGFloat startX = _scrollView.bounds.origin.x;
    CGFloat width = self.bounds.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat height = self.bounds.size.height - edgeInsets.top - edgeInsets.bottom;
    
    for (int i = 0; i < count; i++) {
        startX = i * width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
        
        [_imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:i];
        
        [_scrollView addSubview:imageView];
    }
    
    // constraint
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *imageViewNames = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i];
        [imageViewNames addObject:imageViewName];
        
        UIImageView *imageView = (UIImageView *)[_scrollView viewWithTag:i];
        [viewsDictionary setObject:imageView forKey:imageViewName];
    }
    
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", [imageViewNames objectAtIndex:0]]
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    NSMutableString *hConstraintString = [NSMutableString string];
    [hConstraintString appendString:@"H:|-0"];
    for (NSString *imageViewName in imageViewNames) {
        [hConstraintString appendFormat:@"-[%@]-0", imageViewName];
    }
    [hConstraintString appendString:@"-|"];
    
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hConstraintString
                                                                            options:NSLayoutFormatAlignAllTop
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * count, _scrollView.frame.size.height);
    _scrollView.contentInset = UIEdgeInsetsZero;
}
@end

