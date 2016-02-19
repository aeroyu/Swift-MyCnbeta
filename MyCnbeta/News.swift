//
//  News.swift
//  cnbeta
//
//  Created by jan on 16/2/6.
//  Copyright © 2016年 org. All rights reserved.
//

import Foundation

class News : NSObject{
    var sid : String
//    var topic : Int
    var title :String
    var topicLogo:String?
    var homeText :String?
    var thumb : String?
    var bodyText : String?
    var time : String
    var commentCount : Int?
    var source : String? {
        willSet{
            if let newValue = newValue{
                if newValue.hasPrefix("<a href"){
                    let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.CaseInsensitive])
                    
                    let range = NSMakeRange(0, newValue.characters.count)
                    let htmlLessString :String = regex.stringByReplacingMatchesInString(newValue, options: [],
                        range:range ,
                        withTemplate: "")
                   self.source = htmlLessString
                }
            }
        }
    }
    var htmlBody: String? {
        get{
            let css="<style>img{max-width:100%}</style>"
            
            var html=""
            html+=css
            html+="<div><h2>\(title)</h2></div>"
            html+="<div>\(source)</div>"
            html+="<div>\(time)</div>"
            html+="<hr/>"
            html+=bodyText!
            return html
        }
    }
    
    
    init(sid :String,title:String,homeText:String,bodyText:String,time:String,source:String,commentCount:Int){
        self.sid=sid
        self.title=title
        self.homeText=homeText
        self.bodyText=bodyText
        self.time=time
        self.source=source
        self.commentCount=commentCount
    }
    
    init(sid:String,title:String,time:String,topicLogo:String){
        self.sid=sid
        self.title=title
        self.time=time
        self.topicLogo=topicLogo
    }
    
}