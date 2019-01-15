#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM hawkore/openjdk:8u181

MAINTAINER hawkore

ENV VERSION=4.0.0

# install ps, required by startup script
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -yq --no-install-recommends procps curl \
  && curl -k https://repository-master.mulesoft.org/nexus/service/local/repositories/releases/content/org/mule/distributions/mule-standalone/$VERSION/mule-standalone-$VERSION.tar.gz | tar -xz -C /opt \
  && mv /opt/mule-standalone-$VERSION /opt/mule \
  && apt-get -yq purge curl \
  && apt-get -yq auto-remove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mount points.
VOLUME ["/opt/mule/logs","/opt/mule/apps","/opt/mule/domains","/opt/mule/conf","/opt/mule/work"]

# Define working directory.
WORKDIR /opt/mule

# Startup command
CMD [ "/opt/mule/bin/mule" ]

# Default http port
EXPOSE 8081
