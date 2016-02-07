//
//  RequestApi.swift
//  cnbeta
//
//  Created by jan on 16/2/6.
//  Copyright © 2016年 org. All rights reserved.
//

import CryptoSwift
//http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.NewsContent&sid=473045&timestamp=1454601017118&v=1.0&mpuffgvbvbttn3Rc&sign=78fd5b7b5bad1edaf15ce396212943ef
//http://api.cnbeta.com/capi?app_key=10000&end_sid=473041&format=json&method=Article.Lists&timestamp=1454600999235&topicid=null&v=1.0&mpuffgvbvbttn3Rc&sign=20172f6779a21c1faa755a022fe87a83
enum RequestApi :String {
    case News="http://api.cnbeta.com/capi"
    
    static func getUrl(apiEnmu : RequestApi,newActionType : NewActionType,extParams:[String:String]=[String:String]())->String{
        let date = NSDate()
        let timeSecondsStr=(floor(date.timeIntervalSince1970 * 1000))
        let privateKey="mpuffgvbvbttn3Rc"
        var endSid=""
        var extParamsStr = [String]()
        for (k , v) in extParams{
            if(k=="end_sid"){
                endSid="end_sid=\(v)&"
            }else{
                extParamsStr.append("\(k)=\(v)")
                
            }
        }
        
        
        let parmsWithSign = "app_key=10000&\(endSid)format=json&method=\(newActionType.rawValue)&\(extParamsStr.joinWithSeparator("&"))timestamp=\(timeSecondsStr)&topicid=null&v=1.0&\(privateKey)"
        let signStr = parmsWithSign.md5()
        return "\(apiEnmu.rawValue)?\(parmsWithSign)&sign=\(signStr)"
        
    }
}

enum NewActionType:String{
    case Lists = "Article.Lists"
    case Detail = "Article.NewsContent"
    case Comment = "Article.Comment"
}