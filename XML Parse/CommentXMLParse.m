//
//  CommentXMLParse.m
//  App
//
//  Created by leo on 9/24/12.
//
//

#import "CommentXMLParse.h"
#import "ErrorBean.h"
#import "CommentBean.h"  

@implementation CommentXMLParse

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
	

	
	for(cur_node = node;cur_node;cur_node = cur_node->next)
	{
		
		NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
		if([cur_name isEqual:@"status"])
		{
			NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
			_error.status= content;
		}else if([cur_name isEqual:@"message"])
		{
			if (cur_node->children != nil)  {
				NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
				_error.errorMessage= content;
			}else {
				_error.errorMessage = @"";
			}
		}else if([cur_name isEqual:@"merchanttype"])
		{
			
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
			
			
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
				if([@"merchanttypes" isEqual:cur2_name]){
                    CommentBean *comment = [[CommentBean alloc] init];
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"id" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment._id =[content intValue];
                                
                            }else {
                                comment._id=0;
                            }
                        }else if ([@"name" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.body =content;
                                
                            }else {
                                comment.body=@"";
                            }
                        }
                        
                    }
                    [_commentArr addObject:comment];
                    [comment release];
				}
			}

		}
	}
	xmlFreeDoc(doc);
	//[pool release];
	return YES;
}
@end
