docker exec -it xxx /bin/bash

# /spinningup/spinup/utils/mpi_tools.py
# row 31
# args = ["mpirun", "--allow-run-as-root", "-np", str(n)]
python -m spinup.run ppo --hid "[32,32]" --env LunarLander-v2 --exp_name installtest --gamma 0.999 --cpu 8

# After it finishes training, watch a video of the trained policy with
python -m spinup.run test_policy data/installtest/installtest_s0

#And plot the results with
python -m spinup.run plot data/installtest/installtest_s0
