#!/usr/bin/env bats

setup() {
    export TARGET_DIRECTORY="$(pwd)"
    TEST_FILE="${TARGET_DIRECTORY}/testfile.html"
    if [[ -f "${TEST_FILE}" ]]; then rm "${TEST_FILE}"; fi
}

@test "Empty file should be skipped" {
    touch "${TEST_FILE}"
    run ./check-nonce.sh
    [ "$status" -eq 0 ]
}

@test "File with empty nonce should trigger an error" {
    echo "<script nonce=\"\" src=\"https://localhost\"></script>" > "${TEST_FILE}"

    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Empty nonce found in file" ]]
}

@test "File with empty nonce (no quotes) should trigger an error" {
    echo "<script nonce= src=https://localhost></script>" > "${TEST_FILE}"

    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Empty nonce found in file" ]]
}

@test "Duplicate nonce should trigger an error" {
    echo "<script nonce=\"noncevalue\" src=\"https://localhost\"></script>" > "${TEST_FILE}"
    echo "<script nonce=\"noncevalue\" src=\"https://localhost\"></script>" >> "${TEST_FILE}"

    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Duplicate nonce value" ]]
}

@test "Duplicate nonce (no quotes) should trigger an error" {
    echo "<script nonce=noncevalue src=https://localhost></script>" > "${TEST_FILE}"
    echo "<script nonce=noncevalue src=https://localhost></script>" >> "${TEST_FILE}"

    run ./check-nonce.sh
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "Duplicate nonce value" ]]
}

@test "File with unique nonces should be successful" {
    echo "<script nonce=\"noncevalue1\" src=\"https://localhost\"></script>" > "${TEST_FILE}"
    echo "<script nonce=\"noncevalue2\" src=\"https://localhost\"></script>" >> "${TEST_FILE}"

    run ./check-nonce.sh
    [ "$status" -eq 0 ]
    [[ "${output}" =~ "Only unique nonces found in file" ]]
}

@test "File with unique nonces (no quotes) should be successful" {
    echo "<script nonce=noncevalue1 src=https://localhost></script>" > "${TEST_FILE}"
    echo "<script nonce=noncevalue2 src=https://localhost></script>" >> "${TEST_FILE}"
    
    run ./check-nonce.sh
    [ "$status" -eq 0 ]
    [[ "${output}" =~ "Only unique nonces found in file" ]]
}

teardown() {
    if [[ -f "${TEST_FILE}" ]]; then rm "${TEST_FILE}"; fi
}
