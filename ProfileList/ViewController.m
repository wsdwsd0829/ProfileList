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

@interface ViewController () <UICollectionViewDataSource>
@property (nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create & config
    self.collectionView = [self createcollectionView];
    //add to heirarchy and set constaints
    [self setupConstraints];
    
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass: [ProfileCell class]  forCellWithReuseIdentifier: kProfileCellId];
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    //YBTopAlignedCollectionViewFlowLayout* layout = [[YBTopAlignedCollectionViewFlowLayout alloc] initWithNumColumns:2];
    
    //layout.estimatedItemSize = CGSizeMake(1 , 1);
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-40)/2, ([UIScreen mainScreen].bounds.size.width-40)/2 + 20 + 40);
    self.collectionView.collectionViewLayout = layout;
    
    self.viewModel = [[ProfilesViewModel alloc] init];
    [self setupViewModel];
    [self.viewModel loadProfiles];
    [self updateUI];
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
    [self updateUI];
}

-(void)updateUI {
    [self.collectionView reloadData];
}

-(UICollectionView*) createcollectionView{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:flowLayout];
    return collectionView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
