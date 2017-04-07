//
//  MainViewController.m
//  GetSmashed2
//
//  Created by Sabir Saluja on 12/14/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//

#import "MainViewController.h"
#import "TournamentsModel.h"

@interface MainViewController ()
@property (strong) TournamentsModel *model;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [TournamentsModel sharedModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.model numberOfTournaments];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1; 
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
