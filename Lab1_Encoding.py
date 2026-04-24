import numpy as np
import matplotlib.pyplot as plt

bits = [1,0,1,1,0,0,1,0]

def step(levels, h=1):
    x = np.arange(0, len(levels)+1) * h
    return x, np.r_[levels, levels[-1]]

def nrzi(bits):
    levels, cur = [], -1
    for b in bits:
        if b == 1: cur *= -1
        levels.append(cur)
    return levels

def diff_manchester(bits):
    levels, cur = [], 1
    for b in bits:
        if b == 0: cur *= -1
        levels += [cur, -cur]
        cur = -cur
    return levels

encodings = [
    ("Unipolar NRZ", [1 if b else 0 for b in bits], 1),
    ("Polar NRZ-L", [1 if b else -1 for b in bits], 1),
    ("Polar NRZ-I", nrzi(bits), 1),
    ("Polar RZ", [v for b in bits for v in ([1,0] if b else [-1,0])], 0.5),
    ("Manchester", [v for b in bits for v in ([1,-1] if b else [-1,1])], 0.5),
    ("Diff Manchester", diff_manchester(bits), 0.5),
]

fig, axs = plt.subplots(len(encodings), 1, figsize=(10,12), sharex=True)

for ax, (name, levels, h) in zip(axs, encodings):
    x, y = step(levels, h)
    ax.step(x, y, where='post')
    ax.set_ylim(-1.5,1.5)
    ax.set_title(name)
    ax.grid()

plt.tight_layout()
plt.show()
