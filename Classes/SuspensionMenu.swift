//
//  SuspensionMenu.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/8.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import UIKit

//为何这个open关键字也消失
open class SuspensionMenu: NSObject {
    override init() {
        super.init()
    }
    //为何这个关键字也消失
    public static func ShowSuspensionMenuWith(titles:[String]?,imgNames:[String]?,selectBlock:((_ index:Int)->Void)?){
        //创建
        let supensionMenuContainView = SupensionMenuContainView.init(titles: titles, imgNames: imgNames, selectBlock: selectBlock)
        UIApplication.shared.delegate?.window??.addSubview(supensionMenuContainView)
    }
}
