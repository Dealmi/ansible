#!/bin/bash

#ansible-playbook --become-method=sudo test.yml -vvv --ask-pass
# --ask-become-pass 

ansible-playbook --become-method=sudo test.yml -vvv --private-key=~/.ssh/id_rsa_ansible --check