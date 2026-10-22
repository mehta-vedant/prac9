# Practical 9 — Continuous Testing Pipeline Using Jenkins

This project is the sample Python calculator for the STQA Practical 9 exercise. It contains automated PyTest tests and a `Jenkinsfile` that Jenkins can run after every code change.

## Project files

- `calculator.py` — application code with add, subtract, multiply, and divide functions.
- `test_calculator.py` — four automated PyTest test cases.
- `requirements.txt` — project dependencies.
- `Jenkinsfile` — Jenkins declarative pipeline.

## Run the tests locally

From this directory, run:

```powershell
python -m pip install -r requirements.txt
python -m pytest
```

On this computer, where Python is bundled with pgAdmin rather than on PATH, use the helper below. It installs PyTest into the project's local `.venv` package folder:

```powershell
cmd /c run_tests.bat install
cmd /c run_tests.bat test
```

Expected result:

```text
4 passed
```

## Run with Jenkins

1. Create a GitHub repository and push the contents of this `prac9` folder to it.
2. In Jenkins, select **New Item** → **Pipeline**.
3. Under **Pipeline**, choose **Pipeline script from SCM**.
4. Choose **Git**, enter the repository URL, and select branch `main`.
5. Set the script path to `Jenkinsfile`, save, and click **Build Now**.

The pipeline runs these stages:

1. **Checkout** — downloads the latest repository revision.
2. **Install Dependencies** — installs PyTest from `requirements.txt`.
3. **Run Tests** — executes the four tests and publishes `test-results.xml` to Jenkins.

A zero exit status from PyTest produces a successful Jenkins build. A failed assertion produces a failed build, which demonstrates continuous testing.
