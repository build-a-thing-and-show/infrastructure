# infrastructure
This repo is for managing the infra with code.

## How to contribute
If you want to make modifications to the infrastructure, you'd have to take these steps:
- Create a development branch
- Update source code in the repo
- Update the IAM role permissions for the Terraform Github actions based on the AWS entities you want to add/remove
- Create your PR against main branch. This will automatically execute your new Terraform Plan and you would see a report comment on the PR with errors (if any)
- Get PR reviews as needed
- Merge your PR. This will apply the new infrastructure based on your new terraform code. You will have to check the status of the infrastructure in AWS account to validate the correct execution.
- The web appliciton must be running after your new infrastructure is applied. Otherwise the changes will be rolled back.




Best practice is to use separate files for each resource. For most resources, one IAM file is also required.
Configurations go to config.json file and the json file will be decoded and used in local.tf file. Most other files will use resources from local.tf file.
![Infra-archtecture](https://github.com/user-attachments/assets/29c45811-2edb-48b0-93af-131d5f14ff08)
