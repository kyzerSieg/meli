//
//  Reactive.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 20-03-22.
//

import Foundation
import RxSwift
import PKHUD

//extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                HUD.show(.progress)
            } else {
                HUD.hide()
            }
        })
    }
}
