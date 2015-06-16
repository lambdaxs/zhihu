//
//  SecondViewController.swift
//  zhihu
//
//  Created by xiaos on 15/5/31.
//  Copyright (c) 2015年 xiaos. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    

    var newsId:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 0.8)
        
        
        //设置返回按钮
        func initBackBtn(){
            let btn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            btn.frame = CGRect(x: 0, y: 20, width: 40, height: 20)
            btn.setTitle("back", forState: UIControlState.Normal)
            btn.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tintColor = UIColor.whiteColor()
            self.view.addSubview(btn)
        }
        
        
        //设置UIWebview
        func initWebview(){
            let myWeb = UIWebView()
            myWeb.frame=CGRect(x: 0, y: 40, width: self.view.bounds.width, height: self.view.bounds.height-40)
            myWeb.scalesPageToFit = false
            self.view.addSubview(myWeb)
            
            //从model获取数据并用webview显示
            var newsData = NewsData()
            newsData.getData(newsId!)
            var html = newsData.html
            myWeb.loadHTMLString(html, baseURL: nil)
        }
        
        
        initBackBtn()
        initWebview()
        
        
        
        
        
        
       
        
    }
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
