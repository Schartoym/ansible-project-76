.PHONY: playbook check

# Variables
ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY = ./inventory/hosts.ini
PLAYBOOK = ./playbook.yml

# Default task when make command is run
default: playbook

# To run the Ansible Playbook
playbook:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK)

# To check the syntax of Ansible Playbook
check:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK) --check
