## CS 520 In-class exercise 3
By Patrick Walsh, Matthew Lips

Due **November 14th, 11:59pm**

---

## Questions

### Question 1

**Question**

Why does the described automated testing infrastructure not catch the defect?

**Answer**

### Question 2

**Question**

How could the developers improve the testing infrastructure (either manual or automated) to immediately notice test failures in the future?

**Answer**

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

### Question 5

**Question**

In interactive mode in git bisect, after how many steps (git bisect calls) did you identify the defect-inducing commit?

**Answer**

### Question 6

**Question**

Which git command can you use to undo the defect-inducing commit? Briefly explain what problem
may occur when undoing a commit and what best practice generally mitigates this problem.

**Answer**

### Question 7

**Question**

For the above, you used git bisect in interactive mode. Alternatively, you should now write a command ⟨cmd⟩ such that the following two calls of git bisect will automatically determine the defectinducing commit:
```sh
git bisect start HEAD v1.0.0
git bisect run ⟨cmd⟩
```
**Note:** You may write a script (instead of a single command) and call it as your command. If you do, please include the content of your script in your answer.

**Answer**

