#!/bin/bash
# fe_hotel Build & Tomcat Deploy Script

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$PROJECT_DIR")"
MVN="$ROOT_DIR/apache-maven-3.9.6/bin/mvn"
TOMCAT_DIR="$ROOT_DIR/tomcat"
WAR_NAME="fe_hotel"

echo "=== fe_hotel Build Start ==="
cd "$PROJECT_DIR"
"$MVN" clean package -DskipTests
if [ $? -ne 0 ]; then
    echo "Build Failed!"
    exit 1
fi
echo "=== Build Complete ==="

# Stop Tomcat
echo "=== Stopping Tomcat ==="
"$TOMCAT_DIR/bin/shutdown.sh" 2>/dev/null
sleep 2

# Remove old deployment & copy WAR
echo "=== Deploying WAR ==="
rm -rf "$TOMCAT_DIR/webapps/$WAR_NAME" "$TOMCAT_DIR/webapps/$WAR_NAME.war"
cp "$PROJECT_DIR/target/$WAR_NAME-1.0.0.war" "$TOMCAT_DIR/webapps/$WAR_NAME.war"

# Start Tomcat
echo "=== Starting Tomcat ==="
"$TOMCAT_DIR/bin/startup.sh"

echo ""
echo "fe_hotel Deploy Complete! http://localhost:8080/$WAR_NAME"
