//
//  OlutosinTableViewController.m
//  Simple Track Playback
//
//  Created by Olubunmi Fashusi on 11/20/15.
//  Copyright © 2015 Your Company. All rights reserved.
//

#import "OlutosinTableViewController.h"
#import "Config.h"
#import "ViewController.h"
#import <Spotify/SPTDiskCache.h>

@interface OlutosinTableViewController () <SPTAudioStreamingDelegate>

@property (nonatomic, strong) SPTAudioStreamingController *player;
@property (nonatomic, strong) NSMutableArray *olutosin;

@end

@implementation OlutosinTableViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self handleNewSession];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)handleNewSession
{
    
    //my code -->
    [SPTSearch performSearchWithQuery:@"michael+jackson" queryType:SPTQueryTypeTrack offset:0 accessToken:nil callback:^(NSError *error, SPTListPage *results)
     {
         NSString *temp = [[NSString alloc] init];
         self.olutosin = [[NSMutableArray alloc] init];
         
         for (NSInteger i = 0 ; i < [[results items] count]; i++)
         {
             //[self.olutosin[i] addObject:@"hi"];
             
             temp = [NSString stringWithFormat:@"%@", [results.items[i] playableUri]];
             
             self.olutosin[i] =  temp;
             
             //self.olutosin[i] addObject([results.items[i] playableUri]);
         }
         
//         NSLog(@"count: %i",(int)results.totalListLength);
//         NSLog(@"results count: %lu",(unsigned long)results.items.count);
//         NSLog(@"%@", results.items);
//         NSLog(@"%@", [results.items[0] playableUri]);
//         NSURL *firstURIResult = [results.items[0] playableUri];
//         NSURL *trackURI = firstURIResult;
//         NSLog(@"%@", results.items[0]); // prints <SPTPartialTrack: 0x7fbb1a724da0>: Billie Jean - Single Version (spotify:track:5ChkMS8OtdzJeqyybCc9R5)
         
     }];
    
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    
    if (self.player == nil) {
        self.player = [[SPTAudioStreamingController alloc] initWithClientId:auth.clientID];
        self.player.playbackDelegate = self;
        self.player.diskCache = [[SPTDiskCache alloc] initWithCapacity:1024 * 1024 * 64];
    }
    
    [self.player loginWithSession:auth.session callback:^(NSError *error) {
        
        if (error != nil) {
            NSLog(@"*** Enabling playback got error: %@", error);
            return;
        }
        
        //[self updateUI];
        
//        NSURLRequest *playlistReq = [SPTPlaylistSnapshot createRequestForPlaylistWithURI:[NSURL URLWithString:@"spotify:user:cariboutheband:playlist:4Dg0J0ICj9kKTGDyFu0Cv4"]
//                                                                             accessToken:auth.session.accessToken
//                                                                                   error:nil];
//        
        
        
//        [[SPTRequest sharedHandler] performRequest:playlistReq callback:^(NSError *error, NSURLResponse *response, NSData *data) {
//            if (error != nil) {
//                NSLog(@"*** Failed to get playlist %@", error);
//                return;
//            }
        
//            SPTPlaylistSnapshot *playlistSnapshot = [SPTPlaylistSnapshot playlistSnapshotFromData:data withResponse:response error:nil];
//            
//
//        [self.player playURIs:playlistSnapshot.firstTrackPage.items fromIndex:0 callback:nil];
        }];
   // }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"in numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"in numberOfRowsInSection");
    
   
    
//    NSLog(@"count: %i",(int)results.totalListLength);
//    NSLog(@"results count: %lu",(unsigned long)results.items.count);
//    NSLog(@"%@", results.items);
//    NSLog(@"%@", [results.items[0] playableUri]);
//    NSURL *firstURIResult = [results.items[0] playableUri];
//    NSURL *trackURI = firstURIResult;
//    NSLog(@"%@", results.items[0]); // prints <SPTPartialTrack: 0x7fbb1a724da0>: Billie Jean - Single Version (spotify:track:5ChkMS8OtdzJeqyybCc9R5)
//
    return 1;
   // return [self.olutosin count];
    
    
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   // NSString *stringToPutInRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    
  //  NSString *spotifyElementToPutInRow = [NSString stringWithFormat:@"%@", [self.mySPTListPageResults.items[0] playableUri]];
    
   // NSString *spotifyElementToPutInRow = [NSString stringWithFormat:@"%@", [results.items[0] playableUri]];
   // cell.textLabel.text = spotifyElementToPutInRow ;
    
    //NSString *spotifyElementToPutInRow = self.olutosin[indexPath];
    cell.textLabel.text = self.olutosin[0];
    
    
//    NSString *stringToPutInRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
//    cell.textLabel.text = stringToPutInRow;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
