//
//  MGAPIManagerExt+User.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/24/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

typealias successBlock = (AFHTTPRequestOperation! ,AnyObject!)-> Void
typealias failureBlock = (AFHTTPRequestOperation, NSError!) -> Void



extension MGAPIManager {
    
    /**
    *   获取新浪微博信息(Also 这是一个closure范例）
    */

    func sinaAuthInfo (uid:String, accessToken:String, success:((AFHTTPRequestOperation!,AnyObject!)-> Void)!, failure:((AFHTTPRequestOperation!, NSError!) -> Void)!){
        
        let path = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["source":"3927488598",
                             "uid":"5579713750",
                    "access_token":"2.00DgnJwBTzIMHB0fed984c200mboHf"]
        
        self.GET(path, parameters: parameters, success: success, failure: failure)
    }
    
//    func sinaUserInfo (success: (successBlock)! = nil, failure: (failureBlock)!=nil) {
//        let path = "https://api.weibo.com/2/users/show.json"
//        let parameters = ["source":"3927488598","uid":"5579713750","access_token":"2.00DgnJwBTzIMHB0fed984c200mboHf"]
//        self.GET(path, parameters: parameters, success: success, failure: failure)
//    }
    
}