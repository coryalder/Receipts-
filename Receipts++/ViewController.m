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
@property (nonatomic, strong) NSArray *tags;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coreData = [LHLCoreDataStack new];
    
    
    [self loadReceipts];
    
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    [self loadReceipts];

}


-(void)loadReceipts {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:self.coreData.context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tagName"
                                                                   ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreData.context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        NSLog(@"oh crap...");
        
    }
    
    
    self.tags = fetchedObjects;
    
    for (Tag *aTag in self.tags) {
        
        aTag.sortedReceipts = nil;
    }
    
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.tags.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    Tag *aTag = self.tags[section];
    return aTag.receipts.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Tag *aTag = self.tags[indexPath.section];
    
    
    if (!aTag.sortedReceipts) {
        
        NSArray *sortedReceipts = [[aTag.receipts allObjects] sortedArrayUsingComparator:^NSComparisonResult(Receipt *obj1, Receipt * obj2) {
            
            return [obj1.timeStamp compare:obj2.timeStamp];
            
        }];
        
        aTag.sortedReceipts = sortedReceipts;
        
    }
    
    NSArray *receipts = aTag.sortedReceipts;
    Receipt *receipt = receipts[indexPath.row];
    
    cell.textLabel.text = receipt.note;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Tag *aTag = self.tags[section];
    return aTag.tagName;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAddNewReceipt"]) {
        
        addReceiptViewController *controller = [segue destinationViewController];
        
        NSManagedObjectContext *cont = self.coreData.context;
        
        
        [controller setContext:cont];

        
        
    }
    
    
}

@end
