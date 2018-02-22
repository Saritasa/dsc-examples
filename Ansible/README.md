DSC in Ansible
==============

Install Ansible in WSL
----------------------

```sh
sudo apt update
sudo apt install ansible python-pip
pip install ansible pywinrm
```

http://docs.ansible.com/ansible/latest/intro_windows.html

Test Connection
---------------

```sh
ansible -i inventory -m win_ping web
```

Execute Playbook
----------------

```sh
ansible-playbook -i inventory win_dsc_test.yml
ansible-playbook -i inventory win_iis_test.yml
```
