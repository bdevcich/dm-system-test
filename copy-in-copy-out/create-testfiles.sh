#!/usr/bin/env bash


mkdir -p /lus/global/testdir/src/job/job2
mkdir -p /lus/global/testdir/src/job2
echo "hello_there" > /lus/global/testdir/src/job/data.out
cp /lus/global/testdir/src/job/data.out /lus/global/testdir/src/job/data2.out
cp /lus/global/testdir/src/job/data.out /lus/global/testdir/src/job/job2/data3.out
cp /lus/global/testdir/src/job/data.out /lus/global/testdir/src/job2/data.out
cp /lus/global/testdir/src/job/data.out /lus/global/testdir/src/job2/data2.out

mkdir -p /lus/global/testdir/dest

# let the users group own testdir
chown -R root:users /lus/global/testdir

# make sure src isn't group writeable though (to protect it)
chmod -R g-w /lus/global/testdir/src

# make dest group writeable
chmod -R g+w /lus/global/testdir/dest/

