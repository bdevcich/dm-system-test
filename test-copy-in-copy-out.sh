#!/bin/bash

# Run all of the copy-in-copy-out tests for all filesystems

set -e

pushd copy-in-copy-out

FS_TYPE=gfs2 ./copy-in-copy-out.bats
FS_TYPE=xfs ./copy-in-copy-out.bats
FS_TYPE=lustre ./copy-in-copy-out.bats

# Run the same with copy offload
FS_TYPE=gfs2 COPY_OFFLOAD=y ./copy-in-copy-out.bats
FS_TYPE=lustre COPY_OFFLOAD=y ./copy-in-copy-out.bats

popd
