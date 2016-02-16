//
//  addReceiptViewController.m
//  Receipts++
//
//  Created by Adam DesLauriers on 2016-02-04.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "addReceiptViewController.h"
#import "AddReceiptTableViewCell.h"
#import "LHLCoreDataStack.h"

@interface addReceiptViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSMutableArray *tagNames;
@property (nonatomic, strong) NSMutableSet *selectedTags;


@end

@implementation addReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.selectedTags = [[NSMutableSet alloc] init];
    self.tagNames = [NSMutableArray array];
    
    Tag *business = [Tag createAndSaveTagWithName:@"Business" inContext:self.context];

    
    Tag *family = [Tag createAndSaveTagWithName:@"Family" inContext:self.context];
    
    
    Tag *personal = [Tag createAndSaveTagWithName:@"Personal" inContext:self.context];
    
    
    // if we have custom tags, we need to fetch all tags from core data here.
    
    [self.tagNames addObjectsFromArray:@[business, family, personal]];
    

    
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
    
    if ([self.selectedTags containsObject:individual]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Tag *individual = self.tagNames[indexPath.row];
    
    if ([self.selectedTags containsObject:individual]) {
    
        [self.selectedTags removeObject:individual];
        
        //    [tableView cellForRowAtIndexPath:indexPath]; // BAD WAY!
        
    } else {
    
        [self.selectedTags addObject:individual];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    

}


- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sumbitButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.context];
    
    receipt.note = self.descriptionTextField.text;
    receipt.amount = @([self.amountTextField.text doubleValue]);
    
    receipt.timeStamp = self.datePicker.date;
    
    [receipt addTags:self.selectedTags];
    
    [self.context save:NULL];
    
}

@end
