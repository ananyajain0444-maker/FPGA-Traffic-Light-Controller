import os
import matplotlib.pyplot as plt
import numpy as np

# -----------------------------
# Create output folder
# -----------------------------
os.makedirs("images", exist_ok=True)


# -----------------------------
# 1. FSM DIAGRAM (NO CROPPING FIXED)
# -----------------------------
def fsm_diagram():
    plt.figure(figsize=(7, 7))
    plt.title("Traffic Light FSM (Finite State Machine)", fontsize=14)

    positions = {
        "RED": (0, 1),
        "GREEN": (1, 0),
        "YELLOW": (-1, 0)
    }

    # States
    for state, (x, y) in positions.items():
        plt.scatter(x, y, s=4000, edgecolors="black", linewidths=2, zorder=3)
        plt.text(x, y, state,
                 ha='center', va='center',
                 fontsize=12, fontweight='bold',
                 zorder=4)

    # Transitions
    plt.annotate("", xy=positions["GREEN"], xytext=positions["RED"],
                 arrowprops=dict(arrowstyle="->", lw=2))
    plt.annotate("", xy=positions["YELLOW"], xytext=positions["GREEN"],
                 arrowprops=dict(arrowstyle="->", lw=2))
    plt.annotate("", xy=positions["RED"], xytext=positions["YELLOW"],
                 arrowprops=dict(arrowstyle="->", lw=2))

    # FIX: prevent cutting
    plt.xlim(-2, 2)
    plt.ylim(-1.5, 1.5)

    plt.axis("off")

    plt.savefig("images/traffic_fsm_visual_diagram.png",
                dpi=300, bbox_inches="tight", pad_inches=0.3)
    plt.close()


# -----------------------------
# 2. FPGA ARCHITECTURE
# -----------------------------
def architecture_diagram():
    plt.figure(figsize=(7, 6))
    plt.title("FPGA Traffic Light Architecture", fontsize=14)

    blocks = [
        "Clock Input",
        "Reset Signal",
        "FSM Controller",
        "State Register",
        "Output Logic",
        "Traffic Light LEDs (R/Y/G)"
    ]

    y = 0.9
    for b in blocks:
        plt.text(0.5, y, "→ " + b, ha='center', fontsize=12)
        y -= 0.12

    plt.axis("off")

    plt.savefig("images/smart_intersection_architecture.png",
                dpi=300, bbox_inches="tight")
    plt.close()


# -----------------------------
# 3. WAVEFORM (FIXED FPGA STYLE)
# -----------------------------
def waveform():
    t = np.arange(0, 12, 1)

    red =    np.array([1,1,1,0,0,0,0,1,1,1,0,0])
    green =  np.array([0,0,0,1,1,1,0,0,0,0,1,1])
    yellow = np.array([0,0,0,0,0,0,1,0,0,0,0,0])

    plt.figure(figsize=(10, 5))
    plt.title("Traffic Light FPGA Simulation Waveform", fontsize=14)

    # 🔥 FIX: vertical separation (real waveform look)
    plt.step(t, red + 2, where='post', label="RED", linewidth=2)
    plt.step(t, green + 1, where='post', label="GREEN", linewidth=2)
    plt.step(t, yellow + 0, where='post', label="YELLOW", linewidth=2)

    plt.yticks([0,1,2,3], ["", "YELLOW", "GREEN", "RED"])
    plt.xticks(t)
    plt.xlabel("Clock Cycles")

    plt.grid(True, linestyle="--", alpha=0.5)
    plt.legend(loc="upper right")

    plt.ylim(-0.5, 3.5)

    plt.savefig("images/simulation_waveform_results.png",
                dpi=300, bbox_inches="tight")
    plt.close()


# -----------------------------
# 4. HARDWARE DEMO
# -----------------------------
def hardware_demo():
    plt.figure(figsize=(7, 6))
    plt.title("FPGA Hardware Demo Representation", fontsize=14)

    plt.text(0.5, 0.7, "FPGA Board", ha='center', fontsize=16)
    plt.text(0.5, 0.5, "Traffic Light Controller Logic", ha='center', fontsize=14)
    plt.text(0.5, 0.3, "Outputs → RED | YELLOW | GREEN LEDs", ha='center', fontsize=12)

    plt.axis("off")

    plt.savefig("images/fpga_hardware_demo.png",
                dpi=300, bbox_inches="tight")
    plt.close()


# -----------------------------
# RUN ALL
# -----------------------------
fsm_diagram()
architecture_diagram()
waveform()
hardware_demo()

print("✅ All 4 FPGA images generated successfully inside 'images/' folder")