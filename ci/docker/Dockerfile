# Build this image in the repo root directory: `docker build -f ci/docker/Dockerfile .`
#
# This is a multi-stage build, that does not include the source in the final image.
FROM rust:1.50 as builder

# Install clang to compile hunspell CXX source files
RUN apt-get update && apt-get install -y \
        clang \
        hunspell-en-us \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

# Configure LLVM and install cargo-spellcheck
RUN export LLVM_CONFIG_PATH=/usr/local/opt/llvm/bin/llvm-config \
    && cargo install --path /app cargo-spellcheck


FROM rust:1.50

# Install clang to compile hunspell CXX source files
RUN apt-get update && apt-get install -y \
        hunspell-en-us \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/cargo-spellcheck /usr/local/cargo/bin/cargo-spellcheck
COPY ci/docker/entrypoint.sh /entrypoint.sh
RUN chmod +x "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]

# Use default spellcheck path and fail with exit code 1
CMD ["--cfg", ".config/spellcheck.toml", "--code", "1"]
