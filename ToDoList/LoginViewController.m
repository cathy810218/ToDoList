//
//  LoginViewController.m
//
//
//  Created by Cathy Oun on 5/8/17.
//
//

#import "LoginViewController.h"
@import FirebaseAuth;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupButtonPressed:(id)sender
{
    [[FIRAuth auth] createUserWithEmail:self.emailTextfield.text password:self.passwordTextfield.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error singing up: %@", error);
        }
        if (user) {
            NSLog(@"Sign up user: %@", user.displayName);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)loginButtonPressed:(id)sender
{
    [[FIRAuth auth] signInWithEmail:self.emailTextfield.text password:self.passwordTextfield.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error signing in: %@", error);
        }
        if (user) {
            NSLog(@"Log in user: %@", user.displayName);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
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
