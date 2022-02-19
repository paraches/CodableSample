//
//  Shapes.swift
//  CodableSample
//
//  Created by shinichi teshirogi on 2022/02/16.
//

import Foundation

struct Ray {
    let start: PVector
    let direction: PVector
}

struct Intersection {
    let point: PVector
    let shape: ShapeProtocol
}


protocol ShapeProtocol: Codable {
    var position: PVector {get}
    
    func hasIntersection(ray: Ray) -> Intersection?
}


struct Sphere: ShapeProtocol {
    let radius: Double

    // ShapeProtocol
    var position: PVector
    
    init(position: PVector, radius: Double) {
        self.radius = radius
        self.position = position
    }
    
    // ShapeProtocol
    func hasIntersection(ray: Ray) -> Intersection? {
        return nil
    }
}

