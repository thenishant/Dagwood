#!/bin/bash
# Bash version should >= 4 to be able to run this script.

IMAGE="thenishant/emulator"

if [ -z "$1" ]; then
    read -p "Task (build|push|all) : " TASK
else
    TASK=$1
fi

if [ -z "$2" ]; then
    read -p "Android version (5.0.1|5.1.1|6.0|7.0|7.1.1|8.0|8.1|9.0|all): " ANDROID_VERSION
else
    ANDROID_VERSION=$2
fi

declare -A list_of_levels=(
        [5.0.1]=21
        [5.1.1]=22
        [6.0]=23
        [7.0]=24
        [7.1.1]=25
        [8.0]=26
        [8.1]=27
        [9.0]=28
)

function getAndroidVersion() {
    versions=()

    if [ "$ANDROID_VERSION" == "all" ]; then
        for key in "${!list_of_levels[@]}"; do
            versions+=($key)
        done
    else
        for key in "${!list_of_levels[@]}"; do
            if [[ $key == *"$ANDROID_VERSION"* ]]; then
                versions+=($key)
            fi
        done
    fi

    # If version cannot be found in the list
    if [ -z "$versions" ]; then
        echo "Android version \"$ANDROID_VERSION\" is not found in the list or not supported! Support only version 5.0.1, 5.1.1, 6.0, 7.0, 7.1.1, 8.0, 8.1"
        exit 1
    fi

    echo "Android versions: ${versions[@]}"
}
echo "Getting android version...."
getAndroidVersion
processor=x86

function build() {

    # Build docker image
    FILE_NAME=Emulator

    for v in "${versions[@]}"; do
        # Find image type and default web browser
        if [[ "$v" == "5.0.1" ]] || [[ "$v" == "5.1.1" ]]; then
            IMG_TYPE=default
        else
            IMG_TYPE=google_apis
        fi
        echo "[BUILD] IMAGE TYPE: $IMG_TYPE"
        level=${list_of_levels[$v]}
        echo "[BUILD] API Level: $level"
        sys_img=$processor
        echo "[BUILD] System Image: $sys_img"
        image_latest="$IMAGE-$processor-$v:latest"
        echo "[BUILD] Image name: $image_latest"
        echo "[BUILD] Dockerfile: $FILE_NAME"
        docker build -t ${image_latest} --build-arg ANDROID_VERSION=${v} --build-arg API_LEVEL=${level} \
        --build-arg PROCESSOR=${processor} --build-arg SYS_IMG=${sys_img} --build-arg IMG_TYPE=${IMG_TYPE} \
        -f ${FILE_NAME} .
        docker tag ${image_latest}
    done
}

function push() {
    # Push docker image(s)
    for v in "${versions[@]}"; do
        image_version="$IMAGE-$processor-$v:$RELEASE"
        image_latest="$IMAGE-$processor-$v:latest"
        echo "[PUSH] Image name: $image_latest"
        docker push $image_latest
    done
}

case $TASK in
    build)
        build
    ;;
    push)
        push
    ;;
    all)
        test
        build
        push
    ;;
    *)
        echo "Invalid environment! Valid options: build, push, all"
    ;;
esac