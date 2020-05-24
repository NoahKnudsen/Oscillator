import AVFoundation

extension AVAudioEngine {
    
    /// Creates and returns a new Oscillator after attaching and connecting it
    /// to the audio engine.
    public func oscillator() -> Oscillator {
        let format = outputNode.inputFormat(forBus: 0)
        let inputFormat = AVAudioFormat(
            commonFormat: format.commonFormat,
            sampleRate: format.sampleRate,
            channels: 1,
            interleaved: false
        )
        let oscillator = Oscillator(sampleRate: format.sampleRate)
        attach(oscillator.node)
        connect(oscillator.node, to: mainMixerNode, format: inputFormat)
        connect(mainMixerNode, to: outputNode, format: format)
        return oscillator
    }
}
