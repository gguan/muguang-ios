//
//  MGAPIManager.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/24/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

var apiURL:String = "http://ec2-54-223-171-74.cn-north-1.compute.amazonaws.com.cn:9000"

//typealias successBlock = (AFHTTPRequestOperation! ,AnyObject!)-> (Void)
//typealias failureBlock = (AFHTTPRequestOperation, NSError!) -> (Void)
//

class MGAPIManager: AFHTTPRequestOperationManager {
    
    static let sharedInstance = MGAPIManager(url: NSURL(string: apiURL)!)
    
    init(url:NSURL)
    {
        super.init(baseURL: url)
        
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func requestData(urlString:String, completion:(data:NSArray?, error:NSError?) -> ())
    {
        var operation = self.GET(urlString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                completion(data: (responseObject as! NSArray), error: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                completion(data: nil, error: error)
            }
        )
    }
    
    let s: successBlock = {(operation, json) in
    }
}
