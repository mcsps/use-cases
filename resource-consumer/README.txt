Deployment for following resource-consumer image

https://github.com/kubernetes/kubernetes/tree/master/test/images/resource-consumer

Usage is described in the repo README.


Examples:

curl --data "millicores=300&durationSec=600" https://loadtest-pannet00.mcsps.telekomcloud.com/ConsumeCPU
ConsumeCPU
300 millicores
600 durationSec


curl --data "megabytes=300&durationSec=600" https://loadtest-pannet00.mcsps.telekomcloud.com/ConsumeMem
ConsumeMem
300 megabytes
600 durationSec
