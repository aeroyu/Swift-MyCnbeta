//
//  NewService.swift
//  cnbeta
//
//  Created by jan on 16/2/6.
//  Copyright © 2016年 org. All rights reserved.
//

import Foundation
import Alamofire
class NewsService{
    //http://api.cnbeta.com/capi?app_key=10000&end_sid=473041&format=json&method=Article.Lists&timestamp=1454600999235&topicid=null&v=1.0&mpuffgvbvbttn3Rc&sign=20172f6779a21c1faa755a022fe87a83
    
    static func getNewsListFormServer(lastSid:String?,succeedCallback: ([News])->Void) {
        var params=[String:String]()
        if let lastSid=lastSid{
            params["end_sid"] = lastSid
        }
        let requestUrl = RequestApi.getUrl(RequestApi.News,newActionType: NewActionType.Lists,extParams: params)
//        print("requestUrl:",requestUrl)
        var result = [News]()
        Alamofire.request(.GET, requestUrl)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                
                if let responsData = response.result.value {
                    if let status = responsData["status"] , list = responsData["result"] as? Array<Dictionary<String,String>>{
                        if status as! String == "success"{
                            for newItem in list{
                                result.append(News(sid: newItem["sid"]!,title:newItem["title"]!,time:newItem["pubtime"]!,topicLogo:newItem["topic_logo"]!))
                            }
                            succeedCallback(result)
                        }
                        
                    }else{
                        //获取失败
                    }
                }
        }
        
    }
}
