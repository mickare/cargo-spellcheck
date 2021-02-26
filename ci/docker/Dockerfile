FROM rust:1.50

ARG BUILD_DATE
ARG BUILD_REVISION
ARG BUILD_VERSION

# Install clang to compile hunspell CXX source files
RUN apt-get update && apt-get install -y \
        clang \
        hunspell-en-us \
    && rm -rf /var/lib/apt/lists/*

# Configure LLVM and install cargo-spellcheck
RUN export LLVM_CONFIG_PATH=/usr/local/opt/llvm/bin/llvm-config \
    && cargo install --git https://github.com/mickare/cargo-spellcheck.git --rev ${BUILD_REVISION} cargo-spellcheck

ADD ci/docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Use default spellcheck path and fail with exit code 1
CMD ["--cfg", ".config/spellcheck.toml", "--code", "1"]
