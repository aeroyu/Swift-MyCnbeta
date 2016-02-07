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

    init(sid :String,title:String,homeText:String,thumb:String,bodyText:String,time:String){
        self.sid=sid
        self.title=title
        self.homeText=homeText
        self.thumb=thumb
        self.bodyText=bodyText
        self.time=time
    }
    
    init(sid:String,title:String,time:String,topicLogo:String){
        self.sid=sid
        self.title=title
        self.time=time
        self.topicLogo=topicLogo
    }
    
}