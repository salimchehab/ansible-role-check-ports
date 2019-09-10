## Ansible Role salimchehab.check_ports

We usually request some firewall changes but need a quick way to see if the ports are open or not. We might need to check from a bastion or jump host to the other hosts.

This role generates a bash script that can be quickly run from the bastion host to identify if the listed ports on the remote servers are open or not.

Make sure the `timeout` command is available on the host where the script will be running.

### Examples

I tested this on 3 Vagrant machines that were running. I opened some ports and run the script.
    
    # /etc/hosts
    10.10.10.10  awx  # VAGRANT: aebb57de0592f6090cb91744c1af6d90 (awx) / 0ac0768d-fa37-4c73-94f4-00ed8cc32660
    10.1.1.1  node01  # VAGRANT: c058ebae5ba19d2559165363aae73472 (node01) / 8c6cea49-1763-487b-9dad-6d1b4e58066d
    10.1.1.10  node10  # VAGRANT: 9620e38e1c30cbcaa232e4fdb89b72b6 (node10) / cb4e46ba-bb5a-43cd-b1f1-ed54a575fe9e

Example playbook is [here](check_ports.yml).

Playbook output:

    $ ansible-playbook check_ports.yml -v 
    No config file found; using defaults
     [WARNING]: No inventory was parsed, only implicit localhost is available
    
     [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'
    
    
    PLAY [localhost] **************************************************************************************************************************************************
    
    TASK [Gathering Facts] ********************************************************************************************************************************************
    ok: [localhost]
    
    TASK [salimchehab.check_ports : copy "check_ports.sh.j2" script template to "./check_ports.sh"] *******************************************************************
    changed: [localhost] => {"changed": true, "checksum": "a1f089b4441a47fd94ab239c04b6d7b6f6567c8f", "dest": "./check_ports.sh", "gid": 20, "group": "staff", "md5sum": "9fab4a4a72a0f3b7e33334377bd79c70", "mode": "0644", "owner": "salimchehab", "size": 645, "src": "/Users/salimchehab/.ansible/tmp/ansible-tmp-1568152316.78042-281325694139113/source", "state": "file", "uid": 501}
    
    PLAY RECAP ********************************************************************************************************************************************************
    localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

Generated bash script is [here](check_ports.sh).

Bash script output:

    $ sh check_ports.sh 
    OPEN - MacBook-Pro-2.local -> /dev/tcp/10.10.10.10/22
    OPEN - MacBook-Pro-2.local -> /dev/tcp/10.10.10.10/80
    CLOSED - MacBook-Pro-2.local -> /dev/tcp/10.10.10.10/443
    CLOSED - MacBook-Pro-2.local -> /dev/tcp/10.10.10.10/2222
    OPEN - MacBook-Pro-2.local -> /dev/udp/10.1.1.1/135
    OPEN - MacBook-Pro-2.local -> /dev/udp/10.1.1.1/139
    CLOSED - MacBook-Pro-2.local -> /dev/tcp/10.1.1.10/81
    CLOSED - MacBook-Pro-2.local -> /dev/tcp/10.1.1.10/2201
