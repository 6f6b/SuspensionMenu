//
//  SuspensionMenu.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/8.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import UIKit

open class SuspensionMenu: NSObject {
    override init() {
        super.init()
    }
    public static func ShowSuspensionMenuWith(titles:[String]?,imgNames:[String]?,selectBlock:((_ index:Int)->Void)?){
        //创建
        let supensionMenuContainView = SupensionMenuContainView.init(titles: titles, imgNames: imgNames, selectBlock: selectBlock)
        UIApplication.shared.delegate?.window??.addSubview(supensionMenuContainView)
    }
}
