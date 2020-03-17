//
//  JJBadgeView.swift
//  CreatingViewComponents
//
//  Created by Juan J LF on 3/10/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

public class JJBadgeView : UIView {
    
  
    private var mText = NSMutableAttributedString(string: "99+")
    private var mTextSize : CGFloat = 15
    private var mFont = UIFont.systemFont(ofSize: 15)
    private var mTextColor = UIColor.white
   
      public init() {
        super.init(frame:.zero)
        backgroundColor = UIColor.red
    }
      
      required public init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
   

    override public var bounds: CGRect {
        didSet{
            makeShape(shape: .circle)
            mText.sizeOneLine(cgSize: &mBoundsText)
        }
    }
    
    @discardableResult
   public func setText(text:String) -> JJBadgeView{
        self.mText.mutableString.setString(text)
        setNeedsUpdateConstraints()
        setNeedsDisplay()
        return self
    }
    
    @discardableResult
    public  func setTextSize(_ size : CGFloat) -> JJBadgeView{
        if(size > -1){
            mTextSize = size
            mFont = mFont.withSize(mTextSize)
            setNeedsUpdateConstraints()
            setNeedsDisplay()
        }
          return self
      }
    
    @discardableResult
    public func setFont(_ name: String) -> JJBadgeView{
        if !name.isEmpty {
            mFont = UIFont(name: name, size: mTextSize) ?? UIFont.systemFont(ofSize: mTextSize)
            setNeedsDisplay()
        }
        return self
    }
  
    
    @discardableResult
   public  func setTextColor(_ color: UIColor?)-> JJBadgeView{
           if color  != nil{
              mTextColor = color!
             setNeedsDisplay()
           }
         return self
    }
    
    private var mIsTextHidden = false
    @discardableResult
    public func setIsTextHidden(_ boolean: Bool)-> JJBadgeView{
           mIsTextHidden = boolean
         setNeedsDisplay()
            return self
    }
    
    private var mTextOffsetX : CGFloat = 0
    @discardableResult
    public func setTextOffsetX(_ value: CGFloat)-> JJBadgeView{
         mTextOffsetX = value
         setNeedsDisplay()
          return self
    }
    private var mTextOffsetY : CGFloat = 0
    @discardableResult
    public func setTextOffsetY(_ value: CGFloat)-> JJBadgeView{
           mTextOffsetY = value
         setNeedsDisplay()
            return self
    }
       @discardableResult
    public func setStrokeColor(_ color:UIColor?) -> JJBadgeView{
        if color != nil {layer.borderColor = color!.cgColor}
        return self
    }
     @discardableResult
    public func setStrokeWidth(_ value: CGFloat) -> JJBadgeView {
        layer.borderWidth = value
        return self
    }
    
    @discardableResult
       public func setBackgroundColor(_ color: UIColor?) -> JJBadgeView {
           backgroundColor = color
           return self
       }

 
    
    private var mWidthIsWrapContent = true
    private var mHeightIsWrapContent = true
    private var mDesiredWidth : CGFloat = 0
    private var mDesiredHeight : CGFloat = 0
    override public func updateConstraints() {
        super.updateConstraints()
        if constraints.count > 0{
            constraints.forEach { (cons) in
                if cons.firstAnchor == widthAnchor {
                    mWidthIsWrapContent = false  }
                if cons.firstAnchor == heightAnchor {
                    mHeightIsWrapContent = false  }
            }
        } else {
            mWidthIsWrapContent = true
            mHeightIsWrapContent = true
        }
        
        computeWrapContentSize()
        if(mWidthIsWrapContent) { clWidth(size: mDesiredWidth) }
        if(mHeightIsWrapContent) { clHeight(size: mDesiredHeight) }
        if(mWidthIsWrapContent || mHeightIsWrapContent) { clApply() }
    
    }
  

