FROM ubuntu
MAINTAINER Tom Fagerland

# This Dockerfile will NOT WORK without a volume mapped to /work.
# Please use start.sh or at least read it, understand ut, and then copy it
# in your own environment BEFORE filing a bug

VOLUME /work
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install git gcc gcc-avr avr-libc make moreutils -y
RUN git clone https://github.com/tmk/tmk_keyboard /tmk
COPY lib/* /tmk/keyboard/alps64/
RUN chmod a+x /tmk/keyboard/alps64/make.sh
RUN cd /tmk/keyboard/alps64 && patch keymap_common.h keymap_common.h.patch
