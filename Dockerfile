FROM rust:1.70-bookworm

RUN apt-get update && \
    apt-get -y --no-install-recommends install git curl gnupg && \
    rustup component add rust-analysis rust-src rustfmt clippy && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /etc/apt/keyrings/llvm.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/llvm.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-15 main" | tee /etc/apt/sources.list.d/llvm.list > /dev/nul && \
    apt-get update && \
    apt-get -y --no-install-recommends install clang-15 llvm-15 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 1 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*