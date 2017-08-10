//
//  Tools.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/8.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height

let SCREEN_RECT = UIScreen.main.bounds

//设置颜色
func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor {return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)}

//设置字体大小
func FONT(size:CGFloat,isBold: Bool=false)->UIFont {
    if isBold{
        return UIFont.boldSystemFont(ofSize: size)
    }else{
        return UIFont.systemFont(ofSize: size)
    }
}

//设置Plus的字号，字体名称，其他机型自适应
func FONT(sizePlus:CGFloat,isBold: Bool=false)->UIFont{
    if SCREEN_WIDTH == 375{return FONT(size: CGFloat((375.0/414))*sizePlus,isBold: isBold)}
    if SCREEN_WIDTH == 320{return FONT(size: CGFloat((320.0/414))*sizePlus,isBold: isBold)}
    return FONT(size: sizePlus)
}

//输入跟屏宽的比，得到对应的距离
func GET_DISTANCE(ratio:Float)->CGFloat{
    let distance = SCREEN_WIDTH*CGFloat(ratio)
    return distance
}

extension CGRect{
    func getMaxY()->CGFloat{
        return self.origin.y+self.size.height
    }
}
