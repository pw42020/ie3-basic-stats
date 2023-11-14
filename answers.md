## CS 520 In-class exercise 3
By Patrick Walsh, Matthew Lips

Due **November 14th, 11:59pm**

---

## Questions

### Question 1

**Question**

Why does the described automated testing infrastructure not catch the defect?

**Answer**

The automated testing does not does not notify the developers because of a logical conflict between the JUnit test and the cron infrastructure. The JUnit tests do in fact fail in the frequent cron testing, but in the event of a test failure the program does not return with a nonzero exit code that the cron architecture expects. In the cron specifications it only notifies the developers in the event of an exit code ≠ 0. So the developers are not notified because the test fails, but with normal exit code 0.

### Question 2

**Question**

How could the developers improve the testing infrastructure (either manual or automated) to immediately notice test failures in the future?

**Answer**

One option that depends on the capability of the cron infrastructure is to instead of reporting when an error resulting in an exit code happens, to instead have cron report when any test fails regardless of it creates a nonzero exit code. However, I'm not familiar with cron, so I don't know how easy this would be or if it is even possible.

The developers could also change the JUnit test to generate a nonzero exit code when any test fails so that the cron job is able to catch the error and notify the developers.

A more manual option would be able to have the developers manually check the unit tests in some development interval, so that there are human eyes on the tests which can detect any anomalies better than a mindless computer program.

### Question 3

**Question**

For git bisect, how many commits exist between v1.0.0 and the HEAD revisions (including v1.0.0 and HEAD)? What command(s) did you use to determine the number?

**Answer**

To determine the amount of commits between `v1.0.0` and `master`, I used the command

```sh
git rev-list --left-right --count master...v1.0.0
```

which returned the fact that master is 36 commits ahead
of branch v1.0.0 and 0 commits behind.

### Question 4

**Question**

Based on the git bisect results, which commit (commit hash and log message) introduced the defect? How did you independently verify (meaning another approach other than git bisect) that this commit indeed introduced the defect?

**Answer**

The following commit introduced the bug:

	commit f7f175dc8bc5b3693f99b2f8e799b51c0d0d9b9f
	Author: DeveloperTommy <its.tommy.nguyen@gmail.com>
	Date:   Mon Sep 26 23:58:11 2016 -0400
	Commented and cleaned up the source code
	src/BasicStats.java | 19 ++++++++++++-------
	src/Controller.java |  2 +-
	src/ModeView.java   |  1 -
	src/Model.java      |  1 +
	src/ResetCtrl.java  |  1 -
5 files changed, 14 insertions(+), 10 deletions(-)

After using git bisect and ant compile test to determine whether a commit passed all of the tests, I then use the command
	
	git diff HEAD^ -- src/BasicStats.java

to see the difference from the file that was most changed. After reviewing the code I could see that the chagnes made primarily were changing the names of variables, but in doing so also accidentally changed another variable.

	for (int j = 1; j < (n - i); j++) {

	for (int j = 1; j < (size - j); j++) {

In changing the variable name n to size, they also changed i to j, which affected when the nested loop terminates. I updated the values and saw the tests passed and used this to verify that in this commit in this line of code caused the error.

### Question 5

**Question**

In interactive mode in git bisect, after how many steps (git bisect calls) did you identify the defect-inducing commit?

**Answer**

I started with the inital git bisect bad and git bisect good v1.0.0., then used

git bisect bad

git bisect bad

git bisect good

git bisect bad

git bisect bad

git bisect bad

so after 6 steps the git bisect tool identified the commit that caused the test failure.

In our git repo we personally made our own commits to the answer.md file in the repo, so there may have been an extra step in the git bisect that was used to check for the extra commits.

### Question 6

**Question**

Which git command can you use to undo the defect-inducing commit? Briefly explain what problem
may occur when undoing a commit and what best practice generally mitigates this problem.

**Answer**

At the current master branch you can create a new commit that undoes the commit previously in the commit history by doing:

	git revert f7f175dc8bc5b3693f99b2f8e799b51c0d0d9b9f

This preserves all of the commit history and changes the effects made by the erroneous commit both of which are good. It is also possible to delete the commit made by the error causing commit, but this has the consequence that it may lose important information that cannot be recovered from the commit.

### Question 7

**Question**

For the above, you used git bisect in interactive mode. Alternatively, you should now write a command ⟨cmd⟩ such that the following two calls of git bisect will automatically determine the defectinducing commit:
```sh
git bisect start HEAD v1.0.0
git bisect run ⟨cmd⟩
```
**Note:** You may write a script (instead of a single command) and call it as your command. If you do, please include the content of your script in your answer.

**Answer**

