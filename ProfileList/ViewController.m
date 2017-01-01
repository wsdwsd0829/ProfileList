//
//  ViewController.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ViewController.h"
#import "ProfileCell.h"

@interface ViewController () <UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create & config
    self.tableView = [self createTableView];
    self.tableView.dataSource = self;
    [self.tableView registerClass: [ProfileCell class]  forCellReuseIdentifier: kProfileCellId];
    //add to heirarchy and set constaints
    [self setupConstraints];
    
    [self updateUI];
}
-(void)updateUI {
    [self.tableView reloadData];
}

-(UITableView*) createTableView{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:
                              UITableViewStylePlain];
    tableView.backgroundColor = [UIColor greenColor];
    return tableView;
}

//a flavor using native NSLayoutConstraints, other place use Masionary for simplicity
-(void) setupConstraints {
    [self.view addSubview: self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints: NO];
    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem: self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem: self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem: self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem: self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    [NSLayoutConstraint activateConstraints:@[top, left, right, bottom]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell* cell = [tableView dequeueReusableCellWithIdentifier:kProfileCellId forIndexPath:indexPath];
    cell.nameLabel.text = @"Testing";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
