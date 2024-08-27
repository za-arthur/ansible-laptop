# ansible-laptop

Install packages and configure a laptop using Ansible

# Usage

List available tasks:

```
ansible-playbook ubuntu_laptop.yml --list-tasks
```

Run tasks:

```
ansible-playbook ubuntu_laptop.yml -K
```

Run tasks by tags:

```
ansible-playbook ubuntu_laptop.yml -K --tags "common,editors"
```
