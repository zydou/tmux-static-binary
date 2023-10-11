ARG BASEOS=xenial
FROM buildpack-deps:${BASEOS} AS base

ARG MUSL_VERSION=1.2.4
COPY build-musl.sh /root/build-musl.sh
RUN bash /root/build-musl.sh

ARG LIBEVENT_VERSION=2.1.12-stable
COPY build-libevent.sh /root/build-libevent.sh
RUN bash /root/build-libevent.sh

ARG NCURSES_VERSION=v6.4
COPY build-ncurses.sh /root/build-ncurses.sh
RUN bash /root/build-ncurses.sh

ARG TMUX_VERSION=3.3a
COPY build-tmux.sh /root/build-tmux.sh
RUN bash /root/build-tmux.sh

ARG UPX_VERSION=4.1.0
COPY upx.sh /root/upx.sh
RUN bash /root/upx.sh

FROM scratch
COPY --from=base /root/bin/tmux /tmux
COPY --from=base /root/bin/tmux-upx /tmux-upx
