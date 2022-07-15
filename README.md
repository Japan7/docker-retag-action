# Remote tag Docker image action

This action tags an existing Docker image without pulling it to the CI environment.

## Inputs

### `previous-tag`

**Required** A Docker image tag that identifies the image to retag.

### `new-tags`

**Required** A space separated list of Docker tags that will be applied to the image.

### `server`

The hostname of the Docker registry server. Default `"ghcr.io"`.

### `username`

**Required** A user that has read and write access to the remote registry.

### `password`

**Required** The password for this user.

### `image`

**Required** The name of the Docker image on the remote registry.

## Example usage

```yml
uses: Japan7/docker-retag-action@v1
with:
  previous-tag: ${{ github.sha }}
  new-tags: "${{ github.ref_name }} latest"
  username: ${{ github.repository_owner }}
  password: ${{ secrets.GITHUB_TOKEN }}
  image: ${{ github.repository }}
```
