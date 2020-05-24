import Foundation

extension Oscillator {
    
    public struct Wave: Codable, Equatable, Hashable {
        public var frequency: Double
        public var amplitude: Double
        public var phase: Double
        
        public init(frequency: Double, amplitude: Double, phase: Double) {
            self.frequency = frequency
            self.amplitude = amplitude
            self.phase = phase
        }
    }
}

extension Oscillator.Wave {
    
    public func signal(_ time: Double) -> Double {
        amplitude * sin(2 * Double.pi * frequency * time + phase)
    }
}

extension Sequence where Element == Oscillator.Wave {
    
    public func signal(_ time: Double) -> Double {
        reduce(0) { $0 + $1.signal(time) }
    }
}
