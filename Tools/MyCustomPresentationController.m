//
//  MyCustomPresentationController.m
//  LJAnimation
//
//  Created by Jon on 2017/3/13.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import "MyCustomPresentationController.h"
#import "UIImage+color.h"
#import "Defines.h"

@implementation MyCustomPresentationController

#pragma mark - UIViewControllerTransitioningDelegate
/*
 * 来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了self
 */
- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning具体动画实现
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 动画时长
    return 0.4;
}

// 核心，动画效果的实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1.获取源控制器、目标控制器、动画容器View
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __unused UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
    // 也可以直接通过上面获取控制器获取，比如：toViewController.view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    [containerView addSubview:toView];  //必须添加到动画容器View上。
    
    // 3.设置动画具体细节，使用[UIView animate...]动画，或者其他方式呈现动画。
    
    // 4.动画结束时，必须执行下句代码
    [transitionContext completeTransition:YES];
}

- (void)animationEnded:(BOOL) transitionCompleted {
    // 动画结束...
}


#pragma mark - 重写UIPresentationController个别方法

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

//跳转将要开始的时候调用
// 可以在此方法创建和设置自定义动画所需的view
- (void)presentationTransitionWillBegin{
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.containerView.bounds];
    bgImgView.image = [UIImage imageWithColor:[UIColor clearColor]];
    self.backgroudView = bgImgView;
    [self.containerView addSubview:bgImgView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bgImgView.bounds;
    [bgImgView addSubview:effectView];
    
//    self.backgroudView = [[UIView alloc] initWithFrame:self.containerView.bounds];
//    self.backgroudView.backgroundColor = [UIColor blackColor];
//    [self.containerView addSubview:self.backgroudView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
    [self.backgroudView addGestureRecognizer:tap];
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    effectView.alpha = 0.0f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
         effectView.alpha = 1.0f;
    } completion:NULL];

}

#pragma mark 点击了背景遮罩view
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

// 在跳转结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed {
    // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
    if (!completed) {
        self.backgroudView = nil;
    }
}

// 返回上个界面的转场即将开始的时候被调用的
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self. backgroudView.alpha = 0.0f;
    } completion:NULL];
}

// 返回上个界面的转场完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed == YES) {
        [self.backgroudView removeFromSuperview];
        self.backgroudView = nil;
    }
}

// 返回目标控制器Viewframe
- (CGRect)frameOfPresentedViewInContainerView {
    // 这里直接按照想要的大小写死，其实这样写不好，在第二个Demo里，我们将按照苹果官方Demo，写灵活的获取方式。
    CGFloat height = kScreenHeight;
    if (self.contentHeight > 0) {
        height = self.contentHeight;
    }
    CGRect containerViewBounds = self.containerView.bounds;
    containerViewBounds.origin.y = containerViewBounds.size.height - height;
    containerViewBounds.size.height = height;
    return containerViewBounds;
}

//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) [self.containerView setNeedsLayout];
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    self.backgroudView.frame = self.containerView.bounds;
}
@end
