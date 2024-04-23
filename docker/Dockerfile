FROM fedora:39

RUN dnf -y install flex bison sudo
RUN dnf -y install sudo fedpkg fedora-packager rpmdevtools ncurses-devel pesign grubby gcc-c++ ccache
# only required for older kernels 6.0.X
RUN dnf -y install gcc-plugin-devel bpftool
RUN dnf builddep -y kernel


RUN sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers

RUN useradd -s /bin/bash -G adm,wheel,systemd-journal -m rpm
RUN bash -c "echo rpm >> /etc/pesign/users"
RUN /usr/libexec/pesign/pesign-authorize
COPY docker/build.sh /build.sh
COPY docker/pathfix.py /usr/local/bin/
RUN chmod +x /usr/local/bin/pathfix.py

WORKDIR /home/rpm
USER rpm

RUN rpmdev-setuptree
WORKDIR /home/rpm/rpmbuild
RUN echo HOME=$HOME
