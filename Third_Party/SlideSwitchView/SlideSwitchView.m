//
//  SlideSwitchView.m
//  Edusoho
//
//  Created by Edusoho on 14-7-9.
//  Copyright (c) 2014年 Kuozhi Network Technology. All rights reserved.
//

#import "SlideSwitchView.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin = 16.0f;
static const CGFloat kFontSizeOfTabButton = 16.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@interface SlideSwitchView ()

@property (nonatomic, weak)UIScrollView *observingScrollView;
@property (nonatomic, assign)BOOL shouldObserveContentOffset;

@end

@implementation SlideSwitchView

#pragma mark - 初始化参数

- (void)initValues
{
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.bounces = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _topScrollView.scrollEnabled=NO;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
     _rootScrollView.scrollEnabled=NO;
    _userContentOffsetX = 0;
    _subVCContentOffsetY = 0;
//    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    [self startObservingContentOffsetForScrollView:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _isBuildUI = NO;
    _shouldObserveContentOffset = NO;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

- (void)dealloc
{
    [self stopObservingContentOffset];
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
    
}

#pragma mark - 创建控件

-(BOOL)isBindUI
{
    return _isBuildUI;
}

-(void)selectTab:(NSInteger)userSelectedChannelID
{
    //滚动到选中的视图
    [_rootScrollView setContentOffset:CGPointMake((userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
    
    //调整顶部滚动视图选中按钮位置
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:userSelectedChannelID];
    [self selectNameButton:button];
}

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self selectNameButton:button];
        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize textSize = [vc.title boundingRectWithSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kFontSizeOfTabButton]}
                                                 context:nil].size;
        //累计每个tab文字的长度
        topScrollViewContentWidth += kWidthOfButtonMargin+textSize.width;
        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset,0,
                                    textSize.width, kHeightOfTopScrollView)];
        //计算下一个tab的x偏移量
        xOffset += textSize.width + kWidthOfButtonMargin;
        
        [button setTag:i+100];
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
    }
    // 排不满时平铺
    if (topScrollViewContentWidth < CGRectGetWidth(self.frame)) {
        int i;
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithCapacity:[_topScrollView.subviews count]];
        for (i = 0; [_topScrollView viewWithTag:(100 + i)]; i ++) {
            [buttonArray addObject:[_topScrollView viewWithTag:(100 + i)]];
        }
        for (int j = i; j > 0; j --) {
            UIButton *button = [buttonArray objectAtIndex:j - 1];
            button.center = CGPointMake(CGRectGetWidth(self.frame) * (2 * j - 1) / (i * 2), button.center.y);
        }
        topScrollViewContentWidth = CGRectGetWidth(self.frame);
    }
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
    
    //分界边框
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, kHeightOfTopScrollView - 0.8, topScrollViewContentWidth, 0.8);
    bottomBorder.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.12f].CGColor;
    [_topScrollView.layer addSublayer:bottomBorder];
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab事件
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    _shouldObserveContentOffset = NO;
    
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [sender setTitleColor:_tabItemNormalColor forState:UIControlStateNormal];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        [sender setTitleColor:_tabItemSelectedColor forState:UIControlStateSelected];
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
    }
    //重复点击选中按钮
    else {
        _isRootScroll = NO;
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    CGPoint offset = [self topContentOffsetForSelectedItemAtIndex:sender.tag - 100];
    [_topScrollView setContentOffset:offset animated:YES];
}

- (CGPoint)topContentOffsetForSelectedItemAtIndex:(NSUInteger)index
{
    if (_viewArray.count < index || _viewArray.count == 1) {
        return CGPointZero;
    } else {
        CGFloat totalOffset = _topScrollView.contentSize.width - CGRectGetWidth(_topScrollView.frame);
        return CGPointMake(index * totalOffset / (_viewArray.count - 1), 0);
    }
}

