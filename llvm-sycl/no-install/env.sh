export PATH=/opt/cargo/bin:$PATH
export PATH=/opt/llvm-sycl/bin:$PATH
export LD_LIBRARY_PATH=/opt/llvm-sycl/lib:/opt/llvm-sycl/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/devenv/.pixi/envs/default/targets/x86_64-linux/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/devenv/.pixi/envs/default/targets/x86_64-linux/lib/stubs/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/devenv/.pixi/envs/default/x86_64-conda-linux-gnu/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/devenv/.pixi/envs/default/lib/:$LD_LIBRARY_PATH
eval "$(pixi shell-hook --manifest-path /opt/devenv/pixi.toml)"
