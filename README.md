## 🚀 Quick Start

```sh
docker run --name="salt-minion" --detach \
	--volume $(pwd)/salt-minion-pki/:/etc/salt/pki/minion/ \
	--volume $(pwd)/salt-conf/:/etc/salt/minion.d/ \
	salt-minion:latest
```

### Configuration

The `minion.conf` is expected to be found in `/etc/salt/minion.d/minion.conf`.
The `salt-minion-pki` dir can be empty and it will be used by Salt to genereate
the minion keys registered to the Salt master. If the minion is to survive
container restarts, the same keys and name need to be used for the Salt Master
to understand that it is not a new minion. If the keys no longer exist but the
minion was registered before, the registration will fail.

## Attribution

Code adapted from https://github.com/cdalvaro/docker-salt-master with the aim of
reusing the salt-master image build process to create a salt-minion image.

## 📃 License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
