FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# Set noninteractive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /whisper_streaming

# Copy project files
COPY requirements.txt /whisper_streaming/

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy project files
COPY whisper_online.py whisper_online_server.py line_packet.py entrypoint.py /whisper_streaming/

RUN mkdir /models
ENTRYPOINT [ "python3", "entrypoint.py", \
    "--backend", "faster-whisper", \
    "--host", "0.0.0.0", \
    "--port", "43001", \
    "--model_cache_dir", "/models", \
    "--language", "no"]