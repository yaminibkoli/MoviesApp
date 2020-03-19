//
//  ModelData.swift
//  BookMyMovies
//
//  Created by Kunal Malve on 18/03/20.
//  Copyright © 2020 Kunal Malve. All rights reserved.
//

import UIKit

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    var Title:[String] = []
    var Image:[String] = []
    var Rating:[Double] = []
    var ReleaseDate:[String] = []
}
