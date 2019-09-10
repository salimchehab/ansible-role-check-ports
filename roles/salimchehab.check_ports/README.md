salimchehab.check_ports
=========

Check open ports from a bastion or jump host to other hosts.

This role will generate a bash script that can be quickly run from the bastion host to identify if the listed ports on the remote servers are open or not.

Dependencies
--------------

The `timeout` command needs to be installed and available on the host where the script will be run from.

An alternative is to have `perl` and execute the following command:
    
    # Originally found on SO: http://stackoverflow.com/questions/601543/command-line-command-to-auto-kill-a-command-after-a-certain-amount-of-time
    perl -e 'alarm shift; exec @ARGV' "$@";

Role Variables
--------------

The defaults contain the below variables to indicate where the generated script shall be placed:

    script_base_directory: "."
    script_file_path: "{{ script_base_directory }}/check_ports.sh"
    script_template: "check_ports.sh.j2"

Example Playbook
----------------

    - hosts: localhost
      vars:
        user: "{{ lookup('env','USER') }}"
        servers:
          - name: server1
            protocol: tcp
            ports:
              - 22
              - 80
              - 443
          - name: server11.my.domain
            protocol: udp
            ports:
              - 135
              - 139
          - name: 10.0.112.21
            protocol: tcp
            ports:
              - 81
      roles:
        - salimchehab.check_ports

License
-------

BSD

Author Information
------------------

@salimchehab
