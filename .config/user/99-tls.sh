export GRADLE_OPTS="-Djavax.net.ssl.trustStore=$JAVA_HOME/lib/security/cacerts"
export GRADLE_OPTS="${GRADLE_OPTS} -Djavax.net.ssl.trustStorePassword=changeit"
export GRADLE_OPTS="${GRADLE_OPTS} -Djavax.net.ssl.keyStore=$JAVA_HOME/lib/security/cacerts"
export GRADLE_OPTS="${GRADLE_OPTS} -Djavax.net.ssl.keyStorePassword=changeit"

export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
export REQUESTS_CA_BUNDLE=/usr/local/etc/openssl/cert.pem
export WEBSOCKET_CLIENT_CA_BUNDLE=/usr/local/etc/openssl/cert.pem
