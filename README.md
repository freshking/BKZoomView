BKZoomView
==========

A UIView that will zoom into its parent view.

![alt text](http://imgur.com/9eIAsbe.png "Tinder like sticky header view whick stretches when pulled down")

##How to

Initialize the zoom view anywhere in a view. 

    BKZoomView *zoomView = [[BKZoomView alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 150)];
    [_zoomView setZoomScale:2.0];
    [_zoomView setDragingEnabled:NO];
    [self.view addSubview:_zoomView];
    
####Options:
  
  1. `setZoomScale:` Here you can set the zoom value (Standard = 2.0)
  2. `setDragingEnabled:` Here you can decide wether the user can drag the zoom view around or if it is static. If static, then the user can touch throuch this view which is nice if you place it over a UITableView and still want to scroll.

####Important:
  
  `[zoomview setNeedsDisplay]` must be called everytime you want to update the zoom view. For example the zoom view is placed over a tableview and you want a live zoom when scrolling, then you must implement this in the `scrollViewDidScroll:` method.
  Exception here is when dragging.

For further information please check out the example application.

Concider the MIT license!
