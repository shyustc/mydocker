docker exec -it xxx /bin/bash

# /spinningup/spinup/utils/mpi_tools.py
# row 31
# args = ["mpirun", "--allow-run-as-root", "-np", str(n)]
python -m spinup.run ppo --hid "[32,32]" --env LunarLander-v2 --exp_name installtest --gamma 0.999 --cpu 8
