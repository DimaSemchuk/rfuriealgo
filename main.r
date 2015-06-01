require(tuneR)

#
# variables block
#
sample <- readWave("test.wav")
leftChannel <- sample@left / 2^(sample@bit -1)
rightChannel <- sample@right / 2^(sample@bit -1)
leftChannelLength = length(leftChannel)
leftChannelLabels <- leftChannel[seq(0, leftChannelLength)]

timeArray <- ((0:(length(leftChannel) - 1)) / sample@samp.rate) * 1000
timeArray <- timeArray[seq(0, length(timeArray))]

#
# plotting initial data
#
#plot(timeArray, leftChannelLabels, type='l', col='black', xlab='Time (ms)', ylab='Amplitude')

#
# Get FFT points
#

leftChannelPoints <- fft(leftChannel)
nUniquePts <- ceiling((leftChannelLength + 1) / 2)

# select just the first half since the second half 
# is a mirror image of the first
# and take the absolute value, or the magnitude 
leftChannelPoints <- ((abs(leftChannelPoints[1:nUniquePts])) / leftChannelLength) ^ 2
leftChannelPointsLength = length(leftChannelPoints)

# multiply by two (see technical document for details)
# odd nfft excludes Nyquist point
if (leftChannelLength %% 2 > 0) {
  # we've got odd number of points fft
  leftChannelPoints[2:leftChannelPointsLength] <- leftChannelPoints[2:leftChannelPointsLength]*2
} else {
  # we've got even number of points fft
  leftChannelPoints[2: (leftChannelPointsLength -1)] <- leftChannelPoints[2: (leftChannelPointsLength -1)]*2
}

#  create the frequency array
freqArray <- (0:(nUniquePts - 1)) * (sample@samp.rate / leftChannelLength*500)

plot(freqArray/1000, 10*log10(leftChannelPoints), type='l', col='black', xlab='Frequency (kHz)', ylab='Power (dB)')
write(freqArray, "out.txt")
