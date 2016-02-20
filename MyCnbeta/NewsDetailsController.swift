//
//  NewsDetailsController.swift
//  MyCnbeta
//
//  Created by jan on 16/2/7.
//  Copyright © 2016年 JanStudio. All rights reserved.
//
import UIKit

class NewsDetailsController: UIViewController{
    @IBOutlet weak var loadingSpin: UIActivityIndicatorView!
    
    var sid : String?
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSorce: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newBodyWebView: UIWebView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
   
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleLoadingSpin(true)
        loadNewsDetails()
        setBarStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func loadNewsDetails(){
        if let sid = sid{
            NewsService.getNewsDeatils(sid,succeedCallback:  { (newsModel) in
//                self.newsTitle.text = newsModel.title
//                self.newsSorce.text = newsModel.source
//                self.newsDate.text = newsModel.time
                self.newBodyWebView.loadHTMLString(newsModel.htmlBody!, baseURL: nil)
                self.commentCount.text = String(newsModel.commentCount!)
                self.toggleLoadingSpin(false)
                
                
            })
        }
    }
    
    func toggleLoadingSpin(flag : Bool = true){
        if flag{
            loadingSpin.startAnimating()
            loadingSpin.hidesWhenStopped=true
        }else{
            loadingSpin.stopAnimating()
        }
    }
    
    func setBarStyle(){
//      self.navigationController?.navigationBarHidden = true
        
        backBtn.setFAIcon(FAType.FAArrowCircleOLeft,forState: UIControlState.Normal)
        favBtn.setFAIcon(FAType.FAStar,forState: UIControlState.Normal)
        commentBtn.setFAIcon(FAType.FAComment,forState: UIControlState.Normal)
    
    }
}