#pragma mark 主视图逻辑方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    if (scrollView == _rootScrollView) {
//        _userContentOffsetX = scrollView.contentOffset.x;
//        _shouldObserveContentOffset = YES;
//    } else if (scrollView != _topScrollView) {
//        _subVCContentOffsetY = scrollView.contentOffset.y;
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView == _rootScrollView) {
//        //判断用户是否左滚动还是右滚动
//        NSInteger tag = (int)(scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame)) + 100;
//        if (_userContentOffsetX < scrollView.contentOffset.x) {
//            _isLeftScroll = YES;
//            if (tag != _userSelectedChannelID && _shouldObserveContentOffset) {
//                _isRootScroll = YES;
//                UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
//                UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
//                [button setTitleColor:_tabItemNormalColor forState:UIControlStateNormal];
//                lastButton.selected = NO;
//                _userSelectedChannelID = button.tag;
//                [button setTitleColor:_tabItemSelectedColor forState:UIControlStateSelected];
//                button.selected = YES;
//            }
//        } else {
//            _isLeftScroll = NO;
//            if ((tag < [_viewArray count] + 99) && _shouldObserveContentOffset) {
//                _isRootScroll = YES;
//                UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag + 1];
//                UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
//                [button setTitleColor:_tabItemNormalColor forState:UIControlStateNormal];
//                lastButton.selected = NO;
//                _userSelectedChannelID = button.tag;
//                [button setTitleColor:_tabItemSelectedColor forState:UIControlStateSelected];
//                button.selected = YES;
//            }
//        }
//    } else if (scrollView != _topScrollView) {
//        if (scrollView.contentOffset.y > _subVCContentOffsetY && scrollView.contentOffset.y>0) {
//            if (self.slideSwitchViewDelegate
//                && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchViewSubVCDragUp:)]) {
//                [self.slideSwitchViewDelegate slideSwitchViewSubVCDragUp:self];
//            }
//        } else if (scrollView.contentOffset.y < _subVCContentOffsetY && scrollView.contentOffset.y <-100) {
//            if (self.slideSwitchViewDelegate
//                && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchViewSubVCDragDown:)]) {
//                [self.slideSwitchViewDelegate slideSwitchViewSubVCDragDown:self];
//            }
//        }
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (scrollView == _rootScrollView) {
//        _isRootScroll = YES;
//        //调整顶部滑条按钮状态
//        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
//        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
//        [self selectNameButton:button];
//    }
}

- (void)scrollHandlePan:(UIPanGestureRecognizer*)panParam
{
    //当滑到左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - KVO

- (void)startObservingContentOffsetForScrollView:(UIScrollView *)scrollView
{
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    _observingScrollView = scrollView;
}

- (void)stopObservingContentOffset
{
    if (_observingScrollView) {
        [_observingScrollView removeObserver:self forKeyPath:@"contentOffset"];
        _observingScrollView = nil;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSUInteger selectedIndex = _userSelectedChannelID - 100;
    CGFloat oldX = selectedIndex * CGRectGetWidth(_rootScrollView.frame);
    if (oldX != _rootScrollView.contentOffset.x && _shouldObserveContentOffset) {
        NSInteger targetIndex = _isLeftScroll ? selectedIndex + 1 : selectedIndex - 1;
        if (targetIndex >= 0 && targetIndex < _viewArray.count) {
            CGFloat ratio = (_rootScrollView.contentOffset.x - oldX) / CGRectGetWidth(_rootScrollView.frame);
            CGFloat previousItemContentOffsetX = [self topContentOffsetForSelectedItemAtIndex:selectedIndex].x;
            CGFloat nextItemContentOffsetX = [self topContentOffsetForSelectedItemAtIndex:targetIndex].x;
            UIButton *previousSelectedItem = (UIButton *)[_topScrollView viewWithTag:selectedIndex + 100];
            UIButton *nextSelectedItem = (UIButton *)[_topScrollView viewWithTag:targetIndex + 100];
            
            CGFloat red, green, blue, alpha, highlightedRed, highlightedGreen, highlightedBlue, highlightedAlpha;
            [self getRed:&red green:&green blue:&blue alpha:&alpha fromColor:_tabItemNormalColor];
            [self getRed:&highlightedRed green:&highlightedGreen blue:&highlightedBlue alpha:&highlightedAlpha fromColor:_tabItemSelectedColor];
            
            CGFloat absRatio = fabsf(ratio);
            UIColor *prev = [UIColor colorWithRed:red * absRatio + highlightedRed * (1 - absRatio)
                                            green:green * absRatio + highlightedGreen * (1 - absRatio)
                                             blue:blue * absRatio + highlightedBlue  * (1 - absRatio)
                                            alpha:alpha * absRatio + highlightedAlpha  * (1 - absRatio)];
            UIColor *next = [UIColor colorWithRed:red * (1 - absRatio) + highlightedRed * absRatio
                                            green:green * (1 - absRatio) + highlightedGreen * absRatio
                                             blue:blue * (1 - absRatio) + highlightedBlue * absRatio
                                            alpha:alpha * (1 - absRatio) + highlightedAlpha * absRatio];
            
            [previousSelectedItem setTitleColor:prev forState:UIControlStateSelected];
            [nextSelectedItem setTitleColor:next forState:UIControlStateNormal];
            
            if (_isLeftScroll) {
                _topScrollView.contentOffset = CGPointMake(previousItemContentOffsetX + (nextItemContentOffsetX - previousItemContentOffsetX) * ratio, 0);
            } else {
                _topScrollView.contentOffset = CGPointMake(previousItemContentOffsetX - (nextItemContentOffsetX - previousItemContentOffsetX) * ratio, 0);
            }
        }
    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (void)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha fromColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
    if (colorSpaceModel == kCGColorSpaceModelRGB && CGColorGetNumberOfComponents(color.CGColor) == 4) {
        *red = components[0];
        *green = components[1];
        *blue = components[2];
        *alpha = components[3];
    } else if (colorSpaceModel == kCGColorSpaceModelMonochrome && CGColorGetNumberOfComponents(color.CGColor) == 2) {
        *red = *green = *blue = components[0];
        *alpha = components[1];
    } else {
        *red = *green = *blue = *alpha = 0;
    }
}

@end


@implementation UIViewController (SlideSwitchView)

@dynamic switchView;

- (SlideSwitchView *)switchView
{
    for (UIView *next = self.view.superview; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[SlideSwitchView class]]) {
            return (SlideSwitchView *)nextResponder;
        }
    }
    return nil;
}

@end
