# check nonce Action

This GitHub Action finds all `.html` files in a given directory and checks to make sure all `nonce=""` values are unique.\
[Nonce](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/nonce) is used by the [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) that helps to prevent or minimize the risk of certain types of security threats.

### Success

```html
<script nonce="1456a72431b2733d7a4e4e6dadecbcb9">console.log("check-nonce")</script>
<script nonce="cb9837a0450a4922461bde2a901b6895">console.log("check-nonce")</script>
```

### Failure

```html
<script nonce="1456a72431b2733d7a4e4e6dadecbcb9">console.log("check-nonce")</script>
<script nonce="1456a72431b2733d7a4e4e6dadecbcb9">console.log("check-nonce")</script>
```

## Usage

The following example step will query all `.html` files in the directory `src` relative to the current path.

```yml
  - name: check nonce in public
    uses: ./.github/workflows/actions/check-nonce
    with:
      directory: 'src'
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
      uses: actions/checkout@v4

    - name: build website
      run: make build

    - name: check nonce
      uses: ./.github/workflows/actions/check-nonce
      with:
        directory: 'public'

    - name: deploy website
      run: make deploy
```
