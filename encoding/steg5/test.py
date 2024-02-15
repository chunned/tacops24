import numpy as np
import matplotlib.pyplot as plt
import scipy.io.wavfile as wav

# Read the audio file
rate, audio = wav.read("input_audio.wav")

# Compute the spectrogram
frequencies, times, spectrogram = plt.specgram(audio, Fs=rate)

# Load and encode the BMP image
image_data = plt.imread("input_image.bmp")
# Convert image data to binary
binary_image = ''.join(format(ord(i), '08b') for i in image_data.flatten())

# Embed image data into the spectrogram (using LSB for simplicity)
for i, bit in enumerate(binary_image):
    spectrogram[i % len(spectrogram), i // len(spectrogram)] += int(bit)  # Adjust this for LSB embedding

# Save the modified spectrogram as audio
plt.imsave("modified_spectrogram.png", np.log(spectrogram), cmap='gray')
