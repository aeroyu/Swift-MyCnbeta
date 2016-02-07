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

class NewsListViewController: UIViewController , UITableViewDataSource{
    
    @IBOutlet weak var newsListTableView: UITableView!
    var newsList:[News] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        
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
    
    func bindingUISoruce(newsListLoaded : [News]){
        newsList = newsListLoaded
        newsListTableView.dataSource = self
        dispatch_async(dispatch_get_main_queue()) {
            
            self.newsListTableView.reloadData()
        }
        
    }
    
    func loadNews(){
        NewsService.getNewsListFormServer(nil,succeedCallback: bindingUISoruce)
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
    
}

