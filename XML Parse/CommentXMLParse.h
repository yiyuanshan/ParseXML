//
//  CommentXMLParse.h
//  App
//
//  Created by leo on 9/24/12.
//
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class ErrorBean;
@class CommentBean;
@interface CommentXMLParse:NSObject{}

+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean *)_error;

@end
