# check nonce Action

This GitHub Action finds all `.html` files in a given directory and checks to make sure all `nonce=""` or `nonce=` values are unique and present.\
[Nonce](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/nonce) is used by the [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) that helps to prevent or minimize the risk of certain types of security threats.

### Success

```html
<!-- will succeed when all nonce values are unique -->
<script nonce="noncevalue1">console.log("check-nonce")</script>
<script nonce="noncevalue2">console.log("check-nonce")</script>
...
<script nonce="noncevalue99">console.log("check-nonce")</script>
```

### Failure

```html
<!-- will fail if one more more nonce value is duplicated -->
<script nonce="noncevalue1">console.log("check-nonce")</script>
<script nonce="noncevalue1">console.log("check-nonce")</script>

<!-- will also fail on empty value -->
<script nonce="">console.log("check-nonce")</script>
```

> Does match on both `nonce="$VALUE"` and `nonce=$VALUE`.\
> _The symbol after the value should be ` `, `\` or `>`_.

## Usage

The following example step will query all `.html` files in the `web/public` directory.

```yml
  - name: check nonce in public
    uses: ./.github/actions/check-nonce
    with:
      directory: web/public
```

## Options

The following input variables can be configured:

|Input variable|Necessity|Description|Default|
|----|----|----|----|
|`directory`|Optional|Directory to scan for `.html` files.|`.`|
|`continue-on-failure`|Optional|If `true` the Action will proceed on error.|`false`|

## Example

The following example will query all `.html` files for the built website in the directory `public` relative to the current path.

```yml
name: website workflow

on:
  push:
    branch:
      - main

jobs:
  cicd:
    runs-on: ubuntu-latest

    steps:
    - name: checkout repository
      uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2

    - name: build website
      run: make build

    - name: check nonce
      uses: ./.github/actions/check-nonce
      with:
        directory: public

    - name: deploy website
      run: make deploy
```

# Test

Tests can be performed using [Bash Automated Testing System](https://github.com/bats-core/bats-core).

```shell
.github/actions/check-nonce $ bats check-nonce.test.bats 
check-nonce.test.bats
 ✓ Zero file should be skipped
 ✓ Empty file should be successful
 ✓ File without nonce should be successful
 ✓ File with empty nonce should trigger an error
 ✓ File with empty nonce (no quotes) should trigger an error
 ✓ Duplicate nonce should trigger an error
 ✓ Duplicate nonce (no quotes) should trigger an error
 ✓ File with unique nonces should be successful
 ✓ File with unique nonces (no quotes) should be successful

9 tests, 0 failures
```
