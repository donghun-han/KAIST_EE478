ARG BASE_IMAGE=nvidia/cuda:11.4.3-cudnn8-devel-ubuntu20.04
FROM ${BASE_IMAGE} AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
        software-properties-common ca-certificates lsb-release gnupg2 \
        wget curl git \
        build-essential cmake \
        python3-dev python3-pip \
        bash-completion vim tmux tmuxp \
        && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Install ROS
RUN bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt update && apt install -y --no-install-recommends \
        ros-noetic-desktop-full \
        python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool \
        python3-catkin-tools \
        && \
    rosdep init && rosdep update && \
    apt clean && rm -rf /var/lib/apt/lists/*

#---------------------------------------------------------------------
# Stage 3: Main ROS workspace
#---------------------------------------------------------------------
FROM base AS devel

ENV DEBIAN_FRONTEND=noninteractive
    
ARG USERNAME
ARG USER_UID
ARG USER_GID
    
# Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME
    
COPY .bashrc_custom /tmp/.bashrc_custom
RUN cat /tmp/.bashrc_custom >> /home/$USERNAME/.bashrc && rm /tmp/.bashrc_custom
    
USER $USERNAME
WORKDIR /home/$USERNAME
