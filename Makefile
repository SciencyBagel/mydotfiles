# mydotfiles — single entry point.
#
# Run `make` (or `make help`) for the list of targets.

.PHONY: help bootstrap-mac update-plugins provision provision-check syntax-check

help:
	@printf "Available targets:\n"
	@printf "  bootstrap-mac      First-time (or re-run) Mac setup: submodules + omz + symlinks\n"
	@printf "  update-plugins     Pull latest versions of oh-my-zsh plugin submodules\n"
	@printf "  provision    Run the Ansible playbook against all hosts in inventory\n"
	@printf "                     (override target group: make provision LIMIT=raspberrypis)\n"
	@printf "  provision-check    Dry-run the Ansible playbook (--check, no changes made)\n"
	@printf "  syntax-check       Validate Ansible playbook syntax\n"

bootstrap-mac:
	./scripts/bootstrap-mac.sh

update-plugins:
	./scripts/update-plugins.sh

# Ansible targets. LIMIT optionally restricts the run to a host or group.
# Must run from the ansible/ directory because ansible.cfg uses relative paths.
LIMIT ?=
ANSIBLE_PLAYBOOK = cd ansible && ansible-playbook playbooks/site.yml
LIMIT_FLAG = $(if $(LIMIT),--limit $(LIMIT),)

provision:
	$(ANSIBLE_PLAYBOOK) --ask-vault-pass $(LIMIT_FLAG)

provision-check:
	$(ANSIBLE_PLAYBOOK) --check --diff $(LIMIT_FLAG)

syntax-check:
	$(ANSIBLE_PLAYBOOK) --syntax-check
