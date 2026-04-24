import numpy as np
import matplotlib.pyplot as plt

# User input (message signal)
Am = float(input("Enter amplitude: "))
fm = float(input("Enter frequency: "))
pm = float(input("Enter phase: "))

# Fixed carrier signal
Ac = 2
fc = 20
pc = 0

# Time
t = np.linspace(0, 1, 1000)

# Message signal
message = Am * np.sin(2 * np.pi * fm * t + pm)

# Modulation constants
ka = 0.5
kf = 10
kp = 2

# AM
am = (Ac + ka * message) * np.sin(2 * np.pi * fc * t)

# FM
fm_signal = Ac * np.sin(2 * np.pi * fc * t + kf * message)

# PM
pm_signal = Ac * np.sin(2 * np.pi * fc * t + kp * message)

# Plot
plt.figure(figsize=(10, 8))

plt.subplot(4,1,1)
plt.plot(t, message)
plt.title("Message Signal")
plt.grid()

plt.subplot(4,1,2)
plt.plot(t, am)
plt.title("AM")
plt.grid()

plt.subplot(4,1,3)
plt.plot(t, fm_signal)
plt.title("FM")
plt.grid()

plt.subplot(4,1,4)
plt.plot(t, pm_signal)
plt.title("PM")
plt.grid()

plt.tight_layout()
plt.show()
