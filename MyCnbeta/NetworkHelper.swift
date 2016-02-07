
//
//  NetworkHelper.swift
//  MyCnbeta
//
//  Created by jan on 16/2/7.
//  Copyright © 2016年 JanStudio. All rights reserved.
//
import Alamofire
class NetworkHelper{
    
    static func getHttpRequest(requestUrl:String,params : Dictionary<String,String>?=nil,succeedCallback : ((AnyObject)->Void)?=nil, failCallback : ((String)->Void)?=nil){
        print("requestUrl:",requestUrl)
        Alamofire.request(.GET, requestUrl).responseJSON { response in
            var flag=false
            if let responsData = response.result.value {
                if let status = responsData["status"] , result = responsData["result"]{
                    if status as! String == "success"{
                        if let succeedCallback = succeedCallback{
                            succeedCallback(result!)
                            flag=true
                        }
                    }
                    
                }else{
                    //获取失败
                    
                }
            }
            if(!flag){
                if let failCallback = failCallback  {
                    failCallback("获取失败")
                }
            }
        }
    }
}
