FROM gradle:jdk8-slim

USER root

# Install system packages
RUN apt-get update && apt-get install --no-install-recommends -y curl software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install nodejs && rm -rf /var/lib/apt/lists/*

# Install Android SDK
ENV ANDROID_HOME="/usr/local/android-sdk"
RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    && unzip sdk.zip \
    && rm sdk.zip \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# Install Android Build Tool and Libraries
RUN $ANDROID_HOME/tools/bin/sdkmanager --update \
    && $ANDROID_HOME/tools/bin/sdkmanager \
        "build-tools;28.0.3" \
        "platforms;android-28" \
        "platform-tools"

CMD ["/bin/bash"]
