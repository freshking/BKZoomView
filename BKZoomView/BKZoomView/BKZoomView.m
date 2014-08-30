//
//  BKZoomView.m
//  BKZoomView
//
//  Created by Bastian Kohlbauer on 29.08.14.
//  Copyright (c) 2014 Bastian Kohlbauer. All rights reserved.
//


#import "BKZoomView.h"

@interface BKZoomView ()
{
    float oldX, oldY;
    BOOL dragging;
}
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, assign) CGFloat zoomScale;
@end

@implementation BKZoomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:YES];
        
        _zoomScale = 2.0;
        [self setDragingEnabled:YES];
        
        UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pgr];
        
    }
    return self;
}

// This will be called every time 'addSubview:<BKZoomView>' gets called
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    _parentView = newSuperview;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // Set the corrext area we want to zoom in to
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, (self.frame.size.width / 2), (self.frame.size.height / 2));
	CGContextScaleCTM(context, _zoomScale, _zoomScale);
	CGContextTranslateCTM(context, -(self.frame.origin.x) - (self.frame.size.width / 2), -(self.frame.origin.y) - (self.frame.size.height / 2));
    
    [self setHidden:YES];
    //
	[_parentView.layer.superlayer renderInContext:context];
    [self setHidden:NO];
}

#pragma mark - Private

- (void)setZoomScale:(CGFloat)scale
{
    // We need to call setNeedsDisplay so that the zoom scale can be changed automatically
    
    _zoomScale = scale;
    [self setNeedsDisplay];
}

- (void)setDragingEnabled:(BOOL)enabled
{
    // This will ensure that if there is noch dragging we can also touch through this view
    
    [self setUserInteractionEnabled:enabled];
}

#pragma mark - UIPanGestureRecognizer

- (void)handlePan:(UIPanGestureRecognizer*)pgr;
{
    // Here we handle the dragging of the zoom view
    
    if (pgr.state == UIGestureRecognizerStateChanged)
    {
        CGPoint center = pgr.view.center;
        CGPoint translation = [pgr translationInView:pgr.view];
        center = CGPointMake(center.x + translation.x,
                             center.y + translation.y);
        pgr.view.center = center;
        [pgr setTranslation:CGPointZero inView:pgr.view];
        [self setNeedsDisplay];
    }
}

@end

