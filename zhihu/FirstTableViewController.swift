//
//  FirstTableViewController.swift
//  zhihu
//
//  Created by xiaos on 15/5/25.
//  Copyright (c) 2015年 xiaos. All rights reserved.
//

import UIKit
import Chun



class FirstTableViewController: UITableViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    
    
    //标题数据对象
    var myModel = TitleData()
    var tlist = [String]()
    var ilist = [String]()
    var idlist = [Int]()
    //顶部数据对象
    var topModel = TopData()
    
    //下拉刷新对象
    var refresh = UIRefreshControl()
//    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //获取顶部视图数据
        func initTop(){
            topModel.getData()
            self.scrollview.pagingEnabled = true 
            self.scrollview.delegate = self
            var numOfImages = 5
            for i in 0..<numOfImages{
                
                
                
                let imgview = UIImageView(frame: CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.view.bounds.width, height: 220))
                imgview.setImageWithURL(NSURL(string: topModel.imgurlList[i])!)
                self.scrollview.addSubview(imgview)
                
                let shadowView = UIView(frame: CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.view.bounds.width, height: 220))
                shadowView.backgroundColor = UIColor(patternImage: UIImage(named: "shadow2")!)
//                shadowView.backgroundColor = UIColor.redColor()
                self.scrollview.addSubview(shadowView)
                
                let topTitle = UILabel(frame: CGRect(x: self.view.bounds.width * CGFloat(i) + 10, y: 130, width: self.view.bounds.width - 20, height: 80))
                topTitle.text = topModel.titleList[i]
                topTitle.textColor = UIColor.whiteColor()
                topTitle.font = UIFont(name: "Helvetica Neue", size: 22)
                topTitle.lineBreakMode = .ByWordWrapping
                topTitle.adjustsFontSizeToFitWidth = true
                topTitle.numberOfLines = 0
                scrollview.addSubview(topTitle)
                
                

            }
            
            

            //隐藏滑动视图的水平指示器
            self.scrollview.showsHorizontalScrollIndicator = false
            
            self.scrollview.contentSize = CGSizeMake(self.view.bounds.width * CGFloat(numOfImages), 0)
            self.view.addSubview(scrollview)
            
            self.pageControl.numberOfPages = numOfImages
            self.pageControl.center = CGPointMake( (self.view.bounds.width/7) * 6, 220 - 10)
            self.view.addSubview(self.pageControl)
            
            

        }

        //初始化新闻标题主体数据
        func initNewsTitle(){
            myModel.getData()
            tlist = myModel.titleList
            ilist = myModel.imgurlList
            idlist = myModel.idList
        }

        //下拉刷新设置
        func initRefresh(){
            self.automaticallyAdjustsScrollViewInsets = false
            refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
            refresh.attributedTitle = NSAttributedString(string: "加载中...")
            self.tableView.addSubview(refresh)
        }
        
        initRefresh()
        initTop()
        initNewsTitle()
        
        //隐藏tableview的竖向指示器
        self.tableView.showsVerticalScrollIndicator = false
        
    }
    
    
    //下拉刷新函数
    func reload(){
        //移除原数组中的内容
        myModel.titleList.removeAll(keepCapacity: true)
        myModel.imgurlList.removeAll(keepCapacity: true)
        myModel.idList.removeAll(keepCapacity: true)
        
        //重新载入数据，初始化api数据，刷新表格视图
        myModel.getData()
        tlist = myModel.titleList
        ilist = myModel.imgurlList
        idlist = myModel.idList
        self.tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//实现scrollview的代理方法
extension FirstTableViewController:UIScrollViewDelegate {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollview.frame.size.width 
        let x:CGFloat = scrollview.contentOffset.x 
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW) 
        self.pageControl.currentPage = page 
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var index = scrollView.contentOffset.x / self.view.bounds.width
        pageControl.currentPage = Int(index)

    }
}


//实现tableview的代理方法
extension FirstTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tlist.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var str = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MyCell
        cell.Ntitle.text = self.tlist[indexPath.row]
        let imgUrl = NSURL(string: ilist[indexPath.row])
        cell.Nimg.setImageWithURL(imgUrl!, placeholderImage: UIImage(named: "qing"))
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let svc = SecondViewController()
        svc.newsId = self.idlist[indexPath.row]
        self.presentViewController(svc, animated: true, completion: nil)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
}
