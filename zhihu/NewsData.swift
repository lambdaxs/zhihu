//
//  NewsData.swift
//  zhihu
//
//  Created by xiaos on 15/5/31.
//  Copyright (c) 2015年 xiaos. All rights reserved.
//

import Foundation

class NewsData:NSObject{
    var html = String()
    
    //返回json数据
    func my_josn(http_url:String) -> NSDictionary{
        
        var url = NSURL(string:http_url)
        
        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions(), error: nil)
        
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
        
        return json!
    }
    
    func getData(newsId:Int){
        let url = "http://news-at.zhihu.com/api/3/news/\(newsId)"
        var josnDict = my_josn(url)
        self.html = josnDict.objectForKey("body")! as! String
        
    }

}