# These scripts are for deploying environment v 5.4

* Files:
    * hosts - descriptions and variables for SAS2 project
      - id's of elements (such as volumes) are taken directly from cloud.
    * server_5.4_app.sh - deploys the APP server
    * server_5.4_ma.sh - deploys the MASTER server
    * server_5.4_sl.sh - deploys the SLAVE server
    * server_5.4_bastion.sh - deploys Bastion server
    * server_5.4_dry_run.sh - runs a "dry run" where the process of deployment is simulated but no actual changes happens.
    * finalizing_tasks - what has to be done before and after deployment

* What needs to be installed and executed before running ansible scripts:
    - "sudo apt-get install awscli" - aws cli
    - "sudo apt-get install python3-boto3 python3-botocore" - dependancies of the  aws plugin 
    - "ansible-galaxy collection install amazon.aws" - installs aws plugin for ansible
    - run aws configure to set up credentials
    
