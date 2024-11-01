# GitSOPS

**GitSOPS** is a collection of GitHub Actions for managing secrets in Git repositories securely, leveraging [SOPS](https://github.com/getsops/sops) for encryption. GitSOPS enables easy and secure handling of secrets in dotenv files stored in Git by providing actions to **read**, **upsert** (add/update), and **delete** secrets.

## Features

- **Delete Secret**: Removes a specified secret from an encrypted dotenv file.
- **Read Secret**: Reads and exports secrets from an encrypted dotenv file as environment variables.
- **Upsert Secret**: Adds or updates a secret in an encrypted dotenv file.

## Usage

GitSOPS is designed as a GitHub Actions library to enable a secure, centralized secrets management system directly within GitHub workflows. It allows developers to manage secrets in Git repositories as part of a seamless CI/CD pipeline.

To use GitSOPS actions in your GitHub workflows, reference the actions in your `.github/workflows` YAML file.

### Example Usage

For a full example of GitSOPS in action, check out [gitsops-demo](https://github.com/ammarlakis/gitsops-demo), a repository that demonstrates how to use GitSOPS to manage secrets as part of a platform API that adheres to GitOps principle of using git repositories as the single source of truth.

## Inputs for Each Action

| Action         | Input             | Requirement | Description                                                                                              |
|----------------|-------------------|-------------|----------------------------------------------------------------------------------------------------------|
| **Delete**     | `secret_name`     | Required    | The name of the secret to delete.                                                                        |
|                | `secret_file_path`| Required    | The path to the `.env` file.                                                                             |
|                | `additional_args` | Optional    | Additional arguments for the `sops` command, such as specifying keys for encryption/decryption.          |
| **Read**       | `secret_file_path`| Required    | The path to the `.env` file.                                                                             |
|                | `include_pattern` | Optional    | A regex pattern to filter which secrets to include (default is `".*"` to include all).                   |
|                | `additional_args` | Optional    | Additional arguments for the `sops` command, such as specifying keys for encryption/decryption.          |
| **Upsert**     | `secret_name`     | Required    | The name of the secret to add or update.                                                                 |
|                | `secret_value`    | Required    | The value of the secret.                                                                                 |
|                | `secret_file_path`| Required    | The path to the `.env` file.                                                                             |
|                | `additional_args` | Optional    | Additional arguments for the `sops` command, such as specifying keys for encryption/decryption.          |

## Future Enhancements (TODO)

- **Automate README Generation**: Automatically generate the README file with action descriptions and parameters.
- **Add Release and Test Workflows**: Implement workflows to automate releases and testing.
- **Optimize with Pre-built Docker Images** (under consideration): Use pre-built Docker images to improve performance and reduce build time on GitHub runners.
- **Improve Logging**: Use [GitHub Actions commands](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/workflow-commands-for-github-actions#setting-a-debug-message) to set the logging message level.
- **Handle Special Charachters**: Handle special charachters in user input.

## Attribution and Disclaimer

GitSOPS is an independent project developed to manage secrets in Git repositories using [SOPS](https://github.com/getsops/sops) for encryption. **GitSOPS is not affiliated with, endorsed by, or associated with or the SOPS project.** 

GitSOPS leverages SOPS for secure encryption and decryption of secrets but is a separate toolset that integrates these capabilities into GitHub Actions for ease of use in CI/CD pipelines. For details on SOPS, please refer to the [SOPS documentation](https://github.com/getsops/sops).

## License

This project is licensed under the MIT License.

## Support Me

I create open-source code and write articles on [my website](https://ammarlakis.com) and [GitHub](https://github.com/ammarlakis), covering topics like automation, platform engineering, and smart home technology.

If you’d like to support my work (or treat my cat to a tuna can!), you can do so here:

[![Buy my cat a tuna can 😸](https://img.buymeacoffee.com/button-api/?text=Buy%20my%20cat%20a%20tuna%20can&emoji=%F0%9F%98%B8&slug=ammarlakis&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/ammarlakis)
