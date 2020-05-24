import Foundation
import AVFoundation

public class Oscillator {
    
    public var node: AVAudioSourceNode!
    
    public var signal: (Double) -> Double {
        get { queue.sync{ _signal } }
        set { queue.sync{ _signal = newValue; signalId += 1 } }
    }
    
    private var _signal: (Double) -> Double = { _ in 0 }
    private var signalId: UInt = 0
    
    private var queue = DispatchQueue(
        label: "uk.co.thousandyears.Noah.Oscillator.queue",
        qos: .userInitiated
    )

    public init(sampleRate: Double) {
        var count: UInt = 0
        var previous = (id: signalId, f: _signal)
        
        let node = AVAudioSourceNode {
            [weak self, dt = sampleRate.reciprocal!] _, _, sampleCount, channels in
            guard let self = self else { return noErr }
            let (id, f) = self.queue.sync{ (self.signalId, self._signal) }
            for frame in 0 ..< sampleCount {
                let t = Double(count) * dt
                let d = Double(frame) / Double(sampleCount - 1)
                let signal = id == previous.id
                    ? f(t)
                    : (1 - d) * previous.f(t) + d * f(t)
                for channel in UnsafeMutableAudioBufferListPointer(channels) {
                    let o = UnsafeMutableBufferPointer<Float>(channel)
                    o[Int(frame)] = Float(signal)
                }
                count &+= 1
            }
            previous = (id, f)
            return noErr
        }
        
        self.node = node
    }
}

extension Double {
    
    var reciprocal: Double? {
        guard self != 0 else { return nil }
        return 1 / self
    }
}
