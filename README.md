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
## Step 3: Update pip to latest ver
```pip install -U pip```

## Step 4: Install node 20.x via installer
https://nodejs.org/en/download/prebuilt-installer

## Step 5: Install dependencies via Pip
```sh
  pip install --upgrade robotframework
  pip install --upgrade robotframework-requests
  pip install --upgrade robotframework-faker
  pip install --upgrade robotframework-jsonlibrary
  pip install --upgrade robotframework-browser
```
## Step 6: Install node dependencies for playwright and robot
```python -m Browser.entry init```

## Step 7: Run tests via robot command
```sh
  robot tests/api/
```
```sh
  robot tests/ui/
```

### View results generated ``report.html`` and ``log.html``

Technical documentation: https://docs.google.com/document/d/1L9KQ-w9SxRzt-tuv4agJ7ex4n9eV0ZD_nzY1_iZlc3I/edit?usp=sharing

Sample log and report files can be found under `sample_log_files` folder
