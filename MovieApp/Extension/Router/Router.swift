//
//  Router.swift
//  WHBusiness
//
//  Created by MorsyElsokary on 29/07/2023.
//

import Foundation
import Combine
import SwiftUI

class Router<Route: Equatable>: ObservableObject {
    private let logger: Logger
    private var _routes: [Route] = []
    public var routes: [Route] {
        _routes
    }
    var onPush: ((Route, Bool) -> Void)?
    var onPopLast: ((Int, Bool) -> Void)?
    var onSetNewRoot: (() -> Void)?
    public init(initial: Route? = nil, debug: Bool = false) {
        logger =  NavLog()
        
        if let initial {
            push(initial, animated: false)
        }
    }
    
    public func push(_ route: Route, animated: Bool = true) {
        logger.log("Pushing \(route) route.")
        _routes.append(route)
        onPush?(route, animated)
    }
    
    public func pop(animated: Bool = true) {
        guard !_routes.isEmpty else {
            logger.log("No Route to Pop")
            return
        }
        
        let popped = self._routes.removeLast()
        logger.log("\(popped) route popped.")
        onPopLast?(1, animated)
    }
    
    public func setNewRoot(_ route: Route, animated: Bool = true) {
        guard !_routes.isEmpty else {
            logger.log("No Route to Pop")
            return
        }
        self._routes.removeAll()
        _routes.append(route)
        onPush?(route, animated)
    }
    
    public func popTo(_ route: Route, inclusive: Bool = false, animated: Bool = true) {
        logger.log("Popping routes to \(route).")
        
        if _routes.isEmpty {
            logger.log("Path is empty.")
            return
        }
        
        guard var foundPathIndex = _routes.lastIndex(where: { $0 == route }) else {
            logger.log("Warning - Route not found.")
            return
        }
        
        if !inclusive {
            foundPathIndex+=1
        }
        
        let numberToPop = (foundPathIndex..<_routes.endIndex).count
        
        logger.log("Popping \(numberToPop) routes")
        
        guard numberToPop < _routes.count  else {
            logger.log("Out of range numberToPop:\(numberToPop) ----- RoutesCount \(_routes.count)")
            return
        }
        _routes.removeLast(numberToPop)
        
        onPopLast?(numberToPop, animated)
    }
}


struct NavigationHost<Route: Equatable, Screen: View>: View {
    
    let router: Router<Route>
    
    @ViewBuilder
    let routeMap: (Route) -> Screen
    
    public init(_ router: Router<Route>, @ViewBuilder _ routeMap: @escaping (Route) -> Screen) {
        self.router = router
        self.routeMap = routeMap
    }
    
    var body: some View {
        NavigationControllerHost(
            router: router,
            routeMap: routeMap
        )
        .environmentObject(router)
        .ignoresSafeArea(.all)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct NavigationControllerHost<Route: Equatable, Screen: View>: UIViewControllerRepresentable {
    let router: Router<Route>
    @ViewBuilder
    var routeMap: (Route) -> Screen
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: true)
        // Push Inital Views
        for path in router.routes {
            navigationController.pushViewController(
                UIHostingController(rootView: routeMap(path)), animated: true
            )
        }
        // Assigning Router Methods
        router.onPush = { path, animated in
            navigationController.pushViewController(
                UIHostingController(rootView: routeMap(path)), animated: animated
            )
        }
        
        router.onPopLast = { numberToPop, animated in
            print("numberToPop \(numberToPop)")
            if numberToPop >= navigationController.viewControllers.count {
                let popTo = navigationController.viewControllers[0]
                navigationController.popToViewController(popTo, animated: animated)
            } else if numberToPop < 0 {
                let popTo = navigationController.viewControllers[0]
                navigationController.popToViewController(popTo, animated: animated)
            } else if numberToPop < navigationController.viewControllers.count && numberToPop > 0 {
                let popIndex = navigationController.viewControllers.count - numberToPop - 1
                let popTo = navigationController.viewControllers[popIndex < 0 ? 0 : popIndex]
                navigationController.popToViewController(popTo, animated: animated)
            } else {
                let popTo = navigationController.viewControllers[0]
                navigationController.popToViewController(popTo, animated: animated)
            }
        }
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        uiViewController.navigationItem.setHidesBackButton(true, animated: false)
        uiViewController.navigationItem.hidesBackButton = true
    }
    typealias UIViewControllerType = UINavigationController
}

protocol Logger {
    func log(_ value: String)
}

final class NavLog: Logger {
    func log(_ value: String) {
        print("➡️",value)
    }
}
