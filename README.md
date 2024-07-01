# Install instructions

## Prerequisites

- Windows, macOS, or Linux

## Step 1: Install Python

1. Download the latest version of Python from the official [Python website](https://www.python.org/downloads/).
2. Run the installer:
   - **Windows**: Make sure to check the "Add Python to PATH" option before clicking "Install Now".
   - **macOS** and **Linux**: Follow the instructions provided in the installer.

3. Verify the installation:
   ```sh
   python --version
   ```
## Step 2: Check Pip
```sh
  pip --version
```
## Step 3: Install dependencies via Pip
```sh
  python -m pip install --upgrade robotframework
  python -m pip install --upgrade robotframework-requests
  python -m pip install --upgrade robotframework-faker
  python -m pip install --upgrade robotframework-jsonlibrary
```

## Step 4: Run tests via robot command
```sh
  robot tests/demo.robot
```
### View results generated ``report.html`` and ``log.html``

Technical documentation: https://docs.google.com/document/d/1L9KQ-w9SxRzt-tuv4agJ7ex4n9eV0ZD_nzY1_iZlc3I/edit?usp=sharing
