//
//  ViewController.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/8.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        SuspensionMenu.ShowSuspensionMenuWith(titles: nil, imgs: nil, selectBlock: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dealShow(_ sender: Any) {
        let titles = ["title0","title1","title2","title3","title4","title5","title6","title7","title8"]
        let imgs = ["默认图","默认图","默认图","默认图","默认图","默认图","默认图","默认图","默认图"]
        SuspensionMenu.ShowSuspensionMenuWith(titles: titles, imgNames: imgs) { (i) in
            print("点击了第"+"\(i)"+"个选项")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
}

