//
//  MGAPIManagerExt+Share.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/30/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

extension MGAPIManager {
    
    /*
     *  分享到微博 没用啦 改成服务器端发送了
     **/
    func weiboShare(Status: String,
                       pic: UIImage,
                   success: ((AFHTTPRequestOperation!,AnyObject!)-> Void)!,
                   failure: ((AFHTTPRequestOperation!, NSError!) -> Void)!) {
    
                let url = "https://upload.api.weibo.com/2/statuses/upload.json"
                let parameter = ["status":"这是一条目光测试","pic":"test.png"]
                self.POST(url, parameters: parameter, success:success , failure: failure)
    
    }
}