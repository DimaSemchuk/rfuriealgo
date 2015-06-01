require(tuneR)

#variables block
sample <- readWave("sample/test.wav")
sampleLeftChannel <- sample@left / 2^(sample@bit -1)
sampleRightChannel <- sample@right / 2^(sample@bit -1)

#sampling
timeArray = (1:length(sampleLeftChannel)) / sample@samp.rate
str(timeArray)