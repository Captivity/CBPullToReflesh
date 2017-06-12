//
//  ViewController.swift
//  CBPullToRefleshDemo
//
//  Created by 陈超邦 on 2017/6/11.
//  Copyright © 2017年 cbangchen. All rights reserved.
//

import UIKit
import CBPullToReflesh

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bodyView = UIView()
        bodyView.frame = self.view.frame
        bodyView.frame.origin.y += 20 + 60
        self.view.addSubview(bodyView)
        
        let headerView_up = UIView()
        headerView_up.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 20)
        headerView_up.backgroundColor = UIColor.init(red: 55/255, green: 110/255, blue: 201/255, alpha: 1)
        self.view.addSubview(headerView_up)
        
        let headerView_down = UIView()
        headerView_down.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 60)
        headerView_down.backgroundColor = UIColor.init(red: 66/255, green: 132/255, blue: 243/255, alpha: 1)
        self.view.addSubview(headerView_down)
        
        let tableView = SampleTableView(frame: self.view.frame, style: UITableViewStyle.plain)
        let tableViewWrapper = CBPullToRefleshView(scrollView: tableView)
        bodyView.addSubview(tableViewWrapper)
        
        tableViewWrapper.didPullToRefresh = {
            _ = Timer.schedule(delay: 2) { timer in
                tableViewWrapper.endReflesh()
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class SampleTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(SampleCell.self, forCellReuseIdentifier: "SampleCell")
        self.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath) as! SampleCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}

class SampleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.selectionStyle = .none
        let iconMock = UIView()
        iconMock.backgroundColor = UIColor.white
        iconMock.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.size.width - 20, height: 75)
        self.addSubview(iconMock)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


