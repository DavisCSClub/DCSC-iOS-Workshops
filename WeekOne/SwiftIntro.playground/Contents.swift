
/**

UCD Computer Science Club, iOS Workshops, Part 0 - A SWIFT INTRODUCTION

Eddie Kaiger
October 20, 2015

The code below demonstrates basic concepts in Swift as well as a peek into UIKit.
The target audience is beginner and intermediate programmers with little to no knowledge of Swift and iOS Development. The rest of this lesson can be found here:

    https://github.com/eddiekaiger/swift-intro/
*/


import UIKit
import XCPlayground


/** Simple protocol for animating a view */
protocol FancyAnimating {
    
    var animDuration: NSTimeInterval { get }
    
    func beginAnimating()
}


class SquareView: UIView {
    
    init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleView: SquareView {
    
    override init(width: CGFloat) {
        super.init(width: width)

        // Makes the corner radius half as much as the diameter, creating a circle
        layer.cornerRadius = width / 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SquareView: FancyAnimating {

    var animDuration: NSTimeInterval {
        return 2.0
    }
    
    func beginAnimating() {
        
        transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(
            animDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse],
            animations: {
                self.backgroundColor = UIColor.blueColor()
                self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
}

extension CircleView {
    
    override var animDuration: NSTimeInterval {
        return 1.7
    }
    
    override func beginAnimating() {
        
        transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 400), 2, 0.5)
        
        UIView.animateWithDuration(
            animDuration,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0,
            options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse],
            animations: {
                self.transform  = CGAffineTransformIdentity
            }, completion: nil)
    }
}


/** Below, we create a container view to which we will add our animating shapes. */
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
containerView.backgroundColor = UIColor.whiteColor()

/**
The function below makes the container view show up in Playground.
The view will show up in Playground's Assistant Editor. 
To show the Assistant Editor, press CMD+Option+Return (and CMD+Return to toggle back to normal view)
*/
XCPShowView("containerView", view: containerView)

/** Helper function to easily add a view to the container and make it start animating */
func addViewToContainer(animatingView view: UIView, center: CGPoint = containerView.center) {
    
    view.center = center
    containerView.addSubview(view)
    
    if let animatingView = view as? FancyAnimating {
        animatingView.beginAnimating()
    }
}


/** Try it out! Create instances of the circle and square class we created and start animating. */

let circle = CircleView(width: 200)
circle.backgroundColor = UIColor.redColor()

let square = SquareView(width: 100)
square.backgroundColor = UIColor.orangeColor()

addViewToContainer(animatingView: circle, center: CGPoint(x: 400, y: 400))
addViewToContainer(animatingView: square, center: CGPoint(x: 200, y: 200))



