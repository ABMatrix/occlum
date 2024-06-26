#!/bin/bash
set -e

GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${GREEN}Install sysbench first${NC}"

# We use sysbench to test mysql, need to install it first
apt-get install -y sysbench

function run_benchmarks()
{
    WORKLOADS=("oltp_point_select" "oltp_write_only" "oltp_read_write")
    for item in ${WORKLOADS[@]}
    do
        echo "start to prepare for $item"
        sleep 3
        sysbench /usr/share/sysbench/$item.lua\
            --mysql-host='127.0.0.1'\
            --mysql-user=root\
            --time=60\
            --mysql-db=mysql\
            --tables=3\
            --table_size=100000\
            --rand-type=pareto\
            prepare

        echo "start to run $item"
        sleep 3
        sysbench /usr/share/sysbench/$item.lua\
            --mysql-host='127.0.0.1'\
            --mysql-user=root\
            --time=60\
            --mysql-db=mysql\
            --tables=3\
            --table_size=100000\
            --rand-type=pareto\
            --threads=2\
            --report-interval=10\
            run

        echo "start to cleanup $item"
        sleep 3
        sysbench /usr/share/sysbench/$item.lua\
            --mysql-host='127.0.0.1'\
            --mysql-user=root\
            --time=60\
            --mysql-db=mysql\
            --tables=3\
            --table_size=100000\
            --rand-type=pareto\
            --threads=2\
            --report-interval=10\
            cleanup
    done

    echo "all done"
}

echo -e "${GREEN}Run benchmarks using sysbench${NC}"

run_benchmarks
