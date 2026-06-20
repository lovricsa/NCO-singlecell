## Setup Python Environment for scVI Integration

This project integrates single-cell datasets using `scvi-tools` (v1.4.1) and `torch` (v2.9.1). To run the integration steps in the R Markdown scripts seamlessly, you must initialize a local Python virtual environment named `scvi-env` inside the project root directory.

### 1. Create the Virtual Environment

Open your terminal or command prompt, navigate to the cloned project root folder, and run the command for your operating system:

* **macOS / Linux:**
  ```bash
python3 -m venv scvi-env

```
* **Windows:**
  ```cmd
python -m venv scvi-env

```

### 2. Activate and Install Dependencies

Select the appropriate commands below to activate the environment and install the exact package manifest:

* **macOS / Linux:**
  ```bash
source scvi-env/bin/activate
pip install --upgrade pip
pip install -r scvi-requirements.txt
```

* **Windows (PowerShell):**
  ```powershell
.\scvi-env\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r scvi-requirements.txt
```

* **Windows (Command Prompt - cmd):**
  ```cmd
scvi-env\Scripts\activate.bat
pip install --upgrade pip
pip install -r scvi-requirements.txt

```

Once installed, the R package `reticulate` will automatically detect this local `scvi-env` folder via the pipeline's `here()` paths and run the integration downstream.

### 💡 Troubleshooting Platform-Specific Installation Errors
The `scvi-requirements.txt` file is pre-configured with explicit Nvidia CUDA 12 wheels (`nvidia-*-cu12`) for high-performance GPU integration. 

* **If installing on an Apple Silicon Mac (M1/M2/M3) or a CPU-only machine:** `pip` may throw an environment mismatch error trying to locate those Nvidia wheels. If this occurs, simply open `requirements.txt`, delete or comment out the lines starting with `nvidia-` and `triton==`, and re-run the `pip install` command. PyTorch will automatically default to using your local CPU or Apple Silicon MPS graphics framework.
