//
//  ViewController.swift
//  cnbeta
//
//  Created by jan on 16/2/6.
//  Copyright © 2016年 org. All rights reserved.
//

import UIKit
import Alamofire
import ImageLoader
import XWSwiftRefresh

class NewsListViewController: UIViewController , UITableViewDataSource{
    
    @IBOutlet weak var newsListTableView: UITableView!
    var newsList:[News] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        tableViewEventBind()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return newsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.newsListTableView.dequeueReusableCellWithIdentifier("newsListCell")! as UITableViewCell
        let newsItem = newsList[indexPath.row]
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = newsItem.title
        (cell.viewWithTag(2) as! UILabel).text = newsItem.time
        let logoImg = (cell.viewWithTag(3) as! UIImageView)
        
        logoImg.load(newsItem.topicLogo ?? "")
        logoImg.layer.cornerRadius = logoImg.frame.width / 2
        logoImg.layer.masksToBounds = true
        logoImg.layer.borderColor = UIColor.blueColor().CGColor
        logoImg.layer.borderWidth = 2
        //        logoImg.clipsToBounds = true
        return cell
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 55
    //    }
    
    func bindingUISoruce(newsListLoaded : [News],isInit:Bool=true){
        if isInit{
            newsList = newsListLoaded
        }else{
            newsList.appendContentsOf(newsListLoaded)
        }
        
        newsListTableView.dataSource = self
        dispatch_async(dispatch_get_main_queue()) {
            
            self.newsListTableView.reloadData()
        }
        
    }
    
    func loadNews(lastSid:String?=nil,callback : (()->Void)?=nil ){
        NewsService.getNewsListFormServer(lastSid,succeedCallback: { newsListLoaded in
            self.bindingUISoruce(newsListLoaded,isInit: lastSid==nil)
            if let callback=callback{
                callback()
            }
        } )
    }
    
    func tableViewEventBind(){
        print("!!!2")

        self.newsListTableView.headerView = XWRefreshNormalHeader(target: self, action: "upPullLoadData")
        self.newsListTableView.footerView = XWRefreshAutoNormalFooter(target: self, action: "downPlullLoadData")
        
    }
    
    func upPullLoadData(){
        loadNews(nil,callback: { self.newsListTableView.headerView?.endRefreshing()})
    }
    
    func downPlullLoadData(){
        print("!!!1")
        loadNews(newsList.last?.sid,callback: {self.newsListTableView.footerView?.endRefreshing()})
        //self.newsListTableView.footerView?.endRefreshing()
        
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="goToNewsDetails"{
            let vc = segue.destinationViewController as! NewsDetailsController
            let indexPath = newsListTableView.indexPathForSelectedRow
            if let index = indexPath {
                vc.sid = newsList[index.row].sid
            }
        }
    }
    
    @IBAction func unwindToRed(segue: UIStoryboardSegue) {
    }
    
}

