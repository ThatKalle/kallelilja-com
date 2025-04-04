#!/usr/bin/env bats

setup() {
    export TARGET_DIRECTORY="$(pwd)"
}

@test "Empty file should be skipped" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    touch "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 0 ]
}

@test "File with empty nonce should trigger an error" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce=\"\" src=\"https://localhost\"></script>" > "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Empty nonce found in file" ]]
}

@test "File with empty nonce (no quotes) should trigger an error" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce= src=https://localhost></script>" > "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Empty nonce found in file" ]]
}

@test "Duplicate nonce should trigger an error" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce=\"noncevalue\" src=\"https://localhost\"></script>" > "${TARGET_DIRECTORY}/testfile.html"
    echo "<script nonce=\"noncevalue\" src=\"https://localhost\"></script>" >> "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Duplicate nonce value" ]]
}

@test "Duplicate nonce (no quotes) should trigger an error" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce=noncevalue src=https://localhost></script>" > "${TARGET_DIRECTORY}/testfile.html"
    echo "<script nonce=noncevalue src=https://localhost></script>" >> "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Duplicate nonce value" ]]
}

@test "File with unique nonces should be successful" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce=\"noncevalue1\" src=\"https://localhost\"></script>" > "${TARGET_DIRECTORY}/testfile.html"
    echo "<script nonce=\"noncevalue2\" src=\"https://localhost\"></script>" >> "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 0 ]
    [[ "${output}" =~ "Only unique nonces found in file" ]]
}

@test "File with unique nonces (no quotes) should be successful" {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
    echo "<script nonce=noncevalue1 src=https://localhost></script>" > "${TARGET_DIRECTORY}/testfile.html"
    echo "<script nonce=noncevalue2 src=https://localhost></script>" >> "${TARGET_DIRECTORY}/testfile.html"
    run ./check-nonce.sh
    [ "$status" -eq 0 ]
    [[ "${output}" =~ "Only unique nonces found in file" ]]
}

teardown() {
    if [[ -f "${TARGET_DIRECTORY}/testfile.html" ]]; then rm "${TARGET_DIRECTORY}/testfile.html"; fi
}
