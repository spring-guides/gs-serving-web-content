# Containerizing the Java Web App

This guide documents the local Docker setup for the Java version of Spring's
`gs-serving-web-content` sample. It uses the `complete/` Maven module; the other
sample modules in this repository are not included in this image.

## Project and image choices

- GitHub fork: <https://github.com/prashanth0509/gs-serving-web-content>
- Upstream sample: <https://github.com/spring-guides/gs-serving-web-content>
- Upstream license: Apache License 2.0 (see [`LICENSE.txt`](./LICENSE.txt))
- Java version: 17
- Build image: `eclipse-temurin:17-jdk-jammy`
- Runtime image: `eclipse-temurin:17-jre-jammy`
- Container listens on port `8080`.

The Dockerfile uses a multi-stage build: Maven builds and tests the application
in the JDK stage, and only the packaged JAR is copied into the smaller JRE
runtime stage. The runtime process runs as a non-root user. The Temurin tags
identify the Java and Ubuntu versions; for a production release pipeline, pin
the image references to reviewed digests and update them regularly for security
fixes.

## Prerequisites

- Docker Desktop is installed and running with the Linux container engine.
- PowerShell is open at the local repository root.

Confirm Docker is available:

```powershell
docker info
```

If this command cannot connect to the Docker daemon, start Docker Desktop and
retry before building.

## Build the image

Run these commands from the repository root:

```powershell
Set-Location .\complete
docker build --pull -t gs-serving-web-content:local .
```

The build context must be `complete/`, because its Dockerfile copies that
module's Maven wrapper, `pom.xml`, and source tree. The `mvnw` wrapper in this
checkout has Windows line endings. The Dockerfile normalizes the wrapper inside
the Linux build stage before executing it; this avoids editing the local
wrapper.

The Maven `package` command runs the module's tests before producing the
executable JAR. Wait for Docker to report a successful build before starting
the container.

## Start the container

```powershell
docker run -d --name gs-serving-web-content -p 8080:8080 gs-serving-web-content:local
```

The `-p 8080:8080` option maps port 8080 on the local computer to port 8080 in
the container. The app is available only on the local machine at
<http://localhost:8080> unless you separately configure a network or deploy it.

Check startup:

```powershell
docker ps --filter name=gs-serving-web-content
docker logs -f gs-serving-web-content
```

Wait for the log line containing `Started ServingWebContentApplication`. Press
`Ctrl+C` to stop following the logs; this does not stop the container.

## Test the web app

In another PowerShell window, request the greeting page:

```powershell
$response = Invoke-WebRequest -UseBasicParsing "http://localhost:8080/greeting?name=Pipeline"
$response.StatusCode
$response.Content
```

The status should be `200`, and the page should contain the greeting for
`Pipeline`. The default greeting is also available at
<http://localhost:8080/greeting>.

## Stop and remove the container

```powershell
docker stop gs-serving-web-content
docker rm gs-serving-web-content
```

To start the already-created container again later, use
`docker start gs-serving-web-content`. Rebuild the image after changing the
application or Dockerfile:

```powershell
Set-Location .\complete
docker build --pull -t gs-serving-web-content:local .
```

## Troubleshooting

### `docker run` says the image cannot be found

Build the image first from `complete/` and check that Docker reports success:

```powershell
docker build --pull -t gs-serving-web-content:local .
docker image ls gs-serving-web-content
```

### `./mvnw: not found` during the image build

The Linux builder cannot execute the Windows CRLF-formatted Maven wrapper
directly. Keep this line in the build stage of `complete/Dockerfile`:

```dockerfile
RUN sed -i 's/\r$//' mvnw && chmod +x mvnw
```

Then rebuild:

```powershell
docker build --pull --no-cache -t gs-serving-web-content:local .
```

### The first web request fails or ends prematurely

Spring Boot needs several seconds to start. Check its status and logs, wait for
`Started ServingWebContentApplication`, and retry:

```powershell
docker ps -a --filter name=gs-serving-web-content
docker logs gs-serving-web-content
Invoke-WebRequest -UseBasicParsing "http://localhost:8080/greeting?name=Pipeline"
```

### The container name is already in use

Stop and remove the old container before creating another one:

```powershell
docker rm -f gs-serving-web-content
```

### Local port 8080 is already in use

Map a different local port, for example `8081`, to the app's container port
`8080`, then request that local port:

```powershell
docker run -d --name gs-serving-web-content -p 8081:8080 gs-serving-web-content:local
Invoke-WebRequest -UseBasicParsing "http://localhost:8081/greeting?name=Pipeline"
```

## Upload these changes to your GitHub fork

The local repository's `origin` should be
`https://github.com/prashanth0509/gs-serving-web-content.git`. From the
repository root, review and push only the guide and container files:

```powershell
git status
git remote -v
git add CONTAINERIZATION.md complete/Dockerfile complete/.dockerignore
git diff --cached --check
git diff --cached
git commit -m "Document Java web app containerization"
git push origin main
```

Review the staged diff before committing. `git push origin main` publishes the
commit to your fork's `main` branch; it does not push to the upstream
`spring-guides` repository. No GitHub Actions workflow is added in this step.
