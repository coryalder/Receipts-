//
//  ViewController.m
//  Receipts++
//
//  Created by Adam DesLauriers on 2016-02-04.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "ViewController.h"
#import "LHLCoreDataStack.h"
#import "addReceiptViewController.h"
#import "Tag+CoreDataProperties.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) LHLCoreDataStack *coreData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coreData = [LHLCoreDataStack new];
    Tag *business = [Tag createAndSaveTagWithName:@"Business" inContext:self.coreData.context];
    
    NSLog(@"%@ hbuhhjb", business.tagName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAddNewReceipt"]) {
        
        addReceiptViewController *controller = [segue destinationViewController];
        
        NSManagedObjectContext *cont = self.coreData.context;
        
        
        [controller setContext:cont];

        
        
    }
    
    
}

@end
