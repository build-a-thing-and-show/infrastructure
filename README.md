# infrastructure
This repo is for managing the infra with code.

Best practice is to use separate files for each resource. For most resources, one IAM file is also required.
Configurations go to config.json file and the json file will be decoded and used in local.tf file. Most other files will use resources from local.tf file.