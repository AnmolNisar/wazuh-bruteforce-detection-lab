# Running the Wazuh server with Docker (single node)

Good option if your laptop can't spare 8 GB for a server VM. Needs Docker + Docker Compose and ~6 GB free RAM.

```bash
# Linux hosts only: the indexer needs this
sudo sysctl -w vm.max_map_count=262144

# Pick the tag that matches the current release (see the wazuh-docker releases page)
git clone https://github.com/wazuh/wazuh-docker.git -b v4.14.0
cd wazuh-docker/single-node
docker compose -f generate-indexer-certs.yml run --rm generator
docker compose up -d
```

Dashboard: `https://localhost` (default `admin` / `SecretPassword` — change it).

To load this repo's rules, copy them into the manager container:

```bash
docker cp decoders/local_decoder.xml single-node-wazuh.manager-1:/var/ossec/etc/decoders/
docker cp rules/local_rules.xml     single-node-wazuh.manager-1:/var/ossec/etc/rules/
docker exec single-node-wazuh.manager-1 /var/ossec/bin/wazuh-control restart
```

(Container names can differ; check with `docker ps`.)
