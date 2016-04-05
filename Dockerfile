FROM progrium/cedarish
MAINTAINER progrium "progrium@gmail.com"

ADD ./builder/ /tmp/builder
RUN mkdir -p /tmp/buildpacks && cd /tmp/buildpacks && xargs -L 1 git clone --depth=1 < /tmp/builder/buildpacks.txt

# Suppress requests for information during package configuration
# http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html#idp16688
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" openssl libssl1.0.0 libssl-dev

ENTRYPOINT ["/tmp/builder/build.sh"]
