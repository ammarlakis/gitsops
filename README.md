# GitSOPS

**GitSOPS** is a collection of GitHub Actions for managing secrets in Git repositories securely, leveraging [SOPS](https://github.com/mozilla/sops) for encryption. GitSOPS enables easy and secure handling of secrets in dotenv files stored in Git by providing actions to **read**, **upsert** (add/update), and **delete** secrets.

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

## License

This project is licensed under the MIT License.

---

GitSOPS provides a secure and automated way to manage secrets within Git repositories, utilizing SOPS for encryption and decryption. Contributions and suggestions are welcome!
