import numpy as np
import matplotlib.pyplot as plt

bits = [1,0,1,1,0,0,1,0]

spb = 100   # samples per bit
fc = 5      # carrier frequency

digital = []
ask = []
fsk = []
psk = []
time = []

for i, bit in enumerate(bits):
    t = np.linspace(i, i+1, spb)
    time.extend(t)

    # digital signal
    digital.extend([bit]*spb)

    # ASK (amplitude change)
    amp = 1 if bit == 1 else 0.2
    ask.extend(amp * np.sin(2*np.pi*fc*t))

    # FSK (frequency change)
    freq = 8 if bit == 1 else 3
    fsk.extend(np.sin(2*np.pi*freq*t))

    # PSK (phase change)
    phase = 0 if bit == 1 else np.pi
    psk.extend(np.sin(2*np.pi*fc*t + phase))

# plot
plt.figure(figsize=(10,8))

plt.subplot(4,1,1)
plt.plot(time, digital)
plt.title("Digital Signal")
plt.grid()

plt.subplot(4,1,2)
plt.plot(time, ask)
plt.title("ASK")
plt.grid()

plt.subplot(4,1,3)
plt.plot(time, fsk)
plt.title("FSK")
plt.grid()

plt.subplot(4,1,4)
plt.plot(time, psk)
plt.title("PSK")
plt.grid()

plt.tight_layout()
plt.show()
