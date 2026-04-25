#!/usr/bin/env bash
# run once with password prompt
ansible-playbook playbooks/bootstrap.yml --ask-become-pass
