#!/bin/bash
#Define date and launch clip script

  email=`whoami`@auburn.edu
  workdir=/gpfs01/hosted/fores/NWM/clip/
  cd $workdir
  
  module load ncl
  
  byesterday=$(date -d "-2 day" +%Y%m%d)
  yesterday=$(date -d "-1 day" +%Y%m%d)
  today=$(date +'%Y%m%d')
  
  #change clip date when necessary
  export CLIPDATE=$yesterday
  
  mpirun -np 1 ncl clipland.ncl>out
  mpirun -np 1 ncl clipreach.ncl>out
  
  # remove original NWM download data here
  
  exit 0
