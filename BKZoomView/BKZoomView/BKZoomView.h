//
//  BKZoomView.h
//  BKZoomView
//
//  Created by Bastian Kohlbauer on 29.08.14.
//  Copyright (c) 2014 Bastian Kohlbauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKZoomView : UIView

/*
 * Sets the scale on how far you want to zoom in to.
 */
- (void)setZoomScale:(CGFloat)scale;

/*
 * Enables/disables dragging of the zoom view.
 */
- (void)setDragingEnabled:(BOOL)enabled;
@end
