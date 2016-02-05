//
//  addReceiptViewController.m
//  Receipts++
//
//  Created by Adam DesLauriers on 2016-02-04.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "addReceiptViewController.h"
#import "AddReceiptTableViewCell.h"
#import "Tag+CoreDataProperties.h"
#import "LHLCoreDataStack.h"

@interface addReceiptViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSMutableArray *tagNames;


@end

@implementation addReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tagNames = [NSMutableArray array];
    
    
    


    
    Tag *business = [Tag createAndSaveTagWithName:@"Business" inContext:self.context];

    
//    Tag *family = [[Tag alloc] init];
//    family.tagName = @"Family";
//    
//    Tag *personal = [[Tag alloc] init];
//    personal.tagName = @"Personal";
//    
    
    
    
    
    [self.tagNames addObjectsFromArray:@[ business,]];
    

}

-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@" %@", self.context);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tagNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddReceiptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Tag *individual = self.tagNames [indexPath.row];
    
    cell.textLabel.text = individual.tagName;
    
    
    return cell;
}



- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sumbitButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
