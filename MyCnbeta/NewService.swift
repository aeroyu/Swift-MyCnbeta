//
//  NewService.swift
//  cnbeta
//
//  Created by jan on 16/2/6.
//  Copyright © 2016年 org. All rights reserved.
//

class NewsService{
    //http://api.cnbeta.com/capi?app_key=10000&end_sid=473041&format=json&method=Article.Lists&timestamp=1454600999235&topicid=null&v=1.0&mpuffgvbvbttn3Rc&sign=20172f6779a21c1faa755a022fe87a83
    
    static func getNewsListFormServer(lastSid:String?,succeedCallback: ([News])->Void) {
        var params=[String:String]()
        if let lastSid=lastSid{
            params["end_sid"] = lastSid
        }
        let requestUrl = RequestApi.getUrl(RequestApi.News,newActionType: NewActionType.Lists,extParams: params)
        
        var result = [News]()
        NetworkHelper.getHttpRequest(requestUrl, succeedCallback : { (responseData) in
            if let list = responseData as? Array<Dictionary<String,String>>{
                for newsItem in list{
                    result.append(News(sid: newsItem["sid"]!,title:newsItem["title"]!,time:newsItem["pubtime"]!,topicLogo:newsItem["topic_logo"]!))
                }
                succeedCallback(result)
            }
        })
    }
    //http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.NewsContent&sid=473045&timestamp=1454601017118&v=1.0&mpuffgvbvbttn3Rc&sign=78fd5b7b5bad1edaf15ce396212943ef
    static  func getNewsDeatils(sid:String,succeedCallback: (News)->Void){
        let requestUrl = RequestApi.getUrl(RequestApi.News,newActionType: NewActionType.Detail,extParams: ["sid":sid])
        NetworkHelper.getHttpRequest(requestUrl, succeedCallback : { (responseData) in
            if let newsItem = responseData as? Dictionary<String,String>{
                
                succeedCallback(News(sid: newsItem["sid"]!,title:newsItem["title"]!,homeText:newsItem["hometext"]!,bodyText:newsItem["bodytext"]!,time:newsItem["time"]!,source:newsItem["source"]!))
            }
        })
    }
    
    
    
}
