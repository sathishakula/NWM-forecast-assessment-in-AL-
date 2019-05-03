#!/bin/bash

email=`whoami`@auburn.edu
workdir=/***Define your own route***/
cd $workdir

mpirun -np 6 ./downloadNWM_shortrange.sh

exit 0