    private func computeWrapContentSize(){
        if mText.length > 0 {
          self.mText.addAttributes([.font : mFont,
                  .foregroundColor: mTextColor], range: NSRange(location: 0, length: self.mText.length))
                        
          self.mText.sizeOneLine(cgSize: &mBoundsText)
          let margin = mBoundsText.height * 0.55
          mDesiredHeight = mBoundsText.height + margin
          mDesiredWidth = mBoundsText.width + margin
                  
         if mText.length == 1 { mDesiredWidth = mDesiredHeight }
        }else{
            mDesiredHeight = 0
            mDesiredWidth = 0
        }
    }
    
    

    private var mDeltaY = 0
    private var mDeltaX = 0
    private var mBoundsText = CGSize(width: 0, height: 0)
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if(self.mText.length > 0){
      
            let deltaY =  ( bounds.height / 2 - mBoundsText.height / 2 ) + mTextOffsetY
            let deltaX = ( bounds.width / 2 - mBoundsText.width / 2 ) + mTextOffsetX
           
            if(!mIsTextHidden) { self.mText.draw(at: CGPoint(x: deltaX,y: deltaY)) }
        }
        
    }
    
    

    private func makeShape(shape: JJBadgeView.TypeShape){
      switch shape {
      case .circle:
          self.layer.cornerRadius = min(self.bounds.height,self.bounds.width) / 2
    
      default:
          print("not implemented")
      }
      self.clipsToBounds = true
    }

    public enum TypeShape {
      case none, circle , cornerSmall, cornerVerySmall,cornerMedium,cornerLarge,cornerExtraLarge,cornerExtraSmall
    }

    
    
    private var mConstraints = JJConstraintSet()
      private func addAnchoredConstraints(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, margins: UIEdgeInsets? = nil,wAnchor: NSLayoutDimension? = nil, multiplierW: CGFloat = 1, hAnchor: NSLayoutDimension? = nil, multiplierH: CGFloat = 1, width: CGFloat = -1, height:CGFloat = -1, centerX: NSLayoutXAxisAnchor? = nil,constantX:CGFloat = 0, centerY:  NSLayoutYAxisAnchor? = nil, constantY:CGFloat = 0,priority: JJConstraintPriority = JJConstraintPriority.normal,text:String = "") {
           
           translatesAutoresizingMaskIntoConstraints = false
    
           if let top = top {
               mConstraints.top?.isActive = false
               mConstraints.top = topAnchor.constraint(equalTo: top, constant: margins?.top ?? 0)
               mConstraints.top?.priority = priority.top
                 mConstraints.top?.identifier = "top"
           }
           
           if let leading = leading {
               mConstraints.leading?.isActive = false
               mConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: margins?.left ?? 0)
                mConstraints.leading?.priority = priority.leading
                mConstraints.leading?.identifier = "leading"
           }
           

           if let bottom = bottom {
                mConstraints.bottom?.isActive = false
               mConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -(margins?.bottom ?? 0))
                 mConstraints.bottom?.priority = priority.bottom
              
           }
           
           if let trailing = trailing {
                mConstraints.trailing?.isActive = false
               mConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -(margins?.right ?? 0))
                mConstraints.trailing?.priority = priority.trailing
                mConstraints.trailing?.identifier = "trailing"
           }
           
           if width >= 0 {
                       mConstraints.width?.isActive = false
               mConstraints.width = widthAnchor.constraint(equalToConstant: width)
                    mConstraints.width?.priority = priority.width
                   mConstraints.width?.identifier = "width"
                }
            
            if height >= 0 {
                       mConstraints.height?.isActive = false
                mConstraints.height = heightAnchor.constraint(equalToConstant: height)
                mConstraints.height?.priority = priority.height
                 mConstraints.height?.identifier = "height"
            }
           
           if let wa = wAnchor {
                        mConstraints.width?.isActive = false
               mConstraints.width = widthAnchor.constraint(equalTo: wa, multiplier: multiplierW)
                mConstraints.width?.priority = priority.width
               mConstraints.width?.identifier = "width"
           }
           
           if let ha = hAnchor {
                      mConstraints.height?.isActive = false
               mConstraints.height = heightAnchor.constraint(equalTo: ha, multiplier: multiplierH)
                mConstraints.height?.priority = priority.height
                   mConstraints.height?.identifier = "height"
           }
           
           if let centerx = centerX {
                  mConstraints.centerXanchor?.isActive = false
               mConstraints.centerXanchor = centerXAnchor.constraint(equalTo: centerx, constant: constantX)
               mConstraints.centerXanchor?.priority = priority.centerX
                mConstraints.centerXanchor?.identifier = "centerX"
           }
           
           if let centery = centerY {
                 mConstraints.centerYanchor?.isActive = false
               mConstraints.centerYanchor = centerYAnchor.constraint(equalTo: centery, constant: constantY)
               mConstraints.centerYanchor?.priority = priority.centerY
                mConstraints.centerYanchor?.identifier = "centerY"
           }
                   
       
       }
       
       @discardableResult
     public  func clApply() -> JJBadgeView{
           [mConstraints.top, mConstraints.leading, mConstraints.bottom, mConstraints.trailing, mConstraints.width, mConstraints.height,
               mConstraints.centerXanchor,
               mConstraints.centerYanchor].forEach{
                  $0?.isActive = true }
           return self
       }
       
       @discardableResult
       public func clFillParent(margin:UIEdgeInsets = UIEdgeInsets(), priority:JJConstraintPriority = .normal) -> JJBadgeView{
           
           guard let superviewTopAnchor = superview?.topAnchor,
                    let superviewBottomAnchor = superview?.bottomAnchor,
                    let superviewLeadingAnchor = superview?.leadingAnchor,
                    let superviewTrailingAnchor = superview?.trailingAnchor else {
                        return self
                }
           addAnchoredConstraints(top:superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, margins: margin, priority: priority)
           
           return self
       }
       
       @discardableResult
      public  func clFillParentHorizontally(startMargin: CGFloat = 0,endMargin:CGFloat = 0,_ priority:JJConstraintPriority = .normal) -> JJBadgeView{
              
              guard let superviewLeadingAnchor = superview?.leadingAnchor,
                   let superviewTrailingAnchor = superview?.trailingAnchor else {
                           return self
                   }
           addAnchoredConstraints(top:nil, leading: superviewLeadingAnchor, bottom: nil, trailing: superviewTrailingAnchor, margins: UIEdgeInsets(top: 0,left: startMargin,bottom: 0,right: endMargin),priority: priority)
              
              return self
       }
       
       @discardableResult
     public func clFillParentVertically(topMargin: CGFloat = 0,bottomMargin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
              
              guard let superviewTop = superview?.topAnchor,
                   let superviewBottom = superview?.bottomAnchor else {
                           return self
                   }
           addAnchoredConstraints(top:superviewTop, leading: nil, bottom: superviewBottom, trailing: nil, margins: UIEdgeInsets(top: topMargin,left: 0,bottom: bottomMargin,right: 0),priority: priority)
              
              return self
       }
       
       @discardableResult
      public func clCenterInParent(constantX: CGFloat = 0, constantY: CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{

            guard let superviewCenterX = superview?.centerXAnchor ,
                     let superviewCenterY = superview?.centerYAnchor
                else { return self }
           
           addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil, margins: nil,centerX: superviewCenterX,constantX: constantX,centerY: superviewCenterY,constantY: constantY, priority: priority)
            
            return self
        }
       
       @discardableResult
      public func clCenterInParentHorizontally(constantX: CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{

               guard let superviewCenterX = superview?.centerXAnchor
                   else { return self }
              
              addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil,centerX: superviewCenterX,constantX: constantX, priority: priority)
               
               return self
        }
       
        @discardableResult
       public func clCenterInParentVertically(constantY: CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{

                   guard let superviewCenterY = superview?.centerYAnchor
                       else { return self }
                  
                  addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil,centerY: superviewCenterY,constantY: constantY, priority: priority)
                   
               return self
        }
       
      
       @discardableResult
      public func clTopToTopParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
             
             guard let superviewTopAnchor = superview?.topAnchor
                     else { return self }
           
           addAnchoredConstraints(top:superviewTopAnchor, leading: nil, bottom: nil, trailing: nil, margins: UIEdgeInsets.top(margin), priority: priority)
             
             return self
       }
       
       @discardableResult
      public func clBottomToBottomParent( margin:CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{
           
           guard let sideAnchor = superview?.bottomAnchor
                   else { return self }
         
         addAnchoredConstraints(top:nil, leading: nil, bottom: sideAnchor, trailing: nil, margins: UIEdgeInsets.bottom(margin), priority: priority,text: "soy botoom")
           
           return self
       }
       
       @discardableResult
      public func clStartToStartParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
              
              guard let sideAnchor = superview?.leadingAnchor
                      else { return self }
            
            addAnchoredConstraints(top:nil, leading: sideAnchor, bottom: nil, trailing: nil, margins: UIEdgeInsets.left(margin), priority: priority)
              
              return self
       }
       
       @discardableResult
     public  func clEndToEndParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
              
              guard let sideAnchor = superview?.trailingAnchor
                      else { return self }
            
            addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: sideAnchor, margins: UIEdgeInsets.right(margin), priority: priority)
              
              return self
       }
       
       @discardableResult
        public  func clTopToBottomParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                
                guard let sideAnchor = superview?.bottomAnchor
                        else { return self }
              
              addAnchoredConstraints(top:sideAnchor, leading: nil, bottom: nil, trailing: nil, margins: UIEdgeInsets.top(margin), priority: priority)
                
                return self
          }
          
          @discardableResult
        public  func clBottomToTopParent( margin:CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{
              
              guard let sideAnchor = superview?.topAnchor
                      else { return self }
            
            addAnchoredConstraints(top:nil, leading: nil, bottom: sideAnchor, trailing: nil, margins: UIEdgeInsets.bottom(margin), priority: priority,text: "soy botoom")
              
              return self
          }
          
          @discardableResult
        public  func clStartToEndParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                 
                 guard let sideAnchor = superview?.trailingAnchor
                         else { return self }
               
               addAnchoredConstraints(top:nil, leading: sideAnchor, bottom: nil, trailing: nil, margins: UIEdgeInsets.left(margin), priority: priority)
                 
                 return self
          }
          
          @discardableResult
         public func clEndToStartParent( margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                 
                 guard let sideAnchor = superview?.leadingAnchor
                         else { return self }
               
               addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: sideAnchor, margins: UIEdgeInsets.right(margin), priority: priority)
                 
                 return self
          }
       
       
       @discardableResult
      public func clWidth(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
               
           if size < 0 { return self }
             
           addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil, margins: nil,width: size, priority: priority)
               
               return self
        }
       @discardableResult
       public func clHeight(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
               
           if size < 0 { return self }
             
           addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil, margins: nil,height: size, priority: priority)
               
               return self
       }
       
       @discardableResult
       public func clWidthEqualTo(anchor:NSLayoutDimension,multiplier: CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                  
                
           addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil, margins: nil,wAnchor: anchor, multiplierW: multiplier, priority: priority)
                  
                  return self
           }
       @discardableResult
       public func clHeightEqualTo(anchor: NSLayoutDimension,multiplier: CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                  

              addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: nil, margins: nil,hAnchor: anchor,multiplierH: multiplier, priority: priority)
                  
                  return self
       }
    
    @discardableResult
      public func clWidthLessEqualTo(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                  
              if size < 0 { return self }
            mConstraints.width?.isActive = false
            mConstraints.width = widthAnchor.constraint(lessThanOrEqualToConstant: size)
            mConstraints.width?.identifier = "width"
            mConstraints.width?.priority = priority.width
                  return self
        }
        
        @discardableResult
       public  func clHeightLessEqualTo(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                    
                if size < 0 { return self }
              mConstraints.height?.isActive = false
              mConstraints.height = heightAnchor.constraint(lessThanOrEqualToConstant: size)
              mConstraints.height?.identifier = "height"
              mConstraints.height?.priority = priority.height
                    return self
          }
      
      @discardableResult
        public func clWidthGreaterEqualTo(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                  
              if size < 0 { return self }
            mConstraints.width?.isActive = false
            mConstraints.width = widthAnchor.constraint(greaterThanOrEqualToConstant: size)
            mConstraints.width?.identifier = "width"
            mConstraints.width?.priority = priority.width
                  return self
        }
        
        @discardableResult
       public   func clHeightGreaterEqualTo(size:CGFloat, priority:JJConstraintPriority = .normal) -> JJBadgeView{
                    
                if size < 0 { return self }
              mConstraints.height?.isActive = false
              mConstraints.height = heightAnchor.constraint(greaterThanOrEqualToConstant: size)
              mConstraints.height?.identifier = "height"
              mConstraints.height?.priority = priority.height
                    return self
          }
      
       
       @discardableResult
       public func clTopToTopOf(view:UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
               
           addAnchoredConstraints(top:view.topAnchor, leading: nil, bottom: nil, trailing: nil, margins: UIEdgeInsets.top(margin), priority: priority)
               
               return self
         }
         
         @discardableResult
      public  func clBottomToBottomOf(view:UIView, margin:CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{

           addAnchoredConstraints(top:nil, leading: nil, bottom: view.bottomAnchor, trailing: nil, margins: UIEdgeInsets.bottom(margin), priority: priority)
             
             return self
         }
         
         @discardableResult
      public func clStartToStartOf(view: UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
              addAnchoredConstraints(top:nil, leading: view.leadingAnchor, bottom: nil, trailing: nil, margins: UIEdgeInsets.left(margin), priority: priority)
                
                return self
         }
         
         @discardableResult
      public func clEndToEndOf(view:UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
           
              addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, margins: UIEdgeInsets.right(margin), priority: priority)
                
                return self
         }
       
       
       
       @discardableResult
       public func clTopToBottomOf(view:UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
               
           addAnchoredConstraints(top:view.bottomAnchor, leading: nil, bottom: nil, trailing: nil, margins: UIEdgeInsets.top(margin), priority: priority)
               
               return self
         }
         
         @discardableResult
       public func clBottomToTopOf(view:UIView, margin:CGFloat = 0,priority:JJConstraintPriority = .normal) -> JJBadgeView{

           addAnchoredConstraints(top:nil, leading: nil, bottom: view.topAnchor, trailing: nil, margins: UIEdgeInsets.bottom(margin), priority: priority)
             
             return self
         }
         
         @discardableResult
      public func clStartToEndOf(view: UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
           addAnchoredConstraints(top:nil, leading: view.trailingAnchor, bottom: nil, trailing: nil, margins: UIEdgeInsets.left(margin), priority: priority)
                
                return self
         }
         
         @discardableResult
      public func clEndToStartOf(view:UIView, margin:CGFloat = 0, priority:JJConstraintPriority = .normal) -> JJBadgeView{
           
              addAnchoredConstraints(top:nil, leading: nil, bottom: nil, trailing: view.leadingAnchor, margins: UIEdgeInsets.right(margin), priority: priority)
                
                return self
         }
       
       @discardableResult
      public  func clMargins(values: UIEdgeInsets) -> JJBadgeView{
             
           mConstraints.top?.constant = values.top
           mConstraints.bottom?.constant = values.bottom
           mConstraints.leading?.constant = values.left
           mConstraints.trailing?.constant = values.right
            
           return self
        }
       
       @discardableResult
      public func clVerticalBiasCenter(value: CGFloat) -> JJBadgeView{
           mConstraints.centerYanchor?.constant = value
           return self
        }
       
       @discardableResult
     public  func clHotizontalBiasCenter(value: CGFloat) -> JJBadgeView{
              mConstraints.centerXanchor?.constant = value
              return self
       }
    
}
