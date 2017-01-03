//
//  ViewController.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ViewController.h"
#import "ProfileCell.h"
#import "YBTopAlignedCollectionViewFlowLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PageViewController.h"
#import "DetailViewController.h"
#import "OpenPageAnimator.h"
#import "PageViewController.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate, UINavigationControllerDelegate>
@property (nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create & config
    [self setupViews];
    //add to heirarchy and set constaints
    [self setupConstraints];
    //models
    self.viewModel = [[ProfilesViewModel alloc] init];
    [self setupViewModel];
    [self.viewModel loadProfiles];
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.delegate = self; //not set in viewdidload
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}

-(void)setupViewModel {
    typeof(self) __weak weakSelf = self;
    void(^updateBlock)() = ^() {
        ViewController* strongSelf = weakSelf;
        [strongSelf updateUI];
    };
    self.viewModel.updateBlock = updateBlock;
}

-(void) refreshClicked:(id) sender {
    [self.viewModel loadProfiles];
}

-(void)updateUI {
    [self.collectionView reloadData];
}

-(void) setupViews {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    //can use collectionViewLayoutdelegate to calculate more acurate size
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-40)/2, ([UIScreen mainScreen].bounds.size.width-40)/2 + 60);
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass: [ProfileCell class]  forCellWithReuseIdentifier: kProfileCellId];
}

//a flavor using native NSLayoutConstraints, other place use Masionary for simplicity
-(void) setupConstraints {
    [self.view addSubview: self.collectionView];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints: NO];
    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem: self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem: self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem: self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem: self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    [NSLayoutConstraint activateConstraints:@[top, left, right, bottom]];
}

//MARK: collection view datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.profiles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProfileCellId forIndexPath:indexPath];
    cell.nameLabel.text = [self.viewModel fullNameForProfileAtIndex:indexPath.item];
    cell.titleLabel.text = [self.viewModel titleForProfileAtIndex:indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:  self.viewModel.profiles[indexPath.item].avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

//MARK: collection view delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PageViewController* pvc = [[PageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self setupPageViewController:pvc withIndexPath: indexPath];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)setupPageViewController: (PageViewController*) pvc withIndexPath:(NSIndexPath*)indexPath{
    pvc.dataSource = pvc;  //pvc's navigation controller not set yet!
    pvc.viewModel = self.viewModel;
    pvc.edgesForExtendedLayout = UIRectEdgeNone;
    DetailViewController* dvc = [pvc createDetailPage];
    dvc.profile = self.viewModel.profiles[indexPath.item];
    pvc.navigationItem.title = @"Profile Detail";

    [pvc setViewControllers:@[dvc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    //get offset from screen frame
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellRect = attributes.frame;
    CGRect cellFrameInSuperview = [self.collectionView convertRect:cellRect toView:[self.collectionView superview]];
    pvc.fromFrame = cellFrameInSuperview;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if([toVC isKindOfClass: [PageViewController class]]) {
    OpenPageAnimator* opa = [[OpenPageAnimator alloc] init];
    opa.delegate = ((PageViewController*)toVC);
    opa.presenting = YES;
       return opa;
    }
    return nil;
}

@end
