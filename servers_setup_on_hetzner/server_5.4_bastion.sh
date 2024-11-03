#!/bin/bash
ansible-playbook --private-key=~/.ssh/id_rsa_ansible --become-method=sudo server-5.4-bastion.yml -v
