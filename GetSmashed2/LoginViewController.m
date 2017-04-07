//
//  ViewController.m
//  GetSmashed2
//
//  Created by Sabir Saluja on 12/7/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TournamentsModel.h"


@interface ViewController ()

@property (strong) TournamentsModel* model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginButton.delegate = self;
    if ([FBSDKAccessToken currentAccessToken]) {
        
//        NSLog(@"Access token: %@", token.tokenString);
//        NSLog(@"UserID: %@", token.userID);
    }
    else {
        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
        loginButton.center = self.view.center;
        [self.view addSubview:loginButton];
        if ([FBSDKAccessToken currentAccessToken]) {
            [self performSegueWithIdentifier:@"loginCompleted" sender:self];
        }
    }

}

- (void)viewDidAppear:(BOOL)animated {
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"loginCompleted" sender:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
