# Practical 9: What to Explain to Ma'am

## Short explanation to say

“My Practical 9 implements continuous testing using Jenkins. I created a simple Python calculator and wrote four PyTest test cases for addition, subtraction, multiplication, and division. The code, tests, dependency file, and Jenkinsfile are kept in one Git repository. When Jenkins builds the project, it checks out the latest code, installs dependencies, runs PyTest, and shows whether the build is successful or failed. This finds defects automatically after a code change.”

## Explain the files

| File | What I will say |
| --- | --- |
| `calculator.py` | “This is the application code. It implements add, subtract, multiply, and divide.” |
| `test_calculator.py` | “This has four automated PyTest cases. Each `assert` compares the actual result with the expected result.” |
| `requirements.txt` | “It tells Jenkins which Python package to install: PyTest.” |
| `Jenkinsfile` | “This is the pipeline as code. It defines the Checkout, Install Dependencies, and Run Tests stages.” |
| `test-results.xml` | “Jenkins creates it during a run and publishes it as the test report. It is not stored in Git.” |

## Explain the pipeline stages

1. **Checkout** — “Jenkins downloads the newest revision of my project from the Git repository.”
2. **Install Dependencies** — “Jenkins runs `python -m pip install -r requirements.txt`, which installs PyTest.”
3. **Run Tests** — “Jenkins runs PyTest. If every assertion passes, PyTest returns exit code 0 and Jenkins marks the build as SUCCESS. If a test fails, Jenkins marks it as FAILURE.”

## Demonstration steps

1. Show the four functions in `calculator.py` and the four tests in `test_calculator.py`.
2. In Jenkins, open the **STQA-Continuous-Testing** pipeline and click **Build Now**.
3. Open **Console Output** and show each stage completing, then show `4 passed` and green **SUCCESS**.
4. To demonstrate defect detection, temporarily change `return a + b` in `add` to `return a - b`, commit and push it, then run the build again.
5. Show the failed `test_add` assertion and red **FAILURE** result.
6. Restore `return a + b`, push the fix, run Jenkins again, and show **SUCCESS**.

## Important concepts

- **Continuous testing**: Running automated tests repeatedly whenever code changes, so defects are found early.
- **Jenkins**: An automation server that runs the pipeline steps.
- **Pipeline**: The ordered list of automated stages in the `Jenkinsfile`.
- **PyTest**: The tool that actually executes the Python tests; Jenkins triggers it and reports its result.
- **Git/GitHub**: Git tracks project changes; GitHub stores the remote repository Jenkins checks out.

## Likely viva questions

**Does Jenkins itself test the calculator?** “No. PyTest performs the tests. Jenkins automates getting code, installing dependencies, running PyTest, and reporting the result.”

**Where are the tests executed?** “On the machine or Jenkins agent where the Jenkins job runs. For this practical, that is my laptop.”

**How does Jenkins decide SUCCESS or FAILURE?** “From the command exit status. PyTest returns zero when all tests pass and a non-zero exit status when a test fails.”

**Why is a Jenkinsfile useful?** “It stores pipeline configuration with the code, so the same process can be reviewed, versioned, and run consistently.”

**What is the benefit of continuous testing?** “It detects regressions immediately after a change, reducing the time needed to find and fix defects.”
