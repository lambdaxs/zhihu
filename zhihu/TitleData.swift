//
//  myData.swift
//  zhihu
//
//  Created by xiaos on 15/5/30.
//  Copyright (c) 2015年 xiaos. All rights reserved.
//

import Foundation

class TitleData {
    
    var titleList = [String]()
    var imgurlList = [String]()
    var idList = [Int]()
    
    //返回json数据
    func my_josn(http_url:String) -> NSDictionary{
        
        var url = NSURL(string:http_url)
        
        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions(), error: nil)
        
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
        
        return json!
    }
    
    func getData(){
        let url = "http://news-at.zhihu.com/api/3/news/latest"
        var josnDict = my_josn(url)
        var list = josnDict.objectForKey("stories")! as! NSArray
        for i in 0...list.count-1 {
            let dict = list[i] as! NSDictionary
            self.titleList.append(dict.objectForKey("title") as! String)
            self.idList.append(dict.objectForKey("id") as! Int)
            let imgurl = dict.objectForKey("images") as! NSArray
            self.imgurlList.append(imgurl[0] as! String)
        }
    }

    
    
    
    

    
    
    
}