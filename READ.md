git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch .terraform/providers/registry.terraform.io/hashicorp/aws/5.24.0/darwin_arm64/terraform-provider-aws_v5.24.0_x5'

filter-branch rewrites commit history of the mentioned branches.

--index-filter is filter for rewriting the index

git rm --cached --ignore-unmatch tensorflow.csv completely forgets the tensorflow.csv file from all commits it is present.