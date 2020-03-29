//
//  PopTestTableViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "PopTestTableViewController.h"
#import "PopSpringViewController.h"
#import "PopDecayViewController.h"
#import "PopFoldingViewController.h"
#import "PopPropertyViewController.h"

@interface PopTestTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *popTableView;

@end

@implementation PopTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            PopSpringViewController *viewController = [[PopSpringViewController alloc] init];
            [self.navigationController showViewController:viewController sender:self];
        }
            break;
        case 1: {
            PopDecayViewController *viewController = [[PopDecayViewController alloc] init];
            [self.navigationController showViewController:viewController sender:self];
        }
            break;
        case 2: {
            PopFoldingViewController *viewController = [[PopFoldingViewController alloc] init];
            [self.navigationController showViewController:viewController sender:self];
        }
            break;
        case 3: {
            PopPropertyViewController *viewController = [[PopPropertyViewController alloc] init];
            [self.navigationController showViewController:viewController sender:self];
        }
            break;
        default:
            break;
    }
}


@end
