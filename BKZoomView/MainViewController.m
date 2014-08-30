//
//  MainViewController.m
//  BKZoomView
//
//  Created by Bastian Kohlbauer on 29.08.14.
//  Copyright (c) 2014 Bastian Kohlbauer. All rights reserved.
//

#import "MainViewController.h"
#import "BKZoomView.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BKZoomView *zoomView1;
@property (nonatomic, strong) BKZoomView *zoomView2;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(50, 0, (self.view.frame.size.width - 100), self.view.frame.size.height) style:UITableViewStylePlain];
        [tabelView setBackgroundColor:[UIColor clearColor]];
        [tabelView setSeparatorColor:[UIColor clearColor]];
        [tabelView setDelegate:self];
        [tabelView setDataSource:self];
        [self.view addSubview:tabelView];
        
        _zoomView1 = [[BKZoomView alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 150)];
        [_zoomView1 setZoomScale:(_zoomView1.frame.size.width / tabelView.frame.size.width)];
        [_zoomView1 setDragingEnabled:NO];
        [self.view addSubview:_zoomView1];
        
        _zoomView2 = [[BKZoomView alloc] initWithFrame:CGRectMake(10, 20, 150, 150)];
        [_zoomView2 setZoomScale:2.0];
        [_zoomView2 setDragingEnabled:YES];
        [_zoomView2.layer setBorderColor:[UIColor blackColor].CGColor];
        [_zoomView2.layer setBorderWidth:1.0];
        [_zoomView2.layer setCornerRadius:75];
        [self.view addSubview:_zoomView2];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [cell setBackgroundColor:[self randomColor]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Title %i",(indexPath.row + 1)];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Subtitle %i",(indexPath.row + 1)];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_zoomView1 setNeedsDisplay];
    [_zoomView2 setNeedsDisplay];
}

#pragma mark - Private

- (UIColor *)randomColor
{
    CGFloat redValue = arc4random() % 255 / 255.0;
    CGFloat greenValue = arc4random() % 255 / 255.0;
    CGFloat blueValue = arc4random() % 255 / 255.0;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
