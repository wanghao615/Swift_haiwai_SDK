//
//  N.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/23.
//  Copyright © 2020 niujf. All rights reserved.
//

struct N<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

//MARK: - protocol for normal types
protocol NCompatoble {}
extension NCompatoble {
    static var n: N<Self>.Type {
        get { N<Self>.self }
        set {}
    }
    var n: N<Self> {
        get { N(self) }
        set {}
    }
}
