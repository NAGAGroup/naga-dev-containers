ARG CUDA_VERSION

FROM nvcr.io/nvidia/cuda:$CUDA_VERSION-base-rockylinux9

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

# nvidia-container-runtime
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,utility


# libglvnd
COPY 10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json
RUN dnf install -y libglvnd-egl libglvnd-glx libglvnd-opengl libglvnd-gles libglvnd

# Setup SSH
RUN dnf install -y openssh-server rsync
RUN ssh-keygen -A

# Get access to more packages
RUN dnf install -y epel-release
RUN crb enable

# Use i3 as wm for remote graphical access
RUN dnf install -y i3

# TurboVNC + VirtualGL remote graphical access
RUN dnf install -y wget
RUN wget "https://sourceforge.net/projects/virtualgl/files/3.1/VirtualGL-3.1.x86_64.rpm/download"  -O /tmp/VirtualGL-3.1.x86_64.rpm
RUN dnf install /tmp/VirtualGL-3.1.x86_64.rpm -y
RUN wget "https://sourceforge.net/projects/turbovnc/files/3.0.3/turbovnc-3.0.3.x86_64.rpm/download" -O /tmp/turbovnc-3.0.3.x86_64.rpm
RUN dnf install /tmp/turbovnc-3.0.3.x86_64.rpm -y

# Setup User
ARG USERNAME=gpu-dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN dnf install passwd shadow-utils sudo -y

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN chpasswd $USERNAME <<< "$USERNAME:naga_is_awesome"

# Extras that I have found useful for base image
RUN sudo dnf install -y kitty-terminfo git dnf-plugins-core

USER $USERNAME

WORKDIR /home/$USERNAME

# Install bottom, a nice TUI process manager
RUN sudo dnf copr enable atim/bottom -y
RUN sudo dnf install bottom -y

# Build and install pixi from source, hopefully fixes issue with cargo panic
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path
RUN echo "export PATH=/home/$USERNAME/.cargo/bin:$PATH" >> /home/$USERNAME/.bashrc
RUN sudo dnf install perl openssl-devel gcc-toolset-12 -y
RUN source /opt/rh/gcc-toolset-12/enable && bash --login -c "cargo install --locked --git https://github.com/prefix-dev/pixi.git"

# Dev tools
COPY ./devenv /home/$USERNAME/.local/share/devenv
# RUN bash --login -c "pixi install --manifest-path /home/$USERNAME/.local/share/devenv/pixi.toml"
RUN sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/
RUN echo "eval \"\$(pixi shell-hook --manifest-path /home/$USERNAME/.local/share/devenv/pixi.toml)\"" >> /home/$USERNAME/.bashrc
RUN bash --norc -c "/home/$USERNAME/.cargo/bin/pixi add --no-install --manifest-path /home/$USERNAME/.local/share/devenv/pixi.toml cuda=$CUDA_VERSION"
RUN sudo chmod -R a+rwx /home/$USERNAME/


 # Entrypoint
COPY ./entrypoint.sh /bin/entrypoint.sh
RUN sudo chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
EXPOSE 2222
