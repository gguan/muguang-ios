//
//  MGAPIManagerExt+Status.swift
//  MuGuangIOS
//
//  Created by William Hu on 5/4/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

extension MGAPIManager {
    
    /**
    * 发布状态（必须包含照片和地理信息）
    */
    
    
    /*
    参数类型：
    {
    "type": "photo",
    "photos": ["img_url1", "img_url2"],
    "status": "#国哈哈 asdf",
    "altitude": 111.111,
    "location": {
    "type": "Feature",
    "geometry": {
    "type": "Point",
    "coordinates": [
    151.2111,
    -33.86
    ]
    },
    "properties": {
    "name": "Sydney"
    }
    }
    }
    */
    
    func publishStatus(parameters: NSDictionary,
                          success:((AFHTTPRequestOperation!, AnyObject!)-> Void)!,
                          failure:((AFHTTPRequestOperation!, NSError!) -> Void)!)
    {
        
        let path       = "/api/v1/post"
        
        let parameters =
        
                        [       "type":"photo",
                              "photos": ["img_url1", "img_url2"],
                              "status": "#国哈哈 asdf",
                            "altitude": 111.111,
                            "location": [
                                "type": "Feature",
                                "geometry": [
                                    "type": "Point",
                                    "coordinates": [151.2111,-33.86]
                                ],
                                "properties": ["name": "Sydney"]
                        ]]
                        
        self.POST(path, parameters: parameters, success: success, failure: failure)
    }

}

