#!../bats/bin/bats

@test "try to copy_out from /root and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_out source=/root destination=/lus/global/testdir/dest profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "global Lustre file system" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy_in to /root and fail" {
    run flux run -l -N1 --setattr=dw="\
        #dw jobdw type=xfs capacity=10gib name=error-test \
        #dw copy_in source=/lus/global destination=/root profile=no-xattr" \
        bash -c hostname

    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_in source=/lus/global/testdir/src destination=/root/ profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "global Lustre file system" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy_in to \$DW_JOB-wrong-storage and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_in source=/lus/global destination=\$DW_JOB_wrong-storage profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "job storage instance" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy_out from \$DW_JOB-wrong-storage and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_out source=\$DW_JOB_wrong-storage destination=/lus/global profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "job storage instance" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy_in from /lus/i/dont/exist and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_in source=/lus/i/dont/exit destination=\$DW_JOB_error-test profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "global Lustre file system" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy_out to /lus/i/dont/exist and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test \
        #DW copy_in source=\$DW_JOB_error-test destination=/lus/i/dont/exist profile=no-xattr" \
        bash -c hostname
    
    [ "$status" -eq 1 ]	
    [[ "$output" =~ "workflow hit an error" ]]
    [[ "$output" =~ "global Lustre file system" ]]
    [[ "$output" =~ "not found" ]]
}

@test "try to copy offload from /root and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test" \
        bash -c 'dm-client-go -source /root -destination /lus/global/testdir/dest -profile no-xattr'
    
    [ "$status" -eq 1 ]	
    #[[ "$output" =~ "workflow hit an error" ]]
    #[[ "$output" =~ "global Lustre file system" ]]
    #[[ "$output" =~ "not found" ]]
}

@test "try to copy offload to /root and fail" {
    run flux run -l -N1 --setattr=dw="\
        #DW jobdw type=xfs capacity=10GiB name=error-test" \
        bash -c 'dm-client-go -source /lus/global/testdir/src -destination /root -profile no-xattr'
    
    [ "$status" -eq 1 ]	
    #[[ "$output" =~ "workflow hit an error" ]]
    #[[ "$output" =~ "global Lustre file system" ]]
    #[[ "$output" =~ "not found" ]]
}



