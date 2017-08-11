//
//  SupensionMenuContainView.swift
//  SuspensionMenu
//
//  Created by YunKuai on 2017/8/8.
//  Copyright © 2017年 dev.liufeng@gmail. All rights reserved.
//

import UIKit

class SupensionMenuContainView: UIVisualEffectView {
    var itemBlock:((_ index:Int)->Void)?
    var scrollView:UIScrollView!
    var pageControl:UIPageControl?
    var cancelBtn:UIButton!
    var itemViews = [SuspensionMenuItemView]()
    var itemCount = 0
    
    //存放菜单选项的区域高度
    let itemRegionHeight = GET_DISTANCE(ratio: 400.0/640)
    //
    let scrollViewWidth = SCREEN_WIDTH
    //菜单选项区域的起始Y坐标
    let itemRegionStartY = SCREEN_HEIGHT*(460.0/1134)
    //菜单单个选项宽高比
    let itemWidthHeightRatio = 0.6
    //菜单上排与下排的间隔
    let itemVerticalSpace = CGFloat(30.0)
    //菜单选项水平间距
    var itemHorizontalSpace = CGFloat(0.0)
    //阻尼系数
    let dampingRatio = CGFloat(0.8)
    //到达终点的速度
    let velocity = CGFloat(3)
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    convenience init(titles:[String]?,imgNames:[String]?,selectBlock:((_ index:Int)->Void)?) {
        self.init(effect: nil)
        self.frame = SCREEN_RECT
        let blur = UIBlurEffect(style: .light)
        self.alpha = 1
        self.effect = blur
        self.itemBlock = selectBlock
        itemHorizontalSpace = (scrollViewWidth-(itemRegionHeight-CGFloat(itemVerticalSpace))*CGFloat(itemWidthHeightRatio/2)*4)/5.0
        
        if let tmpTitles = titles,let tmpImgNames = imgNames{
            itemCount = tmpTitles.count>tmpImgNames.count ? tmpImgNames.count:tmpTitles.count
        }
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: CGFloat(itemCount/8+1)*SCREEN_WIDTH, height: itemRegionHeight)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        for i in 0..<itemCount{
            let itemViewHeight = (itemRegionHeight-itemVerticalSpace)/2.0
            let itemViewWidth = (scrollViewWidth-5*itemHorizontalSpace)/4.0
            let itemViewX = scrollViewWidth*CGFloat(i/8)+itemHorizontalSpace*CGFloat(i%4+1)+itemViewWidth*CGFloat(i%4)
            
            var itemViewY = ((i/4)%2 == 0 ? 0 : (itemViewHeight+30))+itemRegionStartY
            if i/8 == 0{
                itemViewY += (SCREEN_HEIGHT-self.itemRegionStartY)
            }
            
            let itemView = SuspensionMenuItemView(frame: CGRect.init(x: itemViewX, y: itemViewY, width: itemViewWidth, height: itemViewHeight), imgName: imgNames?[i], title: titles?[i])
            itemView.btn.tag = i
            itemView.btn.addTarget(self, action: #selector(dealTapItem(btn:)), for: .touchUpInside)
            self.itemViews.append(itemView)
            self.scrollView.addSubview(itemView)
        }
        
        cancelBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        cancelBtn.center = self.center
        var frame = cancelBtn.frame
        frame.origin.y = SCREEN_HEIGHT-60
        cancelBtn.frame = frame
        let path = Bundle.main.resourcePath?.appending("/Resources.bundle/取消 (1)")
        let image = UIImage.init(contentsOfFile: path!)
        cancelBtn.setImage(image, for: .normal)
        cancelBtn.contentMode = .center
        cancelBtn.addTarget(self, action: #selector(dealCanceled), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        if itemCount>8{
            pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH*0.5, height: 5))
            pageControl?.numberOfPages = itemCount/8+1
            pageControl?.pageIndicatorTintColor = UIColor.white
            pageControl?.currentPageIndicatorTintColor = UIColor.orange
            pageControl?.center = self.center
            var frame = pageControl?.frame
            frame?.origin.y = self.cancelBtn.frame.origin.y - 20
            pageControl?.frame = frame!
            self.addSubview(pageControl!)
            pageControl?.addTarget(self, action: #selector(dealTap(pageControl:)), for: .valueChanged)
        }
        
        self.show()
        
    }
    
    func dealTap(pageControl:UIPageControl){
        var contentOffset = self.scrollView.contentOffset
        contentOffset.x = scrollViewWidth*CGFloat(pageControl.currentPage)
        UIView.animate(withDuration: 0.5) { 
            self.scrollView.contentOffset = contentOffset
        }
    }
    
    func dealTapItem(btn:UIButton){
        self.hiddenWith(pageNum: btn.tag/8)
        if let tmpBlock = self.itemBlock{
            tmpBlock(btn.tag)
        }
    }
    
    func dealCanceled(){
        let currentPage = scrollView.contentOffset.x/scrollViewWidth
        self.hiddenWith(pageNum: Int(currentPage))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hiddenWith(pageNum:Int){
        var delayTime = 0.0
        let duration = 0.2
        for i in (pageNum*8+4)..<(pageNum*8+8){
            let num = (pageNum*8+4)+(pageNum*8+8-i)
            let bottomNum = num-1
            if bottomNum<itemViews.count{
                let itemView = itemViews[bottomNum]
                UIView.animate(withDuration: duration, delay: delayTime, options: .curveLinear, animations: { 
                    var frame = itemView.frame
                    frame.origin.y += (SCREEN_HEIGHT-self.itemRegionStartY)
                    itemView.frame = frame
                }, completion: nil)
                delayTime += 0.05
            }
            let upNum = bottomNum-4
            if upNum<itemViews.count{
                let itemView = itemViews[upNum]
                UIView.animate(withDuration: duration, delay: delayTime, options: .curveLinear, animations: {
                    var frame = itemView.frame
                    frame.origin.y += (SCREEN_HEIGHT-self.itemRegionStartY)
                    itemView.frame = frame
                    if upNum%8 == 0{
                        self.alpha = 0
                    }
                }, completion: { _ in
                    if upNum%8 == 0{
                        self.removeFromSuperview()
                    }
                })
                delayTime += 0.05
            }
        }
    }
    
    func show(){
        let pageNum = 0
        var delayTime = 0.0
        let duration = 0.5
        for i in (pageNum*8+4)..<(pageNum*8+8){
            let upNum = i-4
            let bottomNum = i
            if bottomNum<itemViews.count{
                let itemView = itemViews[bottomNum]
                UIView.animate(withDuration: duration, delay: delayTime, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: .curveLinear, animations: {
                    var frame = itemView.frame
                    frame.origin.y -= (SCREEN_HEIGHT-self.itemRegionStartY)
                    itemView.frame = frame
                    
                }, completion: nil)
                delayTime += 0.05
            }
            if upNum<itemViews.count{
                let itemView = itemViews[upNum]
                UIView.animate(withDuration: duration, delay: delayTime, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: .curveLinear, animations: {
                    var frame = itemView.frame
                    frame.origin.y -= (SCREEN_HEIGHT-self.itemRegionStartY)
                    itemView.frame = frame
                }, completion: nil)
                delayTime += 0.05
            }
        }
    }
    
}

extension SupensionMenuContainView:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x/scrollViewWidth
        self.pageControl?.currentPage = Int(currentPage)
    }
}
