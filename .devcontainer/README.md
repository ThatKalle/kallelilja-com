## :whale: Using the Devcontainer

This project includes a [devcontainer](https://code.visualstudio.com/docs/devcontainers/containers) configuration for Visual Studio Code, which allows you to develop inside a containerized environment. This ensures that consistent development environment, regardless of local machine setup and configuration.

### Prerequisites

To use the devcontainer, you need to have the following installed:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker](https://www.docker.com/get-started)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code.
- [Sharing GPG Keys](https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials#_sharing-gpg-keys)

### Setup

1. Open up a new blank workspace in Visual Studio Code.\
  `"window.restoreWindows": "none"`
2. Navigate to the Remote Explorer extension.
3. Clone this repository in container volume. (Dev Volumes)
4. Launch the Dev Container.
