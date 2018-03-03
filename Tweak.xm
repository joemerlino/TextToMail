@interface MFMessageWriter
-(id)createMessageWithString:(id)string headers:(id)headers;
@end

@interface MFMutableMessageHeaders
- (void)setHeader:(id)header forKey:(id)key;
- (void)setAddressList:(id)list forKey:(id)key;
- (void)setAddressListForTo:(id)arg1;
- (void)setAddressListForSender:(id)arg1;
@end

@interface MFOutgoingMessage
@end

@interface MFMailDelivery
+ (id)newWithMessage:(id)arg1;
- (void)setDelegate:(id)arg1;
- (int)deliverSynchronously;
- (void)deliverAsynchronously;
@end

static NSString* body = nil;
static NSString* email = nil;
static BOOL enabled = NO;

%hook BBBulletin
-(void)setSection:(NSString *)arg1{
        %orig;
	if([arg1 isEqualToString:@"com.apple.MobileSMS"]){
                NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.joemerlino.texttomailprefs.plist"];
                email = [prefs objectForKey:@"email"];
                enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : NO);
                if(enabled && email){
        		MFMessageWriter *messageWriter = [[%c(MFMessageWriter) alloc] init];
                        MFMutableMessageHeaders *headers = [[%c(MFMutableMessageHeaders) alloc] init];

                        [headers setHeader:@"TextToMail" forKey:@"subject"];
                        [headers setAddressListForTo:@[email]];
                        [headers setAddressListForSender:@[email]];

                        MFOutgoingMessage *message = [messageWriter createMessageWithString:body headers:headers];
                        MFMailDelivery *messageDelivery = [%c(MFMailDelivery) newWithMessage:message];

                        [messageDelivery setDelegate:self];
                        [messageDelivery deliverAsynchronously];
                }
	}
}
-(void)setMessage:(NSString *)arg1{
	body = arg1;
	%orig;
}
%end