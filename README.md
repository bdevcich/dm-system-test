# dm-system-test

This is a system level (e.g. flux) test suite for verifying NNF Data Movement. The Flux workflow
manager is used to drive the testing of data movement. Since interaction with Flux is largely at the
shell level, the tests are written in bash. To drive that, a Bash Automated Testing System (Bats) is
being used. This framework packaged as part of this system test for portability.

These tests are a Work In Progress (WIP). These started as a way to verify the behavior of the
destination mkdir and index mount directory features of data movement with hopes to expand.

## Bats Framework

Bats is a TAP testing framework for bash. This allows us to write a large number of tests in bash to
verify the behavior of NNF software. You can read more about this testing framework here:
https://bats-core.readthedocs.io/en/stable/

To update bats locally, clone the repo and install it to the `bats/` directory in this repo:

```shell
git clone https://github.com/bats-core/bats-core.git
./install.sh $HOME/dm-system-test/bats/
```

## copy-in-copy-out tests

These tests make use of a markdown table to define all the expected behavior when performing data
movement when it comes to verifying the destination mkdir directory and index mount directories. The
context of these tests is complex and make it hard to keep track all of the different test cases, so
a table is used to define the test cases. This table is then converted into JSON, which can then be
looped over to dynamically create Bats tests.

This is then done for each Data Movement supported filesystem type:
    - xfs
    - gfs2
    - lustre

All tests for all filesystems can be kicked off by running:

```shell
./test-copy-in-copy-out.sh
```

You an also target one specific filesystem type by:

```shell
FS_TYPE=xfs ./copy-in-copy-out.bats
```
