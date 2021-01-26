//
//  MainAssembly.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//

import Foundation
import UIKit

final class MainAssembly {
    static func assembly() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
