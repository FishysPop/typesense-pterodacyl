# Typesense Pterodactyl Egg

This repository contains all the necessary files to run Typesense as a service in Pterodactyl Panel, including custom Docker images based on the official Typesense images.

## Contents

1. `typesense-egg.json` - Pterodactyl egg configuration file
2. `Dockerfile` - Docker image definition for Typesense (based on official images)
3. `typesense-server.ini` - Configuration file for Typesense server
4. `.github/workflows/build-typesense-egg.yml` - GitHub Actions workflow for building and pushing multiple versions of the Docker image

## Prerequisites

- Pterodactyl Panel installed and configured
- Docker installed on the system
- GitHub account (for using the workflow)

## Installation

### Using the Pre-built Egg

1. Download the `typesense-egg.json` file from this repository
2. Log in to your Pterodactyl Panel as an administrator
3. Navigate to the Nest section
4. Create a new egg or import an existing one
5. Import the `typesense-egg.json` file
6. Configure the egg as needed

### Building the Docker Images

The repository includes a GitHub Actions workflow that automatically builds and pushes three versions of the Docker image to ghcr.io/fishyspop/typesense:

- v30.0 (based on typesense/typesense:30.0)
- v29.0 (based on typesense/typesense:29.0)
- v28.0 (based on typesense/typesense:28.0)

You can also build the images manually using the provided Dockerfile:

```bash
# Build a specific version
docker build --build-arg TYPESENSE_VERSION=30.0 -t ghcr.io/fishyspop/typesense:30.0 .
docker build --build-arg TYPESENSE_VERSION=29.0 -t ghcr.io/fishyspop/typesense:29.0 .
docker build --build-arg TYPESENSE_VERSION=28.0 -t ghcr.io/fishyspop/typesense:28.0 .
```

### Using the GitHub Workflow

The GitHub workflow will automatically build and push three versions of the Docker image when changes are made to the main branch. To use it:

1. Fork this repository
2. Configure the necessary secrets in your GitHub repository settings
3. Push changes to the main branch to trigger the workflow

The workflow builds images based on the official Typesense images and pushes them to ghcr.io/fishyspop/typesense with the following tags:
- 30.0
- 29.0
- 28.0
- latest (for the default branch)

## Configuration

The egg provides the following configurable options:

- **Typesense API Key**: The admin API key for Typesense (minimum 10 characters)
- **Enable CORS**: Enable Cross-Origin Resource Sharing (true/false)

## Usage

Once installed, you can create a new server using this egg in Pterodactyl Panel. The server will automatically:

1. Pull the Typesense Docker image
2. Configure the server with the provided settings
3. Start the Typesense service on port 8108

## API Access

Typesense will be accessible on port 8108. You can interact with it using the Typesense API:

```bash
curl http://localhost:8108/health -H "X-TYPESENSE-API-KEY: YOUR_API_KEY"
```

## Troubleshooting

If you encounter issues:

1. Check that the API key meets the minimum length requirement
2. Verify that port 8108 is available and not blocked by a firewall
3. Check the Pterodactyl server logs for any error messages
4. Ensure the data directory has proper read/write permissions

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.