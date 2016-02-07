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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleLoadingSpin(true)
        loadNewsDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewsDetails(){
        if let sid = sid{
            NewsService.getNewsDeatils(sid,succeedCallback:  { (newsModel) in
                self.newsTitle.text = newsModel.title
                self.newsSorce.text = newsModel.source
                self.newsDate.text = newsModel.time
                self.newBodyWebView.loadHTMLString(newsModel.bodyText!, baseURL: nil)
                
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
}
