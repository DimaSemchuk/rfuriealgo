require(tuneR)
require(signal)

audioFile <- readWave(file.path("samples", "norm", "norm1.wav"))
specgram(audioFile@left)