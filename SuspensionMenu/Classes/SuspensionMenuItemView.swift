//
//  SuspensionMenuItemView.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/9.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import UIKit

class SuspensionMenuItemView: UIView {
    var btn:UIButton!
    var imgV:UIImageView!
    var titleLab:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect,imgName:String?,title:String?) {
        self.init(frame: frame)
        
        imgV = UIImageView(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        imgV.contentMode = .center
        if let tmpImgName = imgName{
            if let img = UIImage.init(named: tmpImgName){
                self.imgV.image = img
            }else{
                let path = Bundle.main.resourcePath?.appending("/Resources.bundle/默认图")
                
                imgV.image = UIImage.init(contentsOfFile: path!)
            }
        }
        self.addSubview(imgV)
        
        titleLab = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.width, width: frame.size.width, height: frame.size.height-frame.size.width))
        titleLab.textAlignment = .center
        titleLab.text = title
        titleLab.textColor = RGBA(r: 100, g: 100, b: 100, a: 1)
        titleLab.font = FONT(size: 17)
        self.addSubview(titleLab)
        
        btn = UIButton(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        btn.setTitle(nil, for: .normal)
        self.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
