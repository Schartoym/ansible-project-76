.PHONY: playbook check edit-vault-webservers

# Variables
ANSIBLE_PLAYBOOK = ansible-playbook
PLAYBOOK = ./playbook.yml

ANSIBLE_VAULT = ansible-vault
WEBSERVERS_VAULT = group_vars/webservers/vault.yml


# Default task when make command is run
default: playbook

# To run the Ansible Playbook
playbook:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK)

# To check the syntax of Ansible Playbook
check:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK) --check

edit-vault-webservers:
	$(ANSIBLE_VAULT)	edit	${WEBSERVERS_VAULT}