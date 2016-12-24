FROM hone/mruby-cli
RUN apt-get update && apt-get install -y gdb libssl-dev
