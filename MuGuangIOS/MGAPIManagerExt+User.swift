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
    

    func sinaAuthInfo ( uid: String,
                accessToken: String,
                    success: ((AFHTTPRequestOperation!,AnyObject!)-> Void)!,
                    failure: ((AFHTTPRequestOperation!, NSError!) -> Void)!){
        
        let path        = "https://api.weibo.com/2/users/show.json"
        
        let parameters  = ["source":"3927488598",
                              "uid":"5579713750",
                     "access_token":"2.00DgnJwBTzIMHB0fed984c200mboHf"]
        
        self.GET(path, parameters: parameters, success: success, failure: failure)
    }
    
    
    /**
    *   注册用户
    *
    */
    
    /*
      参数范例
    "uid":"微博账号id",
    "oauth2_info":{
    "access_token": "必填",
    "token_type":"选填",
    "expires_in":"选填",
    "refresh_token":"选填"
    "}
    */
    

     func registerUser (uid: String!,
                accessToken: String!,
               refreshToken: String!,
                    success: ((AFHTTPRequestOperation!,AnyObject!)-> Void)!,
                    failure: ((AFHTTPRequestOperation!, NSError!) -> Void)!) {
        
                        
            let path       = "/api/v1/authenticate/weibo"
            
            let parameters = [          "uid":uid,
                "oauth2_info":[//"access_token":accessToken,
                                              "refresh_token":refreshToken]
                             ]
                  
            self.POST(path, parameters: parameters, success: success, failure: failure)
    }
    
    
    // TODO:
    /**
    *
    * 获取七牛Token
    */
    
    func qiniuUploadToken(success:((AFHTTPRequestOperation!, AnyObject!) -> Void)!,
                          failure:((AFHTTPRequestOperation!, NSError!) -> Void)!) {
        
            let path = "api/v1/upToken/bucket"
    
            self.GET(path, parameters: nil, success: success, failure: failure)
    }

 
    /**
    *
    * 更新Token
    */
    
    /**
    *   参数范例
        {
        "user_id":"552fsff1099415239016b432d",
        "refresh_token":"5gm2q956scjhkrum4400jlr6f9"
        }
    */
    
    func updateTokenByUserIdentifer(userIdentifer: String,
                                     refreshToken: String,
                                          success:((AFHTTPRequestOperation!,AnyObject!) -> Void)!,
                                          failure:((AFHTTPRequestOperation!, NSError!) -> Void)!) {
                                        
            let path       = "/api/v1/renewToken"
            let parameters = ["user_id":userIdentifer,"refresh_token":refreshToken]
            self.POST(path, parameters: parameters, success: success, failure: failure)
                                            
    }
    
    
/*
    func getUserInfo(success: successBlock, failure: failureBlock) {
        let path       = "/api/v1/authenticate/weibo" as String!
        self.GET(path, (parameters: ["key":"value"]) as AnyObject!, success: success, failure: failure)
    }
*/
}