# Ansible managed
#!/bin/bash

declare -ri EXIT_CODE_SUCCESS=0
declare -ri TIMEOUT_SECONDS=1
readonly local_host_name="$(hostname)"

declare -rax device_path_list=(
    "/dev/tcp/10.10.10.10/22"
    "/dev/tcp/10.10.10.10/80"
    "/dev/tcp/10.10.10.10/443"
    "/dev/tcp/10.10.10.10/2222"
    "/dev/udp/10.1.1.1/135"
    "/dev/udp/10.1.1.1/139"
    "/dev/tcp/10.1.1.10/81"
    "/dev/tcp/10.1.1.10/2201"
)

for device_path in "${device_path_list[@]}"; do
    timeout $TIMEOUT_SECONDS bash -c "echo >${device_path}" 2>/dev/null && printf "OPEN - " || printf "CLOSED - "
    echo "${local_host_name} -> ${device_path}"
done

exit $EXIT_CODE_SUCCESS
