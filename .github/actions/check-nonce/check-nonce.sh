declare -A seen_nonces
echo "Checking for nonces in directory: ${TARGET_DIRECTORY}."

find "${TARGET_DIRECTORY}" -type f -name "*.html" | while read -r file; do
    echo "::group::Checking file: $file."
    nonces_found=false

    if [[ ! -s "$file" ]]; then
        echo "::warning::Warning: File $file is empty or cannot be read. Skipping."
        continue
    fi

    while read -r nonce_value; do
        nonce_value="${nonce_value#nonce=}"
        nonce_value="${nonce_value//\"/}"
        echo "::debug::Found nonce: '$nonce_value'"
        nonces_found=true
        if [[ -z "$nonce_value" ]]; then
            echo "Empty nonce found in file: $file."
            exit 1
        fi

        if [[ -n "${seen_nonces[$nonce_value]}" ]]; then
            echo "Duplicate nonce value '$nonce_value' found in file: $file."
            exit 1
        else
            seen_nonces["$nonce_value"]=1
        fi
    done < <(grep -oP 'nonce="?[^"\s>\\]+"?' "$file" 2>/dev/null)

    if ! $nonces_found; then
        echo "No nonces found in file: $file."
    else
        echo "Only unique nonces found in file: $file."
    fi
    echo "::endgroup::"
done
echo "Check nonce complete!"
