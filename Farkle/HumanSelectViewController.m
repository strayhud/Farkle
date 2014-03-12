#import "HumanSelectViewController.h"

@interface HumanSelectViewController ()

@end

@implementation HumanSelectViewController

@synthesize playerName;
@synthesize opponentList;
@synthesize backButton;
@synthesize playButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (IBAction)playerNameEntered:(id)sender {
    [playerName resignFirstResponder];
}

- (IBAction)backPress:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)playPress:(id)sender {

}

- (void)fetchedData:(NSData *)responseData {
    
    NSLog(@"Data: %@", responseData);
    
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"];
    
    NSLog(@"loans: %@", latestLoans);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *btnLayer = [backButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [playButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    url = [NSURL URLWithString:@"http://localhost:3000/userlist"];
    
    [self parseJSONWithURL:url];
}

// Parse the JSON data from the given URL
- (void) parseJSONWithURL:(NSURL *) jsonURL
{
    // Set the queue to the background queue. We will run this on the background thread to keep
    // the UI Responsive.
    NSLog(@"Dispatching request: %@",jsonURL);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Run request on background queue (thread).
    NSLog(@"Running request on background queue");
    dispatch_async(queue, ^{
        NSStringEncoding encoding=0;
        NSError *error = nil;
        
        // Request the data and store in a string.
        NSLog(@"Requesting data...");
        NSString *json = [NSString stringWithContentsOfURL:jsonURL
                                              usedEncoding:encoding
                                                     error:&error];
        if (error == nil){
            
            // Convert the String into an NSData object.
            NSLog(@"Converting data...");
            NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
            
            NSString* str=[[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
            NSLog(@"%@",str);
            
            // Parse that data object using NSJSONSerialization without options.
            jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
            // Parsing success.
            if (error == nil)
            {
                // Go back to the main thread and update the table with the json data.
                // Keeps the user interface responsive.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    // userlist = [[jsonDict valueForKey:@"How I Met Your Mother"] valueForKey:@"userlist"];
                    userlist =[jsonDict valueForKey:@"userlist"];
                    [opponentList reloadData];
                });
            }
            
            // Parsing failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                
                [alertView show];
            }
        }
        
        // Request Failed, display error as alert.
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Request Error! Check that you are connected to wifi or 3G/4G with internet access." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            
            [alertView show];
        }
    });
}


// Delegate call back for cell at index path.
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableview called...");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    
    /* From original app...
     // Set the main label as the episode name.
     cell.textLabel.text = [[userlist objectAtIndex:indexPath.row] objectForKey:@"name"];
     
     // Episode number and season number will be parsed as numbers. Here we're going to make a string
     // that will be used as the details label that shows the episode number and season number.
     NSNumber *seasonNum = [[userlist objectAtIndex:indexPath.row] objectForKey:@"season"];
     NSNumber *episodeNum = [[userlist objectAtIndex:indexPath.row] objectForKey:@"number"];
     NSMutableString *seasonEpisodeNum = [NSMutableString stringWithFormat:@"Season: %@ ", seasonNum];
     [seasonEpisodeNum appendString:[NSMutableString stringWithFormat:@"Ep: %@", episodeNum]];
     cell.detailTextLabel.text = seasonEpisodeNum;
     */
    
    cell.textLabel.text = [[userlist objectAtIndex:indexPath.row] objectForKey:@"username"];
 //   cell.detailTextLabel.text = [[userlist objectAtIndex:indexPath.row] objectForKey:@"email"];
    
    return cell;
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected user=%@",[NSString stringWithString:[[[tableView cellForRowAtIndexPath:indexPath] textLabel]text]]);
    /*
    DetailViewController *detailController;
    
    // Setup a new view that will be for either iphone or ipad. This new view will show the details of
    // the cell that was tapped on (Name, season number, episode number).
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        detailController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:[NSBundle mainBundle]];
    } else {
        detailController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:[NSBundle mainBundle]];
    }
    
    // The new view has two strings, one for the episode name and one for the season number and episode number.
    detailController.strEpisodeDetails = [NSString stringWithString:[[[tableView cellForRowAtIndexPath:indexPath] detailTextLabel] text]];
    detailController.strEpisodeName = [NSString stringWithString:[[[tableView cellForRowAtIndexPath:indexPath] textLabel]text]];
    
    // Finally, animate in the new view that has the updated information for the cell that was tapped.
    [self.navigationController pushViewController:detailController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // ARC - Done with this view.
    detailController = nil;
     */
}

// Only one section in this table.
-(int) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 1;
}

// Each episode will have a different name and should have its own cell.
- (int) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [userlist count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
