//
//  Scene.swift
//  CodableSample
//
//  Created by shinichi teshirogi on 2022/02/18.
//

import Foundation

struct Scene: Codable {
    let position: PVector
    let shapes: [ShapeProtocol]
    
    enum CodingKeys: String, CodingKey {
        case shapes, position
    }
    
    init(position: PVector, shapes: [ShapeProtocol]) {
        self.position = position
        self.shapes = shapes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decode(PVector.self, forKey: .position)
        let wrappers = try container.decode([ShapeWrapper].self, forKey: .shapes)
        self.shapes = wrappers.map { $0.shape }
    }
    
    func encode(to encoder: Encoder) throws {
        let wrappers = shapes.map { ShapeWrapper($0) }
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(position, forKey: .position)
        try container.encode(wrappers, forKey: .shapes)
    }
}

fileprivate struct ShapeWrapper: Codable {
    let shape: ShapeProtocol
    
    enum CodingKeys: String, CodingKey {
        case base, payload
    }
    
    enum Base: String, Codable {
        case sphere
    }
    
    init(_ shape: ShapeProtocol) {
        self.shape = shape
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(Base.self, forKey: .base)
        
        switch base {
        case .sphere:
            self.shape = try container.decode(Sphere.self, forKey: .payload)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch shape {
        case let payload as Sphere:
            try container.encode(Base.sphere, forKey: .base)
            try container.encode(payload, forKey: .payload)
        default:
            break
        }
    }
}
