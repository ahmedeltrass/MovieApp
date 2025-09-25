//
//  UIKit+LifeCycle.swift
//  Hagazt
//
//  Created by Ahmed_POMAC on 10/12/2024.
//

import UIKit
import SwiftUI

typealias UIKitLifeCycleCompletion = () -> Void
private struct UIKitLifeCycle: UIViewControllerRepresentable {
    final class UIKitViewController: UIViewController {
        var viewDidLoadAction: UIKitLifeCycleCompletion?
        var viewWillAppearAction: UIKitLifeCycleCompletion?
        var viewDidAppearAction: UIKitLifeCycleCompletion?
        var viewWillDisappearAction: UIKitLifeCycleCompletion?
        var viewDidDisappear: UIKitLifeCycleCompletion?
        var didReceiveMemoryWarningAction: UIKitLifeCycleCompletion?
        var viewDidLayoutSubviewsAction: UIKitLifeCycleCompletion?

        override func viewDidLoad() {
            super.viewDidLoad()
            viewDidLoadAction?()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewWillAppearAction?()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            viewDidAppearAction?()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            viewWillDisappearAction?()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            viewDidDisappear?()
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            didReceiveMemoryWarningAction?()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            viewDidLayoutSubviewsAction?()
        }
    }

    var viewDidLoadAction: UIKitLifeCycleCompletion?
    var viewWillAppearAction: UIKitLifeCycleCompletion?
    var viewDidAppearAction: UIKitLifeCycleCompletion?
    var viewWillDisappearAction: UIKitLifeCycleCompletion?
    var viewDidDisappear: UIKitLifeCycleCompletion?
    var didReceiveMemoryWarningAction: UIKitLifeCycleCompletion?
    var viewDidLayoutSubviewsAction: UIKitLifeCycleCompletion?

    func makeUIViewController(context: Context) -> UIKitViewController {
        let viewController = UIKitViewController()
        viewController.viewDidLoadAction = viewDidLoadAction
        viewController.viewWillAppearAction = viewWillAppearAction
        viewController.viewDidAppearAction = viewDidAppearAction
        viewController.viewWillDisappearAction = viewWillDisappearAction
        viewController.viewDidDisappear = viewDidDisappear
        viewController.didReceiveMemoryWarningAction = didReceiveMemoryWarningAction
        viewController.viewDidLayoutSubviewsAction = viewDidLayoutSubviewsAction
        
        return viewController
    }
    
    func updateUIViewController(_ controller: UIKitViewController, context: Context) {
        // update View...
    }
}

extension View {
    /// Unfortunately, onAppear is broken in SwiftUI iOS >14.
    /// Therefore, we fallback to UIKit's viewDidAppear method in `Routed<Content>` to determine when a screen is shown.
    /// [Apple Developer Forums Discussion](https://developer.apple.com/forums/thread/655338)
    func uiKit(
        viewDidLoad: UIKitLifeCycleCompletion? = nil,
        viewWillAppear: UIKitLifeCycleCompletion? = nil,
        viewDidAppear: UIKitLifeCycleCompletion? = nil,
        viewWillDisappear: UIKitLifeCycleCompletion? = nil,
        viewDidDisappear: UIKitLifeCycleCompletion? = nil,
        didReceiveMemoryWarningAction: UIKitLifeCycleCompletion? = nil,
        viewDidLayoutSubviewsAction: UIKitLifeCycleCompletion? = nil
    ) -> some View {
        self.background(
            UIKitLifeCycle(
                viewDidLoadAction: viewDidLoad,
                viewWillAppearAction: viewWillAppear,
                viewDidAppearAction: viewDidAppear,
                viewWillDisappearAction: viewWillDisappear,
                viewDidDisappear: viewDidDisappear,
                didReceiveMemoryWarningAction: didReceiveMemoryWarningAction,
                viewDidLayoutSubviewsAction: viewDidLayoutSubviewsAction
            )
        )
    }
}

