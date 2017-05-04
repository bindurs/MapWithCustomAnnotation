//
//  DetailsViewController.m
//  MapWithCustomAnnotation
//
//  Created by Bindu on 04/05/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *latLabel;
@property (strong, nonatomic) IBOutlet UILabel *lngLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationNameLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.latLabel.text = [NSString stringWithFormat:@"Latitude: %@",[self.location valueForKey:@"lat"]] ;
    self.lngLabel.text = [NSString stringWithFormat:@"Longitude: %@",[self.location valueForKey:@"lng"]];
    self.locationNameLabel.text = self.name;
}
- (IBAction)backClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
