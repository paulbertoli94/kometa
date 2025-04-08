Below is your downloadable file in plain text format. You can copy the content below into a file named **README.md** and save it on your computer.

---

```
# Custom Kometa Docker Container with Webhook

This repository contains a custom version of the [kometateam/kometa](https://hub.docker.com/r/kometateam/kometa) Docker image that extends the original container by adding a webhook endpoint (using Flask) and dynamic configuration file generation via a template.

## Features

- **Webhook API Endpoint**: A `/trigger` endpoint that, when receiving a POST request, starts Kometa.
- **Dynamic Configuration**: Generates a configuration file (`config.yml`) from a template (`config.yml.tpl`) by substituting environment variables.
- **Environment Variables**: Load parameters from an environment file (`.env`).

## Prerequisites

- [Docker](https://www.docker.com) installed on your system.
- Basic knowledge of Docker, environment files, and container usage.

## Project Structure

The repository is organized as follows:

```
.
├── Dockerfile
├── requirements.txt       # Additional Python dependencies (e.g., Flask)
├── config.yml.tpl         # Template for the configuration file with placeholders
├── trigger.py             # Flask server exposing the /trigger endpoint
├── start.sh               # Startup script that generates the config file and starts trigger.py
└── .env                   # Environment file (see below)
```

## Example Environment File (.env)

Create a file named `.env` in the project root with the following content (change the values as needed):

```env
PLEX_URL=http://192.168.1.10:32400
PLEX_TOKEN=5-Emr9pzy9DhFAFwiPRc
TMDB_APIKEY=f9f6b8094098821681bd2da53ff10453
```

> **Note:** Change these values to match your actual configuration.

## Dynamic Configuration

The `config.yml.tpl` file should include placeholders for your environment variables. For example:

```yaml
# config.yml.tpl
plex_url: ${PLEX_URL}
plex_token: ${PLEX_TOKEN}
tmdb_apikey: ${TMDB_APIKEY}
```

At container startup, the `start.sh` script uses `envsubst` (from the `gettext-base` package) to generate `/config/config.yml` by replacing the placeholders with the values provided via environment variables.

## Building the Image

Build the Docker image by running:

```bash
docker build -t my-kometa-with-webhook .
```

## Running the Container

Run the container with the environment file passed as follows:

```bash
docker run --rm -it --env-file .env -p 5000:5000 my-kometa-with-webhook
```

- The environment variables defined in `.env` will be used to generate the configuration file.
- The Flask server will run on port 5000 and expose the `/trigger` endpoint.

## Using the /trigger Endpoint

To launch Kometa via the webhook, send a POST request to the `/trigger` endpoint. For example:

```bash
curl -X POST http://localhost:5000/trigger -H "Content-Type: application/json" -d '{}'
```

When the endpoint is triggered, the API will execute the command to start Kometa (e.g., `python3 /kometa.py run`), and you can view the output in the container logs.

## Customization

- **config.yml.tpl**: Modify this template file to add or update settings required by Kometa.
- **start.sh**: This script handles variable substitution and starts `trigger.py`. Customize it if you need additional startup logic.
- **trigger.py**: Extend the Flask endpoint logic for authentication, logging, or other custom behavior if required.

## Troubleshooting

- **`envsubst: command not found`**: Ensure that the `gettext-base` package (for Debian/Ubuntu) or `gettext` (for Alpine) is installed in the container. The provided Dockerfile installs `gettext-base`.
- **Configuration errors**: Verify that your `.env` file and `config.yml.tpl` are correct and that the variable names match.

## License

[Insert license information here if applicable.]

## Contact

For questions or issues, please open an issue in the repository or contact the maintainers.
```